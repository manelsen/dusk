=begin pod
=head1 Dusk::Gateway::Connection

WebSocket connection to Discord Gateway. Manages the full lifecycle:
connect → Hello → Identify → Ready → dispatch loop.

=head2 Usage

use Dusk::Gateway::Connection;
use Dusk::Gateway::Intents;
use Dusk::Gateway::Dispatcher;

my $conn = Dusk::Gateway::Connection.new(
token   => %*ENV<DISCORD_BOT_TOKEN>,
intents => GUILDS +| GUILD_MESSAGES +| MESSAGE_CONTENT,
);

my $dispatcher = Dusk::Gateway::Dispatcher.new(events => $conn.events);

start {
react {
whenever $dispatcher.on-message-create -> $data {
say "$data<author><username>: $data<content>";
}
}
}

await $conn.connect;

=end pod

use Cro::WebSocket::Client;
use JSON::Fast;
use Dusk::Gateway::Payload;
use Dusk::Gateway::Heartbeat;

unit class Dusk::Gateway::Connection;

#| O Token de autenticação do Bot.
has Str     $.token    is required;

#| O valor numérico que representa a soma bitwise das Intents requiridas.
has Int     $.intents  is required;

#| A URL padrão de conexão ao Gateway (versão 10, encoding JSON).
has Str     $.gateway-url = 'wss://gateway.discord.gg/?v=10&encoding=json';

#| O ID da sessão atual. Preenchido automaticamente após o evento READY.
has Str     $.session-id is rw = '';

#| A URL de reconexão cedida pelo Discord após o READY.
has Str     $.resume-gateway-url is rw = '';

#| O número de sequência atual (s) usado para ack de heartbeat e session resume.
has Int     $.sequence is rw = 0;
has         $!ws-connection;
has Dusk::Gateway::Heartbeat $!heartbeat;
has Supplier $!event-supplier = Supplier::Preserving.new;
has         &.mock-sender;     # For testing: replaces actual WS send

#| Retorna o L<Supply> (stream reativo) de eventos decodificados L<Dusk::Gateway::Payload> vindo do Gateway.
method events(--> Supply) { $!event-supplier.Supply }

#| Inicia a conexão assíncrona ao Gateway, negociando o OP_HELLO e enviando IDENTIFY/RESUME.
#| Este método roda num bloco C<start react> que perpetua o ciclo de vida.
method connect() {
    start {
        my $client = Cro::WebSocket::Client.new;
        $!ws-connection = await $client.connect($!gateway-url);

        react {
            whenever $!ws-connection.messages -> $msg {
                my $text = await $msg.body-text;
                my $data = from-json($text);
                my $payload = Dusk::Gateway::Payload.from-json($data);

                $!sequence = $payload.s if $payload.s > 0;

                given $payload.op {
                    when Dusk::Gateway::Payload::OP_HELLO {
                        self!start-heartbeat($payload.heartbeat-interval);
                        self!send-identify();
                    }
                    when Dusk::Gateway::Payload::OP_HEARTBEAT_ACK {
                        $!heartbeat.ack if $!heartbeat;
                    }
                    when Dusk::Gateway::Payload::OP_DISPATCH {
                        if $payload.t eq 'READY' {
                            $!session-id = $payload.d<session_id> // '';
                            $!resume-gateway-url = $payload.d<resume_gateway_url> // '';
                        }
                        $!event-supplier.emit($payload);
                    }
                    when Dusk::Gateway::Payload::OP_RECONNECT {
                        self!do-resume();
                    }
                    when Dusk::Gateway::Payload::OP_INVALID_SESSION {
                        if $payload.d {
                            self!do-resume();
                        } else {
                            sleep 1 + (3.rand).Int;
                            self!send-identify();
                        }
                    }
                }
            }
        }
    }
}

#| Encerra o heartbeat, fecha a conexão WebSocket de forma segura e finaliza o Supplier de eventos.
method disconnect() {
    $!heartbeat.stop if $!heartbeat;
    $!ws-connection.close if $!ws-connection;
    $!event-supplier.done;
}

method !start-heartbeat(Numeric $interval) {
    $!heartbeat = Dusk::Gateway::Heartbeat.new(
        interval      => $interval,
        send-callback => -> $payload {
            self!ws-send($payload);
        }
    );
    $!heartbeat.sequence = $!sequence;
    $!heartbeat.start;
}

method !send-identify() {
    my $payload = to-json({
            op => Dusk::Gateway::Payload::OP_IDENTIFY,
            d  => {
                token      => $!token,
                intents    => $!intents,
                properties => {
                    os      => $*DISTRO.name,
                    browser => 'Dusk',
                    device  => 'Dusk',
                }
            }
    });
    self!ws-send($payload);
}

method !do-resume() {
    my $payload = to-json({
            op => Dusk::Gateway::Payload::OP_RESUME,
            d  => {
                token      => $!token,
                session_id => $!session-id,
                seq        => $!sequence,
            }
    });
    self!ws-send($payload);
}

method !ws-send(Str $payload) {
    if &!mock-sender {
        &!mock-sender($payload);
    } else {
        $!ws-connection.send($payload) if $!ws-connection;
    }
}

#| Usado internamente para testes: substitui o envio WebSocket direto por um mock injetado.
method set-mock-sender(&callback) {
    &!mock-sender = &callback;
}

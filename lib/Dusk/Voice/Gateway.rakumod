use Cro::WebSocket::Client;
use JSON::Fast;
use Dusk::Error;

unit class Dusk::Voice::Gateway;

# Gateway Opcodes (Voice)
my constant OP_IDENTIFY            = 0;
my constant OP_SELECT_PROTOCOL     = 1;
my constant OP_READY               = 2;
my constant OP_HEARTBEAT           = 3;
my constant OP_SESSION_DESCRIPTION = 4;
my constant OP_SPEAKING            = 5;
my constant OP_HEARTBEAT_ACK       = 6;
my constant OP_RESUME              = 7;
my constant OP_HELLO               = 8;
my constant OP_RESUMED             = 9;

#| Voice Gateway endpoint URL (from VOICE_SERVER_UPDATE event).
has Str $.endpoint   is required;

#| Voice token (from VOICE_SERVER_UPDATE event).
has Str $.token      is required;

#| Session ID (from VOICE_STATE_UPDATE event).
has Str $.session-id is required;

#| Guild ID (from VOICE_SERVER_UPDATE event).
has Int $.guild-id   is required;

#| User ID of the bot.
has Int $.user-id    is required;

#| Heartbeat interval override (for testing). Set automatically from OP 8 HELLO.
has Numeric $.heartbeat-interval is rw = 0;

# Internal state — set after OP 2 READY
has Int $.ssrc       is rw = 0;
has Str $.server-ip  is rw = '';
has Int $.server-port is rw = 0;
has     @.modes;
has Blob $.secret-key is rw = Blob.new;

# Internal WS connection and heartbeat timer
has $!ws-connection;
has $!heartbeat-promise;
has $!heartbeat-active = False;
has &!mock-sender;     # For testing: replaces actual WS send

#| Set a mock sender callback (for tests). Receives JSON string each send.
method set-mock-sender(&cb) { &!mock-sender = &cb }

#| Inject a fake incoming OP payload (for tests, bypasses WebSocket).
method inject-op(Hash $payload) {
    self!handle-op($payload);
}

#| Handle close codes — raises typed exceptions for fatal codes.
method handle-close-code(Int $code) {
    given $code {
        when 4006 | 4009 {
            die Dusk::Error::VoiceSessionTimeout.new(code => $code);
        }
        default {
            die Dusk::Error::VoiceSessionTimeout.new(code => $code);
        }
    }
}

#| Connect to the Voice Gateway and complete the handshake.
#| Sends OP 0 IDENTIFY and waits for OP 2 READY and OP 4 SESSION_DESCRIPTION.
method connect(--> Promise) {
    start {
        if $!heartbeat-interval > 0 {
            # Test mode: heartbeat-interval provided externally, just send Identify
            self!send-identify();
        } else {
            # In real mode: negotiate WS and read OP 8 HELLO first
            my $client = Cro::WebSocket::Client.new;
            my $url = $!endpoint.starts-with('wss://') ?? $!endpoint !! "wss://$!endpoint/?v=4";
            $!ws-connection = await $client.connect($url);

            react {
                whenever $!ws-connection.messages -> $msg {
                    my $text = await $msg.body-text;
                    my $data = from-json($text);
                    self!handle-op($data);
                }
            }
        }
    }
}

method !handle-op(Hash $data) {
    given $data<op> {
        when OP_HELLO {
            $!heartbeat-interval = $data<d><heartbeat_interval> / 1000;
            self!send-identify();
            self.start-heartbeat();
        }
        when OP_READY {
            $!ssrc        = $data<d><ssrc>;
            $!server-ip   = $data<d><ip>;
            $!server-port = $data<d><port>;
            @!modes       = @($data<d><modes>);
        }
        when OP_SESSION_DESCRIPTION {
            $!secret-key = Blob.new(@($data<d><secret_key>));
        }
        when OP_HEARTBEAT_ACK {
            # acknowledged — no action needed
        }
    }
}

method !send-identify() {
    self!ws-send(to-json({
                op => OP_IDENTIFY,
                d  => {
                    server_id  => ~$!guild-id,
                    user_id    => ~$!user-id,
                    session_id => $!session-id,
                    token      => $!token,
                }
    }));
}

#| Send OP 1 SELECT_PROTOCOL with the discovered public IP and port.
method send-select-protocol(Str :$ip!, Int :$port!) {
    self!ws-send(to-json({
                op => OP_SELECT_PROTOCOL,
                d  => {
                    protocol => 'udp',
                    data     => {
                        address => $ip,
                        port    => $port,
                        mode    => 'xsalsa20_poly1305',
                    }
                }
    }));
}

#| Start the Voice Gateway heartbeat timer.
method start-heartbeat() {
    $!heartbeat-active = True;
    $!heartbeat-promise = start {
        while $!heartbeat-active {
            sleep $!heartbeat-interval;
            last unless $!heartbeat-active;
            self!send-heartbeat();
        }
    }
}

#| Stop the Voice Gateway heartbeat timer.
method stop-heartbeat() {
    $!heartbeat-active = False;
}

method !send-heartbeat() {
    self!ws-send(to-json({ op => OP_HEARTBEAT, d => now.Int }));
}

method !ws-send(Str $payload) {
    if &!mock-sender {
        &!mock-sender($payload);
    } else {
        $!ws-connection.send($payload) if $!ws-connection;
    }
}

#| Close the Voice Gateway WebSocket connection.
method disconnect() {
    self.stop-heartbeat();
    $!ws-connection.close if $!ws-connection;
    $!ws-connection = Nil;
}

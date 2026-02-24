use v6.d;
use Dusk::Client;
use Dusk::Interaction::Command;
use Dusk::Interaction::Response;
use Dusk::Rest::Endpoint;
use JSON::Fast;

# Configuração (Substitua pelos seus dados)
my $token  = %*ENV<DISCORD_BOT_TOKEN> // die "Missing DISCORD_BOT_TOKEN";
my $app-id = %*ENV<DISCORD_APP_ID>    // die "Missing DISCORD_APP_ID";

my $client = Dusk::Client.new(token => $token);

# ==============================================================================
# 1. REGISTRO DO COMANDO (Rodar apenas uma vez ou quando mudar a estrutura)
# ==============================================================================
sub register-command() {
    say "[*] Construindo o Slash Command '/eco'...";
    
    my $cmd = Dusk::Interaction::Command.new(
        name        => 'eco',
        description => 'Repete o que você disser',
    ).add-option(
        name        => 'mensagem',
        description => 'O texto que o bot vai repetir',
        type        => OPTION_STRING,
        required    => True,
    );

    # Cadastra o comando globalmente no Discord via API REST
    my $route = Dusk::Rest::Endpoint.post-applications-commands(
        application-id => $app-id,
        body           => $cmd.to-hash
    );

    say "[*] Enviando payload para a API do Discord...";
    my $res = await $client.rest.request($route);
    say "[+] Comando registrado com sucesso! (ID: $res<id>)";
}

# ==============================================================================
# 2. OUVINDO E RESPONDENDO (O Loop Principal do Bot)
# ==============================================================================
sub start-bot() {
    say "[*] Conectando ao Gateway do Discord...";
    
    react {
        # Ouve todos os eventos de interação (Slash Commands, Botões, etc)
        whenever $client.dispatcher.on-interaction-create -> $interaction {
            
            # Garante que é um Slash Command (type 2)
            if $interaction.type == 2 {
                my $cmd-name = $interaction.data<name>;
                say "[Gateway] Usuário usou o comando: /$cmd-name";
                
                # Roteia para a lógica do '/eco'
                if $cmd-name eq 'eco' {
                    # Extrai o valor do argumento "mensagem"
                    my $options = $interaction.data<options>[0];
                    my $texto-usuario = $options<value>;

                    # Constrói a resposta oficial
                    my $response = Dusk::Interaction::Response.reply(
                        content => "Você disse: **$texto-usuario**",
                        ephemeral => False # Se True, só o usuário que digitou vê a resposta
                    );

                    # Envia de volta pro Discord
                    my $route = Dusk::Rest::Endpoint.post-interactions-callback(
                        interaction-id    => $interaction.id,
                        interaction-token => $interaction.token,
                        body              => $response.to-hash
                    );
                    
                    await $client.rest.request($route);
                    say "[+] Resposta enviada!";
                }
            }
        }
        
        whenever $client.dispatcher.on-ready -> $ready {
            say "[+] Bot online como " ~ $ready.user.username;
        }
    }
}

# Descomente para registrar o comando na sua conta de Bot
# await register-command();

# Inicia a escuta infinita
await $client.connect();
start-bot();

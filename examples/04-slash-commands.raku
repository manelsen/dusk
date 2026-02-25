use v6.d;
use Dusk::Client;
use Dusk::Interaction::Command;
use Dusk::Interaction::Response;
use Dusk::Rest::Endpoint;
use JSON::Fast;

# Configuration (Replace with your own data)
my $token  = %*ENV<DISCORD_BOT_TOKEN> // die "Missing DISCORD_BOT_TOKEN";
my $app-id = %*ENV<DISCORD_APP_ID>    // die "Missing DISCORD_APP_ID";

my $client = Dusk::Client.new(token => $token);

# ==============================================================================
# 1. COMMAND REGISTRATION (Run only once or when the structure changes)
# ==============================================================================
sub register-command() {
    say "[*] Building the '/echo' Slash Command...";
    
    my $cmd = Dusk::Interaction::Command.new(
        name        => 'echo',
        description => 'Repeats what you say',
    ).add-option(
        name        => 'message',
        description => 'The text that the bot will repeat',
        type        => OPTION_STRING,
        required    => True,
    );

    # Register the command globally on Discord via the REST API
    my $route = Dusk::Rest::Endpoint.post-applications-commands(
        application-id => $app-id,
        body           => $cmd.to-hash
    );

    say "[*] Sending payload to the Discord API...";
    my $res = await $client.rest.request($route);
    say "[+] Command registered successfully! (ID: $res<id>)";
}

# ==============================================================================
# 2. LISTENING AND RESPONDING (The Bot's Main Loop)
# ==============================================================================
sub start-bot() {
    say "[*] Connecting to the Discord Gateway...";
    
    react {
        # Listen to all interaction events (Slash Commands, Buttons, etc.)
        whenever $client.dispatcher.on-interaction-create -> $interaction {
            
            # Ensure it is a Slash Command (type 2)
            if $interaction.type == 2 {
                my $cmd-name = $interaction.data<name>;
                say "[Gateway] User used command: /$cmd-name";
                
                # Route to the '/echo' logic
                if $cmd-name eq 'echo' {
                    # Extract the value of the "message" argument
                    my $options = $interaction.data<options>[0];
                    my $user-text = $options<value>;

                    # Build the official response
                    my $response = Dusk::Interaction::Response.reply(
                        content => "You said: **$user-text**",
                        ephemeral => False # If True, only the user who typed it sees the response
                    );

                    # Send back to Discord
                    my $route = Dusk::Rest::Endpoint.post-interactions-callback(
                        interaction-id    => $interaction.id,
                        interaction-token => $interaction.token,
                        body              => $response.to-hash
                    );
                    
                    await $client.rest.request($route);
                    say "[+] Response sent!";
                }
            }
        }
        
        whenever $client.dispatcher.on-ready -> $ready {
            say "[+] Bot online as " ~ $ready.user.username;
        }
    }
}

# Uncomment to register the command on your Bot account
# await register-command();

# Start infinite listening
await $client.connect();
start-bot();

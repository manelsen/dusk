use lib '../lib';
use Dusk::Rest::Client;
use Dusk::Rest::Endpoint;
use Dusk::Model::Application;

my $token = %*ENV<DISCORD_BOT_TOKEN>;
my $guild-id = %*ENV<GUILD_ID>;

unless $token && $guild-id {
    say "DISCORD_BOT_TOKEN or GUILD_ID missing";
    exit 1;
}

my $client = Dusk::Rest::Client.new(:$token);

say "=== SMOKE TEST: INTERACTIONS (COMMAND REGISTRATION) ===";

try {
    # 1. Get current application to get ID
    say "Fetching application info...";
    my $route-app = Dusk::Rest::Endpoint.get-applications-me();
    my $app = await $client.request($route-app);
    my $app-id = $app<id>;
    say "  ✅ Application ID: $app-id";

    # 2. Register a test command in the guild
    say "Registering guild command 'smoke-test'...";
    my $route-cmd = Dusk::Rest::Endpoint.post-applications-guilds-commands(
        application-id => $app-id,
        guild-id => $guild-id,
        name => "smoke-test",
        description => "Dusk Smoke Test Command"
    );
    
    my $cmd = await $client.request($route-cmd);
    say "  ✅ Command registered with ID: {$cmd<id>}";
    
    # 3. List commands to verify
    say "Listing guild commands...";
    my $route-list = Dusk::Rest::Endpoint.get-applications-guilds-commands(
        application-id => $app-id,
        guild-id => $guild-id
    );
    my $cmds = await $client.request($route-list);
    
    if $cmds.grep({ .<name> eq 'smoke-test' }) {
        say "  ✅ Command 'smoke-test' found in guild!";
    } else {
        say "  ❌ Command 'smoke-test' not found!";
        exit 1;
    }
    
    CATCH {
        say "  ❌ Error: {$_}";
        exit 1;
    }
}

say "=== INTERACTIONS SMOKE TEST COMPLETED ===";
exit 0;

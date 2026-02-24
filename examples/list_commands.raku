#!/usr/bin/env raku
use v6.d;

# Example: List global application (slash) commands for your bot
# Usage: DISCORD_BOT_TOKEN=your_token raku examples/list_commands.raku

use lib 'lib';
use Dusk::Rest::Client;
use Dusk::Rest::Endpoint;
use Dusk::Error;

my $token = %*ENV<DISCORD_BOT_TOKEN> // die "Set DISCORD_BOT_TOKEN env var";

my $client = Dusk::Rest::Client.new(token => $token);

# First, get the bot's application ID from @me
my $me-route = Dusk::Rest::Endpoint.get-users-me();
my $me = await $client.request($me-route);
say "Bot: $me<username> (ID: $me<id>)";

# List global commands
my $cmd-route = Dusk::Rest::Endpoint.get-applications-commands(
    application-id => $me<id>
);

try {
    my @commands = await $client.request($cmd-route);
    if @commands.elems == 0 {
        say "No global commands registered.";
    } else {
        say "Global commands ({@commands.elems}):";
        for @commands -> $cmd {
            say "  /$cmd<name> — $cmd<description>";
        }
    }
    CATCH {
        when Dusk::Error::Unauthorized { say "Invalid bot token" }
        default                        { say "Error: $_" }
    }
}

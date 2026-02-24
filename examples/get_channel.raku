#!/usr/bin/env raku
use v6.d;

# Example: Fetch information about a Discord channel
# Usage: DISCORD_BOT_TOKEN=your_token raku examples/get_channel.raku <channel-id>

use lib 'lib';
use Dusk::Rest::Client;
use Dusk::Rest::Endpoint;
use Dusk::Error;

my $token = %*ENV<DISCORD_BOT_TOKEN> // die "Set DISCORD_BOT_TOKEN env var";
my $channel-id = @*ARGS[0] // die "Usage: raku examples/get_channel.raku <channel-id>";

my $client = Dusk::Rest::Client.new(token => $token);
my $route = Dusk::Rest::Endpoint.get-channel(channel-id => $channel-id);

try {
    my $channel = await $client.request($route);
    say "Channel: $channel.name (ID: $channel.id, Type: $channel.type)";
    CATCH {
        when Dusk::Error::NotFound     { say "Channel not found: $channel-id" }
        when Dusk::Error::Forbidden    { say "No permission to view this channel" }
        when Dusk::Error::Unauthorized { say "Invalid bot token" }
        default                        { say "Error: $_" }
    }
}

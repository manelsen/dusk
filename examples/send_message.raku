#!/usr/bin/env raku
use v6.d;

# Example: Send a message to a Discord channel
# Usage: DISCORD_BOT_TOKEN=your_token raku examples/send_message.raku <channel-id> "Hello!"

use lib 'lib';
use Dusk::Rest::Client;
use Dusk::Rest::Endpoint;
use Dusk::Error;

my $token = %*ENV<DISCORD_BOT_TOKEN> // die "Set DISCORD_BOT_TOKEN env var";
my $channel-id = @*ARGS[0] // die "Usage: raku examples/send_message.raku <channel-id> <message>";
my $content = @*ARGS[1] // "Hello from Dusk!";

my $client = Dusk::Rest::Client.new(token => $token);
my $route = Dusk::Rest::Endpoint.post-channels-messages(
    channel-id => $channel-id,
    body => { content => $content }
);

try {
    my $msg = await $client.request($route);
    say "Sent message $msg<id> to channel $channel-id";
    CATCH {
        when Dusk::Error::Forbidden    { say "Bot lacks SEND_MESSAGES permission" }
        when Dusk::Error::NotFound     { say "Channel $channel-id not found" }
        when Dusk::Error::Unauthorized { say "Invalid bot token" }
        default                        { say "Error: $_" }
    }
}

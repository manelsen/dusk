use lib '../lib';
use Dusk::Gateway::Connection;
use Dusk::Gateway::Intents;
use Dusk::Gateway::Dispatcher;

my $token = %*ENV<DISCORD_BOT_TOKEN>;
unless $token {
    say "DISCORD_BOT_TOKEN missing";
    exit 1;
}

say "=== SMOKE TEST: GATEWAY CONNECTION ===";

my $conn = Dusk::Gateway::Connection.new(
    :$token,
    intents => GUILDS +| GUILD_MESSAGES,
);

my $promise = Promise.new;
my $timeout = Promise.in(15);

my $dispatcher = Dusk::Gateway::Dispatcher.new(events => $conn.events);

%*ENV<DUSK_DEBUG> = 1;

start {
    react {
        whenever $conn.events -> $payload {
            say "  DEBUG: Event received in test: {$payload.t // 'OP ' ~ $payload.op}";
            if $payload.t eq 'READY' {
                say "  ✅ READY event received!";
                say "  🆔 Session ID: $conn.session-id()";
                $promise.keep(True);
                done;
            }
        }
        whenever $timeout {
            say "  ❌ Timeout waiting for READY event";
            $promise.keep(False);
            done;
        }
    }
}

say "Connecting to Gateway...";
await $conn.connect;

my $success = await $promise;
$conn.disconnect;

if $success {
    say "  ✅ Gateway connection verified!";
    exit 0;
} else {
    say "  ❌ Gateway connection failed!";
    exit 1;
}

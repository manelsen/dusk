#!/usr/bin/env raku
# Dusk — Text & UI Smoke Test Suite Runner
#
# Usage:
#   DISCORD_BOT_TOKEN=... TEXT_CHANNEL_ID=... GUILD_ID=... raku run-all.raku
#
# Environment variables:
#   DISCORD_BOT_TOKEN   — Bot token (required)
#   TEXT_CHANNEL_ID     — ID of a text channel where the bot has permissions (required)
#   GUILD_ID            — Server ID (required)

use lib '../../lib';
use JSON::Fast;

my $token      = %*ENV<DISCORD_BOT_TOKEN> or die "DISCORD_BOT_TOKEN missing";
my $channel-id = %*ENV<TEXT_CHANNEL_ID>   or die "TEXT_CHANNEL_ID missing";
my $guild-id   = %*ENV<GUILD_ID>          or die "GUILD_ID missing";

my @smoke-files = $*PROGRAM.parent.dir
    .grep({ .basename ~~ /^'smoke-'/ && .basename.ends-with('.raku') })
    .sort({ .basename });

say "═" x 65;
say "  Dusk  ·  Text & UI  ·  Smoke Test Suite";
say "  Channel: $channel-id  ·  Guild: $guild-id";
say "═" x 65;
say "  {+@smoke-files} tests found\n";

my @results;

for @smoke-files -> $f {
    printf "  %-38s", $f.basename;
    my $t0 = now;
    my $proc = run 'raku', '-I../../lib',
        $f.absolute,
        :env(%*ENV),
        :out, :err,
        :merge;          # stderr → stdout
    my $elapsed = now - $t0;
    my $ok      = $proc.exitcode == 0;
    my $output  = $proc.out.slurp;

    printf "%s  %.2fs\n", ($ok ?? '✅' !! '❌'), $elapsed;

    # Show last lines of output if it failed
    if !$ok {
        for $output.lines.tail(4) -> $line {
            say "    │ $line";
        }
    }

    @results.push: { name => $f.basename, passed => $ok, elapsed => $elapsed, output => $output };
}

my $passed = @results.grep(*<passed>).elems;
my $total  = @results.elems;

say "\n" ~ "─" x 65;
printf "  %d/%d passed  ·  %.2fs total\n",
    $passed, $total, @results.map(*<elapsed>).sum;
say "─" x 65;
exit $passed == $total ?? 0 !! 1;

#!/usr/bin/env raku
# Dusk Voice Engine — Smoke Test Runner
# Descobre e executa todos os smoke tests em smoke-*.raku

use lib '../../lib', 'lib';

my $token      = %*ENV<DISCORD_BOT_TOKEN> or die "DISCORD_BOT_TOKEN ausente";
my $guild-id   = %*ENV<GUILD_ID>          or die "GUILD_ID ausente";
my $channel-id = %*ENV<VOICE_CHANNEL_ID>  or die "VOICE_CHANNEL_ID ausente";
my $channel-id-2 = %*ENV<VOICE_CHANNEL_ID_2> // '';  # opcional para smoke-channel-move

my @tests = $*PROGRAM.parent.dir.grep({ .basename ~~ /^'smoke-'/ && .basename.ends-with('.raku') })
            .sort({ .basename });

say "=" x 70;
say "  Dusk Voice Engine — Smoke Test Suite";
say "  Canal:  $channel-id  |  Guild: $guild-id";
say "=" x 70;
say "  {+@tests} testes encontrados\n";

my @results;
for @tests -> $test {
    print "  Rodando {$test.basename} ... ";
    my $t0  = now;
    my $out = run 'raku', '-Ilib', '-I../../lib', $test.Str,
        :env(%*ENV),
        :out, :err;
    my $elapsed = now - $t0;
    my $stdout  = $out.out.slurp;
    my $ok      = $out.exitcode == 0;
    say $ok ?? "✅ ({elapsed.fmt('%.1f')}s)" !! "❌";
    @results.push: {
        name    => $test.basename,
        passed  => $ok,
        elapsed => $elapsed,
        output  => $stdout,
    };
}

say "\n" ~ "─" x 70;
say "  RESULTADO FINAL";
say "─" x 70;
for @results -> $r {
    my $icon = $r<passed> ?? '✅' !! '❌';
    printf "  %s  %-35s  %.2fs\n", $icon, $r<name>, $r<elapsed>;
}

my $passed = @results.grep(*<passed>).elems;
my $total  = @results.elems;
say "─" x 70;
say "  $passed/$total testes passaram\n";

exit $passed == $total ?? 0 !! 1;

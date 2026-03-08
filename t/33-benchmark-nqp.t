use v6.d;
use Test;
use Dusk::Internal::Parser;
use Dusk::Model::Guild;
use JSON::Fast;

plan 3;

# Carregar fixture real do Accord.jl
my $fixture-path = '/home/micelio/git/Accord.jl/test/integration/fixtures/gateway_guild_create.json';
my $raw-json = from-json($fixture-path.IO.slurp);
my $guild-payload = $raw-json[0]<d>;
my $json-string = to-json($guild-payload);

diag "Mode: NQP";
diag "Payload Size: {($json-string.encode.elems / 1024).Rat.round(0.1)} KB";

my $parser = Dusk::Internal::Parser.new(mode => ModeNQP);

subtest 'NQP Accuracy' => {
    my $guild = $parser.parse($json-string, model => Dusk::Model::Guild);
    ok $guild ~~ Dusk::Model::Guild, "Parsed into Guild object";
    is $guild.name, $guild-payload<name>, "Name matches: {$guild.name}";
};

subtest 'NQP Performance' => {
    my $start = now;
    for 1..100 {
        $parser.parse($json-string, model => Dusk::Model::Guild);
    }
    my $end = now;
    my $total = $end - $start;
    diag "100 iterations took {$total.round(0.001)}s ({($total / 100).round(0.0001)}s/op)";
    pass "Benchmark finished";
};

subtest 'NQP Throughput Estimation' => {
    my $start = now;
    my $bytes = 0;
    my $count = 0;
    while now - $start < 2 {
        $parser.parse($json-string, model => Dusk::Model::Guild);
        $bytes += $json-string.encode.elems;
        $count++;
    }
    my $end = now;
    my $mb-per-sec = ($bytes / (1024 * 1024)) / ($end - $start);
    diag "Estimated Throughput: {$mb-per-sec.round(0.1)} MB/s";
    diag "Events per second: {($count / ($end - $start)).Int}";
    pass "Throughput test finished";
};

done-testing;

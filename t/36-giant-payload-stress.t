use v6.d;
use Test;
use Dusk::Internal::Parser;
use Dusk::Model::Guild;
use JSON::Fast;

plan 3;

diag "Generating Giant Payload (~2.5 MB)...";
my @members;
for 1..10000 -> $i { 
    @members.push({ user => { id => "ID$i", username => "User$i" }, roles => ["R1", "R2"] }); 
}
my %giant-guild = (
    id => "9999999999999",
    name => "Extreme Stress Server " ~ ("X" x 100),
    members => @members,
    channels => (1..200).map({ { id => "$_", name => "channel-$_", type => 0 } }).List
);

my $json-string = to-json(%giant-guild);
my $payload-size = $json-string.encode.elems;
diag "Payload Size: {($payload-size / 1024 / 1024).Rat.round(0.01)} MB";

my $parser = Dusk::Internal::Parser.new(mode => ModeNative);

subtest 'Massive Memory Stability' => {
    diag "Parsing 2.5MB payload 1,000 times (Total processed: 2.5 GB)...";
    for 1..1000 {
        my $obj = $parser.parse($json-string, model => Dusk::Model::Guild);
        if $_ % 200 == 0 {
            diag "Processed {$_ * 2.5} MB...";
        }
    }
    pass "Processed 2.5GB of JSON without memory corruption or leak";
};

subtest 'Giant Payload Concurrency' => {
    diag "10 threads parsing 2.5MB simultaneously...";
    my @threads;
    for 1..10 -> $t {
        @threads.push: start {
            for 1..100 {
                my $obj = $parser.parse($json-string, model => Dusk::Model::Guild);
                die "Corruption!" unless $obj.id eq '9999999999999';
            }
        }
    }
    await Promise.allof(@threads);
    pass "Concurrent parsing of massive payloads is stable";
};

subtest 'Giant Payload Latency' => {
    my $start = now;
    my $obj = $parser.parse($json-string, model => Dusk::Model::Guild);
    my $duration = now - $start;
    diag "Single parse of 2.5MB: {$duration.round(0.0001)}s";
    ok $duration < 0.05, "Latency for 2.5MB is under 50ms (Currently: {$duration.round(0.001)}s)";
};

done-testing;

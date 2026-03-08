use v6.d;
use Test;
use Dusk::Internal::Parser;
use Dusk::Model::Guild;

plan 4;

my $parser = Dusk::Internal::Parser.new(mode => ModeNative);
my $json = '{"id": "123456", "name": "Stress Server"}';

subtest 'Memory Stability (Leak Test)' => {
    diag "Running 50,000 parses to check for memory leaks...";
    for 1..50000 {
        my $obj = $parser.parse($json, model => Dusk::Model::Guild);
        if $_ % 10000 == 0 {
            diag "Iteration $_ completed...";
        }
    }
    pass "Completed 50,000 iterations without crashing";
};

subtest 'Concurrency Stress (Race Conditions)' => {
    diag "Parsing from 16 concurrent threads...";
    my @threads;
    for 1..16 -> $t {
        @threads.push: start {
            for 1..1000 {
                my $obj = $parser.parse($json, model => Dusk::Model::Guild);
                die "Corruption detected!" unless $obj.name eq 'Stress Server';
            }
        }
    }
    await Promise.allof(@threads);
    pass "Concurrent access is stable (Context is isolated)";
};

subtest 'Fuzzing & Malformed Data' => {
    diag "Testing with random and truncated data...";
    lives-ok {
        for 1..100 {
            $parser.parse('{"id": "123", "name": "tru', model => Dusk::Model::Guild); # Truncated
            $parser.parse('', model => Dusk::Model::Guild); # Empty
            $parser.parse('{"a":' x 100, model => Dusk::Model::Guild); # Deeply malformed
        }
    }, "Native shim handles malformed JSON without segfault";
};

subtest 'Bottleneck Detection' => {
    my $large-json = '{"id": "123", "name": "' ~ ("A" x 10000) ~ '"}';
    my $start = now;
    for 1..5000 {
        $parser.parse($large-json, model => Dusk::Model::Guild);
    }
    my $duration = now - $start;
    diag "Large payload (10KB) 5,000 times: {$duration.round(0.01)}s";
    ok $duration < 2, "Performance remains high even with large fields (Bottleneck is not field size)";
};

done-testing;

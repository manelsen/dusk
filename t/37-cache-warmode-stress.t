use v6.d;
use Test;
use Dusk::Cache;
use Dusk::Cache::WarMode;

plan 2;

my $iterations = 10000;
my $threads = 32;

subtest 'Global Cache Contention' => {
    my $cache = Dusk::Cache.new;
    my $start = now;
    
    my @promises;
    for 1..$threads -> $t {
        @promises.push: start {
            for 1..$iterations {
                $cache.put-user("USER$_", { name => "test" });
                $cache.get-user("USER$_");
            }
        }
    }
    await Promise.allof(@promises);
    my $duration = now - $start;
    diag "Global Cache with $threads threads: {$duration.round(0.01)}s";
    pass "Finished global cache stress";
};

subtest 'WarMode Cache Contention' => {
    my $cache = Dusk::Cache::WarMode.new;
    my $start = now;
    
    my @promises;
    for 1..$threads -> $t {
        @promises.push: start {
            for 1..$iterations {
                $cache.put-user("USER$_", { name => "test" });
                $cache.get-user("USER$_");
            }
        }
    }
    await Promise.allof(@promises);
    my $duration = now - $start;
    diag "WarMode Cache with $threads threads: {$duration.round(0.01)}s";
    pass "Finished WarMode cache stress";
};

done-testing;

use v6.d;
use Test;
use Dusk::Rest::RateLimiter;

plan 3;

subtest 'Bucket Lifecycle' => {
    my $limiter = Dusk::Rest::RateLimiter.new;
    my $bucket = 'test-bucket';

    # 1. Initial acquire should be immediate
    my $p1 = $limiter.acquire($bucket);
    is $p1.status, Kept, 'First acquire is immediate';

    # 2. Update state: 1 remaining, reset in 1 second
    $limiter.update($bucket, {
        'x-ratelimit-remaining' => '1',
        'x-ratelimit-reset-after' => '1'
    });

    my $p2 = $limiter.acquire($bucket);
    is $p2.status, Kept, 'Second acquire (1 remaining) is immediate';

    # 3. Third acquire should wait
    my $p3 = $limiter.acquire($bucket);
    is $p3.status, Planned, 'Third acquire (0 remaining) is planned (waiting)';

    # Wait for reset
    sleep 1.2;
    is $p3.status, Kept, 'Third acquire resolves after reset time';
};

subtest 'Global Lockout' => {
    my $limiter = Dusk::Rest::RateLimiter.new;
    
    my $p1 = $limiter.acquire('any');
    is $p1.status, Kept, 'Acquire before global lockout';

    $limiter.global-wait(0.5);
    
    my $p2 = $limiter.acquire('any');
    is $p2.status, Planned, 'Acquire during global lockout is planned';
    
    sleep 0.6;
    is $p2.status, Kept, 'Acquire resolves after global lockout';
};

subtest 'Concurrent Bursts' => {
    my $limiter = Dusk::Rest::RateLimiter.new;
    my $bucket = 'burst-bucket';
    
    $limiter.update($bucket, {
        'x-ratelimit-limit' => '5',
        'x-ratelimit-remaining' => '5',
        'x-ratelimit-reset-after' => '10'
    });

    my @promises;
    for 1..10 {
        @promises.push($limiter.acquire($bucket));
    }

    my $kept = @promises.grep({ .status == Kept }).elems;
    my $planned = @promises.grep({ .status == Planned }).elems;

    is $kept, 5, '5 requests allowed immediately';
    is $planned, 5, '5 requests queued';
};

done-testing;

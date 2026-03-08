use v6.d;
use Test;
use Dusk::Rest::Client;
use Dusk::Rest::Route;

plan 1;

subtest 'Proactive Rate Limiting Integration' => {
    my $client = Dusk::Rest::Client.new(token => 'test');
    my $call-count = 0;
    my $bucket = 'proactive-bucket';

    $client.set-mock-dispatcher(sub ($method, $url, %headers, %body) {
        $call-count++;
        if $call-count == 1 {
            return {
                status => 200,
                headers => {
                    'x-ratelimit-bucket' => $bucket,
                    'x-ratelimit-limit' => '2',
                    'x-ratelimit-remaining' => '1',
                    'x-ratelimit-reset-after' => '1.0'
                },
                body => { result => 'ok' }
            };
        } elsif $call-count == 2 {
            return {
                status => 200,
                headers => {
                    'x-ratelimit-bucket' => $bucket,
                    'x-ratelimit-limit' => '2',
                    'x-ratelimit-remaining' => '0',
                    'x-ratelimit-reset-after' => '1.0'
                },
                body => { result => 'ok' }
            };
        } else {
            return {
                status => 200,
                body => { result => 'delayed-ok' }
            };
        }
    });

    my $route = Dusk::Rest::Route.new(method => 'GET', path => '/test');
    
    my $start = now;
    await $client.request($route); # Call 1: Immediate
    await $client.request($route); # Call 2: Immediate
    
    my $mid = now;
    diag "First two calls took {$mid - $start}s";
    ok $mid - $start < 0.5, 'First two calls were immediate';

    await $client.request($route); # Call 3: Should WAIT 1s PROACTIVELY
    my $end = now;
    diag "Third call finished at {$end - $start}s";
    ok $end - $start >= 1.0, 'Third call was proactively delayed';
    is $call-count, 3, 'Third call eventually reached the dispatcher';
};

done-testing;

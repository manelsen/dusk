use v6.d;
use Test;

plan 3;

use Dusk::Rest::Client;
use Dusk::Rest::Endpoint;
use Dusk::Error;

subtest 'Rate Limit Retry: Client retries on 429' => {
    my $attempt-count = 0;
    
    my $client = Dusk::Rest::Client.new(token => 'test-token');
    $client.set-mock-dispatcher(-> $method, $url, %headers, $body {
        $attempt-count++;
        if $attempt-count == 1 {
            { status => 429, body => { message => 'Rate limited', retry_after => 0.01 } }
        } else {
            { status => 200, body => { id => '123', username => 'bot' } }
        }
    });
    
    my $route = Dusk::Rest::Endpoint.get-users-me();
    my $res = await $client.request($route);
    
    is $attempt-count, 2, 'Client retried after 429';
    is $res<id>, '123', 'Second attempt returned valid data';
};

subtest 'Rate Limit Exhaustion: Client gives up after max retries' => {
    my $attempt-count = 0;
    
    my $client = Dusk::Rest::Client.new(token => 'test-token');
    $client.set-mock-dispatcher(-> $method, $url, %headers, $body {
        $attempt-count++;
        { status => 429, body => { message => 'Rate limited', retry_after => 0.01 } }
    });
    
    my $route = Dusk::Rest::Endpoint.get-users-me();
    # After 3 retries the mock still returns 429, so Client should eventually
    # process the 429 as a non-200 status and throw an error
    dies-ok { await $client.request($route) }, 'Client dies after exhausting retries';
};

subtest 'Rate Limit: Retry-After header is respected' => {
    my $start-time;
    my $attempt-count = 0;
    
    my $client = Dusk::Rest::Client.new(token => 'test-token');
    $client.set-mock-dispatcher(-> $method, $url, %headers, $body {
        $attempt-count++;
        if $attempt-count == 1 {
            $start-time = now;
            { status => 429, body => { retry_after => 0.1 } }
        } else {
            { status => 200, body => { id => '1', username => 'bot' } }
        }
    });
    
    my $route = Dusk::Rest::Endpoint.get-users-me();
    my $res = await $client.request($route);
    
    my $elapsed = now - $start-time;
    ok $elapsed >= 0.05, "Client waited at least 50ms before retry (got {$elapsed.fmt('%.3f')}s)";
};

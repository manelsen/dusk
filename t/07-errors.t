use v6.d;
use Test;

plan 4;

use Dusk::Rest::Client;
use Dusk::Rest::Endpoint;
use Dusk::Error;

subtest 'Error 401: Unauthorized throws typed exception' => {
    my $client = Dusk::Rest::Client.new(token => 'invalid-token');
    $client.set-mock-dispatcher(-> $method, $url, %headers, $body {
        { status => 401, body => { message => 'Unauthorized', code => 0 } }
    });
    
    my $route = Dusk::Rest::Endpoint.get-users-me();
    
    throws-like { await $client.request($route) },
        Dusk::Error::Unauthorized,
        'Throws Unauthorized on 401';
};

subtest 'Error 403: Forbidden throws typed exception' => {
    my $client = Dusk::Rest::Client.new(token => 'test-token');
    $client.set-mock-dispatcher(-> $method, $url, %headers, $body {
        { status => 403, body => { message => 'Missing Permissions', code => 50013 } }
    });
    
    my $route = Dusk::Rest::Endpoint.get-guilds-channels(guild-id => '123');
    
    throws-like { await $client.request($route) },
        Dusk::Error::Forbidden,
        'Throws Forbidden on 403';
};

subtest 'Error 404: NotFound throws typed exception with path' => {
    my $client = Dusk::Rest::Client.new(token => 'test-token');
    $client.set-mock-dispatcher(-> $method, $url, %headers, $body {
        { status => 404, body => { message => 'Unknown Channel', code => 10003 } }
    });
    
    my $route = Dusk::Rest::Endpoint.get-channel(channel-id => '999999');
    
    throws-like { await $client.request($route) },
        Dusk::Error::NotFound,
        'Throws NotFound on 404';
};

subtest 'Error 500: APIError throws with status code' => {
    my $client = Dusk::Rest::Client.new(token => 'test-token');
    $client.set-mock-dispatcher(-> $method, $url, %headers, $body {
        { status => 500, body => { message => 'Internal Server Error' } }
    });
    
    my $route = Dusk::Rest::Endpoint.get-users-me();
    
    throws-like { await $client.request($route) },
        Dusk::Error::APIError,
        'Throws APIError on 500';
};

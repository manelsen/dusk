use v6.d;
use Test;

plan 1;

use Dusk::Rest::Client;
use Dusk::Rest::Endpoint;
use JSON::Fast;

# We use a mocked Cro::HTTP::Client to avoid hitting the actual network (Gate 04 rules)
# We test if Dusk::Rest::Client correctly calls the network and parses the Fixtures

subtest 'Client Request Flow with Fixtures (Mocked Network)' => {
    my $client = Dusk::Rest::Client.new(token => 'fake-test-token');
    
    # Mocking the network call for test
    my $mock-response-json = "t/fixtures/rest_get_channel.json".IO.slurp;
    
    # We redefine the core network dispatcher for this test block
    $client.set-mock-dispatcher(sub ($method, $url, %headers, %body?) {
        is $method, 'GET', 'Mock called with GET';
        is $url, 'https://discord.com/api/v10/channels/1071190549216657471', 'Mock called with correct URL';
        is %headers<Authorization>, 'Bot fake-test-token', 'Auth header is correctly injected';
        
        return {
            status => 200,
            body   => from-json($mock-response-json)
        };
    });

    # Execution
    my $route = Dusk::Rest::Endpoint.get-channel(channel-id => '1071190549216657471');
    my $channel = await $client.request($route);
    
    isa-ok $channel, Dusk::Model::Channel, 'Request returns parsed Model directly';
    is $channel.id, "1212124713271304246", 'Channel ID matches fixture';
    is $channel.name, "general", 'Channel Name matches fixture';
};

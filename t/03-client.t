use v6.d;
use Test;

plan 3;

use Dusk::Rest::Client;
use Dusk::Rest::Route;

# RNF-02: Security Verification
subtest 'Client Instantiation & Security' => {
    my $client = Dusk::Rest::Client.new(token => 'fake-token-123');
    isa-ok $client, Dusk::Rest::Client, 'Can create a Client';
    
    # Token must not leak in representational strings
    unlike $client.gist, /'fake-token-123'/, 'Token is NOT leaked in .gist';
    unlike $client.Str, /'fake-token-123'/, 'Token is NOT leaked in .Str';
};

subtest 'Client Initialization Errors' => {
    dies-ok { Dusk::Rest::Client.new() }, 'Requires a token to instantiate';
};

subtest 'Client Configuration' => {
    my $client = Dusk::Rest::Client.new(token => 'fake', api-version => 10);
    is $client.api-version, 10, 'Can configure API Version';
    is $client.base-url, 'https://discord.com/api/v10', 'Base URL is constructed properly';
};

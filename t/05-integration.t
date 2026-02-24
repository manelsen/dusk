use v6.d;
use Test;

# Load environment manually
if ".env".IO.f {
    for ".env".IO.lines -> $line {
        next if $line.trim eq '' || $line.starts-with('#');
        my ($k, $v) = $line.split('=', 2);
        if $k && $v {
            %*ENV{$k.trim} = $v.trim;
        }
    }
}
my $token = %*ENV<DISCORD_BOT_TOKEN>;

if !$token {
    plan 1;
    pass 'Integration tests skipped (no DISCORD_BOT_TOKEN in .env)';
    exit;
}

use Dusk::Rest::Client;
use Dusk::Rest::Endpoint;

plan 3;

subtest 'Integration - Get Current User' => {
    my $client = Dusk::Rest::Client.new(token => $token);
    my $route = Dusk::Rest::Endpoint.get-users-me();
    
    my $res = await $client.request($route);
    
    is $res<username>.defined, True, 'Current user response has a username';
    is $res<id>.defined, True, 'Current user response has an ID';
};

subtest 'Integration - Unauthenticated Request' => {
    my $client = Dusk::Rest::Client.new(token => 'invalid-token-123');
    my $route = Dusk::Rest::Endpoint.get-users-me();
    
    dies-ok { await $client.request($route) }, 'Throws HTTP Error upon invalid token';
};

subtest 'Integration - Get Global Application Commands' => {
    # Assuming Application Commands are tied to the current bot/app ID
    # Since we need the application ID, let's fetch it from @me first
    my $client = Dusk::Rest::Client.new(token => $token);
    my $me-route = Dusk::Rest::Endpoint.get-users-me();
    my $me = await $client.request($me-route);
    my $app-id = $me<id>;
    
    my $route = Dusk::Rest::Endpoint.get-applications-commands(application-id => $app-id);
    my $res = await $client.request($route);
    
    # It might return an array
    isa-ok $res, List, 'Global commands endpoint returns an array';
};

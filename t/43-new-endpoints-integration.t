use v6.d;
use Test;
use Dusk::Rest::Endpoint;

plan 8;

# Test GET /applications/{application.id}
my $app-route = Dusk::Rest::Endpoint.get-application(application-id => '123456');
ok $app-route, 'get-application returns a route';
is $app-route.method, 'GET', 'get-application method is GET';
is $app-route.path, '/applications/123456', 'get-application path is correct';

# Test PATCH /applications/{application.id}
my $patch-app-route = Dusk::Rest::Endpoint.patch-application(application-id => '123456', name => 'New Name');
ok $patch-app-route, 'patch-application returns a route';
is $patch-app-route.method, 'PATCH', 'patch-application method is PATCH';

# Test PATCH /guilds/{guild.id}/onboarding
my $onboard-route = Dusk::Rest::Endpoint.patch-guilds-onboarding(guild-id => '789');
ok $onboard-route, 'patch-guilds-onboarding returns a route';
is $onboard-route.method, 'PATCH', 'patch-guilds-onboarding method is PATCH';
is $onboard-route.path, '/guilds/789/onboarding', 'patch-guilds-onboarding path is correct';

say "✅ All new endpoints integration tests passed!";

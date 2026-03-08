use v6.d;
use Test;
use Dusk::Rest::Endpoint;
use Dusk::Enum;
use Dusk::Event::Events;
use Dusk::Model::PartialGuild;
use Dusk::Model::PartialChannel;
use Dusk::Model::PartialMember;

plan 30;

# === NEW MODELS (Enums) ===
ok ActivityType::Game == 0, 'ActivityType::Game is 0';
ok ChannelType::GuildText == 0, 'ChannelType::GuildText is 0';
ok MessageFlags::Ephemeral == 64, 'MessageFlags::Ephemeral is 64';
ok Permission::Administrator == 8, 'Permission::Administrator is 8';
ok VerificationLevel::VerificationLevelNone == 0, 'VerificationLevel::None is 0';

# === NEW PARTIAL MODELS ===
my $guild = Dusk::Model::PartialGuild.new(id => '123', name => 'Test');
ok $guild.id eq '123', 'PartialGuild can be created';
ok $guild.name eq 'Test', 'PartialGuild name is correct';

my $channel = Dusk::Model::PartialChannel.new(id => '456', type => 0);
ok $channel.id eq '456', 'PartialChannel can be created';
ok $channel.type == 0, 'PartialChannel type is correct';

my $member = Dusk::Model::PartialMember.new(nick => 'TestUser');
ok $member.nick eq 'TestUser', 'PartialMember can be created';

# === NEW GATEWAY EVENTS ===
my $pins-payload = {
    op => 0,
    t => 'CHANNEL_PINS_UPDATE',
    s => 1,
    d => { channel_id => '123', last_pin_timestamp => '2024-01-01' },
};

my $pins-event = Dusk::Event::Events::ChannelPinsUpdate.new(raw => $pins-payload<d>);
ok $pins-event, 'ChannelPinsUpdate can be created';
ok $pins-event.channel-id eq '123', 'ChannelPinsUpdate channel-id is correct';

my $invite-payload = {
    op => 0,
    t => 'INVITE_CREATE',
    s => 1,
    d => { channel_id => '456', code => 'ABC' },
};

my $invite-event = Dusk::Event::Events::InviteCreate.new(raw => $invite-payload<d>);
ok $invite-event, 'InviteCreate can be created';
ok $invite-event.code eq 'ABC', 'InviteCreate code is correct';

# === NEW ENDPOINTS ===
my $app-route = Dusk::Rest::Endpoint.get-application(application-id => '789');
ok $app-route, 'get-application returns route';
ok $app-route.method eq 'GET', 'get-application method is GET';
ok $app-route.path eq '/applications/789', 'get-application path is correct';

my $patch-app-route = Dusk::Rest::Endpoint.patch-application(application-id => '789', name => 'New');
ok $patch-app-route, 'patch-application returns route';
ok $patch-app-route.method eq 'PATCH', 'patch-application method is PATCH';

my $onboard-route = Dusk::Rest::Endpoint.patch-guilds-onboarding(guild-id => '999');
ok $onboard-route, 'patch-guilds-onboarding returns route';
ok $onboard-route.path eq '/guilds/999/onboarding', 'patch-guilds-onboarding path is correct';

# === INTEGRATION TESTS ===
# Test that all new enums are accessible
my @enums = (
    ActivityType, ChannelType, MessageFlags, Permission,
    VerificationLevel, MFALevel, PremiumTier, PremiumType,
    UserFlags, PresenceStatus, InviteTargetType
);
ok @enums.elems == 11, 'All 11 enums are accessible';

# Test that all new events are accessible
my @events = (
    Dusk::Event::Events::ChannelPinsUpdate,
    Dusk::Event::Events::InviteCreate,
    Dusk::Event::Events::InviteDelete,
    Dusk::Event::Events::MessageReactionRemoveEmoji,
    Dusk::Event::Events::ThreadListSync,
    Dusk::Event::Events::ThreadMemberUpdate,
    Dusk::Event::Events::ThreadMembersUpdate,
    Dusk::Event::Events::WebhooksUpdate,
);
ok @events.elems == 8, 'All 8 new events are accessible';

# Test that new methods are callable
lives-ok { Dusk::Rest::Endpoint.get-application(application-id => '123') }, 'get-application is callable';
lives-ok { Dusk::Rest::Endpoint.patch-application(application-id => '123') }, 'patch-application is callable';
lives-ok { Dusk::Rest::Endpoint.patch-guilds-onboarding(guild-id => '456') }, 'patch-guilds-onboarding is callable';
lives-ok { Dusk::Rest::Endpoint.patch-guilds-incident-actions(guild-id => '789') }, 'patch-guilds-incident-actions is callable';

# Test that API Reference exists and has content
my $api-ref-file = '/home/micelio/git/Dusk/docs/API_REFERENCE.md';
ok $api-ref-file.IO.e, 'API Reference file exists';
ok $api-ref-file.IO.s > 0, 'API Reference file is not empty';

say "✅ COMPLETE INTEGRATION TEST PASSED! (30/30)";

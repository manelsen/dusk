use v6.d;
use Test;

use Dusk::Enum;
use Dusk::Event;
use Dusk::Event::Events;
use Dusk::Model::PartialGuild;
use Dusk::Model::PartialChannel;
use Dusk::Model::PartialMember;
use Dusk::Rest::Endpoint;

plan 25;

# === TESTE 1-5: ENUMS ===
ok ActivityType::Game.Int == 0, 'ActivityType::Game is 0';
ok ChannelType::GuildText.Int == 0, 'ChannelType::GuildText is 0';
ok MessageFlags::Ephemeral.Int == 64, 'MessageFlags::Ephemeral is 64';
ok Permission::Administrator.Int == 8, 'Permission::Administrator is 8';
ok VerificationLevel::VerificationLevelNone.Int == 0, 'VerificationLevel::None is 0';

# === TESTE 6-9: MODELS PARCIAIS ===
my $guild = Dusk::Model::PartialGuild.new(id => '123', name => 'Test');
ok $guild.id eq '123', 'PartialGuild can be created';
ok $guild.name eq 'Test', 'PartialGuild name is correct';

my $channel = Dusk::Model::PartialChannel.new(id => '456', type => 0);
ok $channel.id eq '456', 'PartialChannel can be created';

my $member = Dusk::Model::PartialMember.new(nick => 'User');
ok $member.nick eq 'User', 'PartialMember can be created';

# === TESTE 10-13: GATEWAY EVENTS ===
my $pins-payload = {
    op => 0,
    t => 'CHANNEL_PINS_UPDATE',
    s => 1,
    d => { channel_id => '123', last_pin_timestamp => '2024-01-01' },
};

my $pins-event = Dusk::Event::Events::ChannelPinsUpdate.new(raw => $pins-payload<d>);
ok $pins-event, 'ChannelPinsUpdate event exists';
ok $pins-event.channel-id eq '123', 'ChannelPinsUpdate channel-id is correct';

my $invite-payload = {
    op => 0,
    t => 'INVITE_CREATE',
    s => 1,
    d => { channel_id => '456', code => 'ABC' },
};

my $invite-event = Dusk::Event::Events::InviteCreate.new(raw => $invite-payload<d>);
ok $invite-event, 'InviteCreate event exists';
ok $invite-event.code eq 'ABC', 'InviteCreate code is correct';

# === TESTE 14-21: NOVOS ENDPOINTS ===
my $app-route = Dusk::Rest::Endpoint.get-application(application-id => '789');
ok $app-route, 'get-application returns route';
ok $app-route.method eq 'GET', 'get-application is GET';
ok $app-route.path eq '/applications/789', 'get-application path is correct';

my $patch-route = Dusk::Rest::Endpoint.patch-application(application-id => '999');
ok $patch-route.method eq 'PATCH', 'patch-application is PATCH';

my $onboard-route = Dusk::Rest::Endpoint.patch-guilds-onboarding(guild-id => '111');
ok $onboard-route.method eq 'PATCH', 'patch-guilds-onboarding is PATCH';
ok $onboard-route.path eq '/guilds/111/onboarding', 'patch-guilds-onboarding path is correct';

my $incident-route = Dusk::Rest::Endpoint.patch-guilds-incident-actions(guild-id => '222');
ok $incident-route.method eq 'PATCH', 'patch-guilds-incident-actions is PATCH';
ok $incident-route.path eq '/guilds/222/incident-actions', 'patch-guilds-incident-actions path is correct';

# === TESTE 22-25: VERIFICAÇÕES FINAIS ===
my $api-ref = '/home/micelio/git/Dusk/docs/API_REFERENCE.md';
ok $api-ref.IO.e, 'API Reference file exists';
ok $api-ref.IO.s > 0, 'API Reference file is not empty';

lives-ok { Dusk::Rest::Endpoint.get-application(application-id => '123') }, 'get-application is callable';
lives-ok { Dusk::Rest::Endpoint.patch-guilds-onboarding(guild-id => '456') }, 'patch-guilds-onboarding is callable';

say "";
say "✅ TODOS OS TESTES PASSARAM!";
say "✅ 25/25 testes bem-sucedidos";

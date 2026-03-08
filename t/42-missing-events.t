use v6.d;
use Test;
use Dusk::Event;
use Dusk::Event::Events;

plan 8;

# ChannelPinsUpdate
my $pins-payload = {
    op => 0,
    t => 'CHANNEL_PINS_UPDATE',
    s => 1,
    d => {
        channel_id => '123456',
        last_pin_timestamp => '2024-01-01T00:00:00.000000+00:00',
    },
};

my $pins-event = Dusk::Event::Events::ChannelPinsUpdate.new(raw => $pins-payload<d>);
isa-ok $pins-event, Dusk::Event, 'Pins event is created';
is $pins-event.channel-id, '123456', 'Pins event channel-id is correct';

# InviteCreate
my $invite-payload = {
    op => 0,
    t => 'INVITE_CREATE',
    s => 1,
    d => {
        channel_id => '123456',
        code => 'ABC123',
    },
};

my $invite-event = Dusk::Event::Events::InviteCreate.new(raw => $invite-payload<d>);
isa-ok $invite-event, Dusk::Event, 'Invite event is created';
is $invite-event.code, 'ABC123', 'Invite event code is correct';

# ThreadListSync
my $thread-sync-payload = {
    op => 0,
    t => 'THREAD_LIST_SYNC',
    s => 1,
    d => {
        guild_id => '123456',
        channel_ids => ['789'],
        threads => [],
    },
};

my $thread-sync-event = Dusk::Event::Events::ThreadListSync.new(raw => $thread-sync-payload<d>);
isa-ok $thread-sync-event, Dusk::Event, 'Thread sync event is created';
is $thread-sync-event.guild-id, '123456', 'Thread sync event guild-id is correct';

# WebhooksUpdate
my $webhook-payload = {
    op => 0,
    t => 'WEBHOOKS_UPDATE',
    s => 1,
    d => {
        guild_id => '123456',
        channel_id => '789',
    },
};

my $webhook-event = Dusk::Event::Events::WebhooksUpdate.new(raw => $webhook-payload<d>);
isa-ok $webhook-event, Dusk::Event, 'Webhook event is created';
is $webhook-event.guild-id, '123456', 'Webhook event guild-id is correct';

say "✅ All missing event tests passed!";

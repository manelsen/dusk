use v6.d;
use Test;
use JSON::Fast;

plan 5;

use Dusk::Cache;
use Dusk::Gateway::Payload;
use Dusk::Gateway::Dispatcher;

subtest 'Cache: basic put/get/remove' => {
    my $cache = Dusk::Cache.new;

    $cache.put-guild('1', { id => '1', name => 'Test Guild' });
    $cache.put-channel('10', { id => '10', name => 'general' });
    $cache.put-user('100', { id => '100', username => 'bot' });

    is $cache.guild-count, 1, 'One guild cached';
    is $cache.channel-count, 1, 'One channel cached';
    is $cache.user-count, 1, 'One user cached';

    is $cache.get-guild('1')<name>, 'Test Guild', 'Guild retrieved';
    is $cache.get-channel('10')<name>, 'general', 'Channel retrieved';
    is $cache.get-user('100')<username>, 'bot', 'User retrieved';

    $cache.remove-guild('1');
    is $cache.guild-count, 0, 'Guild removed';
};

subtest 'Cache: clear all' => {
    my $cache = Dusk::Cache.new;
    $cache.put-guild('1', { id => '1' });
    $cache.put-guild('2', { id => '2' });
    $cache.put-channel('10', { id => '10' });

    is $cache.guild-count, 2, 'Two guilds before clear';
    $cache.clear;
    is $cache.guild-count, 0, 'Zero guilds after clear';
    is $cache.channel-count, 0, 'Zero channels after clear';
};

subtest 'Cache: get nonexistent returns empty Hash' => {
    my $cache = Dusk::Cache.new;
    my %result = $cache.get-guild('nonexistent');
    is %result.elems, 0, 'Nonexistent guild returns empty hash';
};

subtest 'Cache: Gateway event invalidation' => {
    my $supplier = Supplier::Preserving.new;
    my $dispatcher = Dusk::Gateway::Dispatcher.new(events => $supplier.Supply);
    my $cache = Dusk::Cache.new;
    $cache.listen($dispatcher);

    # Simulate GUILD_CREATE
    $supplier.emit(Dusk::Gateway::Payload.new(op => 0, t => 'GUILD_CREATE', s => 1,
        d => {
            id => '123', name => 'New Guild',
            channels => [{ id => '10', name => 'general' }, { id => '11', name => 'off-topic' }],
            members => [{ user => { id => '1', username => 'owner' } }],
        }));

    sleep 0.1;
    is $cache.guild-count, 1, 'Guild cached from GUILD_CREATE';
    is $cache.get-guild('123')<name>, 'New Guild', 'Guild name correct';
    is $cache.channel-count, 2, 'Two channels cached from guild payload';
    is $cache.user-count, 1, 'One user cached from members';

    # Simulate CHANNEL_DELETE
    $supplier.emit(Dusk::Gateway::Payload.new(op => 0, t => 'CHANNEL_DELETE', s => 2,
        d => { id => '10' }));

    sleep 0.1;
    is $cache.channel-count, 1, 'Channel removed after CHANNEL_DELETE';

    # Simulate MESSAGE_CREATE (caches author)
    $supplier.emit(Dusk::Gateway::Payload.new(op => 0, t => 'MESSAGE_CREATE', s => 3,
        d => { id => '999', content => 'hi', author => { id => '2', username => 'sender' } }));

    sleep 0.1;
    is $cache.user-count, 2, 'Author cached from MESSAGE_CREATE';
    is $cache.get-user('2')<username>, 'sender', 'Author username correct';

    $cache.stop;
};

subtest 'Voice::Client stub raises error' => {
    use Dusk::Voice::Client;

    my $voice = Dusk::Voice::Client.new(guild-id => '1', channel-id => '2');
    nok $voice.is-connected, 'Not connected by default';
    dies-ok { $voice.connect }, 'connect() dies with stub message';
};

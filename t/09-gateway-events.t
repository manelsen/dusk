use v6.d;
use Test;
use JSON::Fast;

plan 4;

use Dusk::Gateway::Payload;
use Dusk::Gateway::Dispatcher;

subtest 'Dispatcher routes MESSAGE_CREATE events' => {
    my $supplier = Supplier::Preserving.new;
    my $dispatcher = Dusk::Gateway::Dispatcher.new(events => $supplier.Supply);

    my @received;
    my $tap = $dispatcher.on-message-create.tap: -> $data {
        @received.push($data);
    };

    # Emit mock events
    $supplier.emit(Dusk::Gateway::Payload.new(op => 0, t => 'MESSAGE_CREATE', s => 1,
        d => { content => 'Hello', author => { id => '1', username => 'bot' } }));
    $supplier.emit(Dusk::Gateway::Payload.new(op => 0, t => 'GUILD_CREATE', s => 2,
        d => { id => '123', name => 'Test Guild' }));
    $supplier.emit(Dusk::Gateway::Payload.new(op => 0, t => 'MESSAGE_CREATE', s => 3,
        d => { content => 'World', author => { id => '2', username => 'user' } }));

    sleep 0.1;
    $tap.close;

    is @received.elems, 2, 'Only MESSAGE_CREATE events routed (not GUILD_CREATE)';
    is @received[0]<content>, 'Hello', 'First message content correct';
    is @received[1]<content>, 'World', 'Second message content correct';
};

subtest 'Dispatcher routes GUILD_CREATE events' => {
    my $supplier = Supplier::Preserving.new;
    my $dispatcher = Dusk::Gateway::Dispatcher.new(events => $supplier.Supply);

    my @received;
    my $tap = $dispatcher.on-guild-create.tap: -> $data {
        @received.push($data);
    };

    $supplier.emit(Dusk::Gateway::Payload.new(op => 0, t => 'GUILD_CREATE', s => 1,
        d => { id => '123', name => 'Test Guild' }));
    $supplier.emit(Dusk::Gateway::Payload.new(op => 0, t => 'MESSAGE_CREATE', s => 2,
        d => { content => 'ignored' }));

    sleep 0.1;
    $tap.close;

    is @received.elems, 1, 'Only GUILD_CREATE events routed';
    is @received[0]<name>, 'Test Guild', 'Guild name correct';
};

subtest 'Dispatcher generic on() method' => {
    my $supplier = Supplier::Preserving.new;
    my $dispatcher = Dusk::Gateway::Dispatcher.new(events => $supplier.Supply);

    my @received;
    my $tap = $dispatcher.on('THREAD_CREATE').tap: -> $data {
        @received.push($data);
    };

    $supplier.emit(Dusk::Gateway::Payload.new(op => 0, t => 'THREAD_CREATE', s => 1,
        d => { id => '456', name => 'Thread' }));

    sleep 0.1;
    $tap.close;

    is @received.elems, 1, 'Generic on() routes correctly';
    is @received[0]<name>, 'Thread', 'Thread name correct';
};

subtest 'Dispatcher ignores non-dispatch opcodes' => {
    my $supplier = Supplier::Preserving.new;
    my $dispatcher = Dusk::Gateway::Dispatcher.new(events => $supplier.Supply);

    my @received;
    my $tap = $dispatcher.on-message-create.tap: -> $data {
        @received.push($data);
    };

    # op:10 HELLO — not a dispatch
    $supplier.emit(Dusk::Gateway::Payload.new(op => 10, d => { heartbeat_interval => 41250 }));
    # op:11 HEARTBEAT_ACK — not a dispatch
    $supplier.emit(Dusk::Gateway::Payload.new(op => 11));

    sleep 0.1;
    $tap.close;

    is @received.elems, 0, 'Non-dispatch opcodes are filtered out';
};

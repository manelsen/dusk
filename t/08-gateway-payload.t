use v6.d;
use Test;
use JSON::Fast;

plan 6;

use Dusk::Gateway::Payload;
use Dusk::Gateway::Intents;

subtest 'Parse HELLO payload (gateway_hello.json)' => {
    my @data = from-json("t/fixtures/gateway_hello.json".IO.slurp);
    my $payload = Dusk::Gateway::Payload.from-json(@data[0]);

    is $payload.op, 10, 'op is 10 (HELLO)';
    ok $payload.is-hello, 'is-hello predicate works';
    nok $payload.is-dispatch, 'is-dispatch is false';
    is $payload.heartbeat-interval, 41250, 'heartbeat_interval parsed correctly';
};

subtest 'Parse READY event (gateway_ready.json)' => {
    my @data = from-json("t/fixtures/gateway_ready.json".IO.slurp);
    my $payload = Dusk::Gateway::Payload.from-json(@data[0]);

    is $payload.op, 0, 'op is 0 (DISPATCH)';
    is $payload.t, 'READY', 'event name is READY';
    is $payload.s, 1, 'sequence is 1';
    ok $payload.is-dispatch, 'is-dispatch predicate works';
    is $payload.d<v>, 10, 'API version is 10';
    is $payload.d<user><username>, 'Bellegendas Premium', 'User parsed';
    is $payload.d<guilds>.elems, 2, 'Two guilds in READY';
    ok $payload.d<session_id>.defined, 'session_id present';
    ok $payload.d<resume_gateway_url>.defined, 'resume_gateway_url present';
};

subtest 'Parse HEARTBEAT_ACK (gateway_heartbeat_ack.json)' => {
    my @data = from-json("t/fixtures/gateway_heartbeat_ack.json".IO.slurp);
    my $payload = Dusk::Gateway::Payload.from-json(@data[0]);

    is $payload.op, 11, 'op is 11 (HEARTBEAT_ACK)';
    ok $payload.is-heartbeat-ack, 'is-heartbeat-ack predicate works';
    nok $payload.is-dispatch, 'not a dispatch';
};

subtest 'Parse MESSAGE_CREATE events (gateway_message_create.json)' => {
    my @data = from-json("t/fixtures/gateway_message_create.json".IO.slurp);

    is @data.elems, 4, 'Fixture contains 4 MESSAGE_CREATE events';

    for @data -> $raw {
        my $payload = Dusk::Gateway::Payload.from-json($raw);
        is $payload.op, 0, "op is 0 (DISPATCH)";
        is $payload.t, 'MESSAGE_CREATE', "event name is MESSAGE_CREATE";
        ok $payload.d<channel_id>.defined, "channel_id present";
        ok $payload.d<author><id>.defined, "author.id present";
    }
};

subtest 'Opcode constants' => {
    is Dusk::Gateway::Payload::OP_DISPATCH,      0,  'OP_DISPATCH = 0';
    is Dusk::Gateway::Payload::OP_HEARTBEAT,     1,  'OP_HEARTBEAT = 1';
    is Dusk::Gateway::Payload::OP_IDENTIFY,      2,  'OP_IDENTIFY = 2';
    is Dusk::Gateway::Payload::OP_RESUME,        6,  'OP_RESUME = 6';
    is Dusk::Gateway::Payload::OP_RECONNECT,     7,  'OP_RECONNECT = 7';
    is Dusk::Gateway::Payload::OP_INVALID_SESSION, 9, 'OP_INVALID_SESSION = 9';
    is Dusk::Gateway::Payload::OP_HELLO,         10, 'OP_HELLO = 10';
    is Dusk::Gateway::Payload::OP_HEARTBEAT_ACK, 11, 'OP_HEARTBEAT_ACK = 11';
};

subtest 'Intents bit flags' => {
    is GUILDS, 1, 'GUILDS = 1';
    is GUILD_MESSAGES, 512, 'GUILD_MESSAGES = 512';
    is MESSAGE_CONTENT, 32768, 'MESSAGE_CONTENT = 32768';
    is DIRECT_MESSAGES, 4096, 'DIRECT_MESSAGES = 4096';

    my $combined = GUILDS +| GUILD_MESSAGES;
    is $combined, 513, 'GUILDS +| GUILD_MESSAGES = 513';

    my $default = DEFAULT_INTENTS;
    is $default, GUILDS +| GUILD_MESSAGES +| DIRECT_MESSAGES, 'DEFAULT_INTENTS is correct';
};

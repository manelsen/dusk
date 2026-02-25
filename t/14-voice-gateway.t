use v6;
use Test;
use JSON::Fast;
use Dusk::Voice::Gateway;
use Dusk::Error;

plan 6;

# TC 14-01: OP 0 IDENTIFY sent when test mode heartbeat-interval > 0
subtest 'OP 0 IDENTIFY sent with correct payload (test-mode connect)', {
    my @sent;
    my $gw = Dusk::Voice::Gateway.new(
        endpoint           => 'wss://mock.discord.media/?v=4',
        token              => 'voice_token_123',
        session-id         => 'session_abc',
        guild-id           => 111222333,
        user-id            => 999888777,
        heartbeat-interval => 0.001, # test mode — skips real WS
    );
    $gw.set-mock-sender(-> $p { @sent.push(from-json($p)) });

    # Connect in test-mode: immediately sends Identify, no WS needed
    await $gw.connect();

    ok @sent.elems >= 1, "At least one payload sent";
    my $identify = @sent.first({ .<op> == 0 });
    ok $identify.defined, "OP 0 (Identify) was sent";
    is $identify<d><server_id>, '111222333', "guild_id (server_id) correct";
    is $identify<d><session_id>, 'session_abc', "session_id correct";
    is $identify<d><token>, 'voice_token_123', "token correct";
};

# TC 14-02: OP 2 READY parsed correctly via inject-op
subtest 'OP 2 READY payload parsed into internal state', {
    my $gw = Dusk::Voice::Gateway.new(
        endpoint   => 'wss://mock.discord.media/?v=4',
        token      => 'voice_token_123',
        session-id => 'session_abc',
        guild-id   => 111222333,
        user-id    => 999888777,
    );
    $gw.set-mock-sender(-> $p { });

    $gw.inject-op({
        op => 2,
        d  => {
            ssrc  => 12345,
            ip    => '192.168.1.100',
            port  => 50001,
            modes => ['xsalsa20_poly1305'],
        }
    });

    is $gw.ssrc, 12345, "SSRC parsed";
    is $gw.server-ip, '192.168.1.100', "Server IP parsed";
    is $gw.server-port, 50001, "Server port parsed";
    ok 'xsalsa20_poly1305' ∈ $gw.modes, "Encryption mode available";
};

# TC 14-03: OP 3 Heartbeat sent at interval
subtest 'OP 3 Heartbeat fired by timer', {
    my @sent;
    my $gw = Dusk::Voice::Gateway.new(
        endpoint           => 'wss://mock.discord.media/?v=4',
        token              => 'voice_token',
        session-id         => 'sess',
        guild-id           => 1,
        user-id            => 1,
        heartbeat-interval => 0.05,  # 50ms for testing
    );
    $gw.set-mock-sender(-> $p { @sent.push(from-json($p)) });

    $gw.start-heartbeat();
    sleep 0.18;
    $gw.stop-heartbeat();

    my @hb = @sent.grep({ .<op> == 3 });
    ok @hb.elems >= 2, "At least 2 heartbeats sent in 180ms";
    ok @hb[0]<d> ~~ Int, "Heartbeat nonce is an Int";
};

# TC 14-04: SELECT_PROTOCOL (OP 1) built correctly
subtest 'OP 1 SELECT_PROTOCOL sent with correct IP/port/mode', {
    my @sent;
    my $gw = Dusk::Voice::Gateway.new(
        endpoint   => 'wss://mock.discord.media/?v=4',
        token      => 'voice_token',
        session-id => 'sess',
        guild-id   => 1,
        user-id    => 1,
    );
    $gw.set-mock-sender(-> $p { @sent.push(from-json($p)) });

    $gw.send-select-protocol(ip => '203.0.113.5', port => 54321);

    my $op1 = @sent.first({ .<op> == 1 });
    ok $op1.defined, "OP 1 was sent";
    is $op1<d><protocol>, 'udp', "Protocol is udp";
    is $op1<d><data><address>, '203.0.113.5', "Public IP correct";
    is $op1<d><data><port>, 54321, "Public port correct";
    is $op1<d><data><mode>, 'xsalsa20_poly1305', "Mode correct";
};

# TC 14-05: OP 4 SESSION_DESCRIPTION extracts secret key as Blob
subtest 'OP 4 SESSION_DESCRIPTION secret_key extracted as 32-byte Blob', {
    my $gw = Dusk::Voice::Gateway.new(
        endpoint   => 'wss://mock.discord.media/?v=4',
        token      => 'voice_token',
        session-id => 'sess',
        guild-id   => 1,
        user-id    => 1,
    );
    $gw.set-mock-sender(-> $p { });

    my @key-bytes = (0..31).list;
    $gw.inject-op({
        op => 4,
        d  => {
            mode       => 'xsalsa20_poly1305',
            secret_key => @key-bytes,
        }
    });

    isa-ok $gw.secret-key, Blob, "secret-key is a Blob";
    is $gw.secret-key.elems, 32, "secret-key is 32 bytes";
    is $gw.secret-key[0], 0, "First key byte correct";
    is $gw.secret-key[31], 31, "Last key byte correct";
};

# TC 14-06: WS close code 4006 raises VoiceSessionTimeout
subtest 'handle-close-code(4006) raises VoiceSessionTimeout', {
    my $gw = Dusk::Voice::Gateway.new(
        endpoint   => 'wss://mock.discord.media/?v=4',
        token      => 'voice_token',
        session-id => 'sess',
        guild-id   => 1,
        user-id    => 1,
    );

    throws-like { $gw.handle-close-code(4006) },
        Dusk::Error::VoiceSessionTimeout,
        "4006 raises VoiceSessionTimeout";
    throws-like { $gw.handle-close-code(4014) },
        Dusk::Error::VoiceSessionTimeout,
        "4014 also raises VoiceSessionTimeout";
};

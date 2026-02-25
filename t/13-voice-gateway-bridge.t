use v6;
use Test;
use Dusk::Gateway::Connection;
use Dusk::Gateway::Dispatcher;
use Dusk::Gateway::Payload;
use Dusk::Event::Events;
use JSON::Fast;

plan 3;

subtest 'OP 4 Join Voice Channel Payload Construction', {
    my $conn = Dusk::Gateway::Connection.new(
        token   => 'test_token',
        intents => 513
    );

    # We use a mock sender to capture the OP 4 JSON sent to WebSocket.
    my $sent-json = '';
    $conn.set-mock-sender(-> $payload {
        $sent-json = $payload;
    });

    # Try to join voice channel
    $conn.join-voice-channel('guild123', 'channel456', mute => True, deaf => False);

    my $decoded = from-json($sent-json);
    is $decoded<op>, Dusk::Gateway::Payload::OP_VOICE_STATE, "Correct Opcode used (4)";
    is $decoded<d><guild_id>, 'guild123', "Guild ID correctly passed";
    is $decoded<d><channel_id>, 'channel456', "Channel ID correctly passed";
    is $decoded<d><self_mute>, True, "Self mute is True";
    is $decoded<d><self_deaf>, False, "Self deaf is False";

    # Try to leave voice channel
    $conn.join-voice-channel('guild123', '');
    my $leave-decoded = from-json($sent-json);
    ok $leave-decoded<d><channel_id> === Any, "Leaving channel correctly sends null for channel_id";
}

subtest 'Dispatcher Routing VOICE_STATE_UPDATE', {
    my $supplier = Supplier::Preserving.new;
    my $dispatcher = Dusk::Gateway::Dispatcher.new(events => $supplier.Supply);

    my $event-seen = False;
    $dispatcher.on-voice-state-update.tap(-> $event {
        isa-ok $event, Dusk::Event::Events::VoiceStateUpdate, "Event mapped to correct class";
        my $vs = $event.voice-state;
        is $vs.session-id, 'session_xyz_789', "Parsed session_id";
        is $vs.user-id, 'user_123', "Parsed user_id";
        is $vs.channel-id, 'channel_456', "Parsed channel_id";
        nok $vs.deaf, "Parsed deaf param";
        ok $vs.mute, "Parsed mute param";
        $event-seen = True;
    });

    # Simulate an incoming payload from the Gateway
    my $raw-payload = Dusk::Gateway::Payload.new(
        op => Dusk::Gateway::Payload::OP_DISPATCH,
        t  => 'VOICE_STATE_UPDATE',
        d  => %(
            session_id => 'session_xyz_789',
            user_id    => 'user_123',
            channel_id => 'channel_456',
            guild_id   => 'guild_123',
            deaf       => False,
            mute       => True,
        )
    );
    $supplier.emit($raw-payload);

    ok $event-seen, "Dispatcher correctly fired the event";
}

subtest 'Dispatcher Routing VOICE_SERVER_UPDATE', {
    my $supplier = Supplier::Preserving.new;
    my $dispatcher = Dusk::Gateway::Dispatcher.new(events => $supplier.Supply);

    my $event-seen = False;
    $dispatcher.on-voice-server-update.tap(-> $event {
        isa-ok $event, Dusk::Event::Events::VoiceServerUpdate, "Event mapped to correct class";
        is $event.token, 'secret_voice_token_456', "Parsed voice token";
        is $event.endpoint, 'brazil-123.discord.media', "Parsed voice endpoint";
        is $event.guild-id, 'guild_123', "Parsed guild ID";
        $event-seen = True;
    });

    # Simulate an incoming payload from the Gateway
    my $raw-payload = Dusk::Gateway::Payload.new(
        op => Dusk::Gateway::Payload::OP_DISPATCH,
        t  => 'VOICE_SERVER_UPDATE',
        d  => %(
            token    => 'secret_voice_token_456',
            endpoint => 'brazil-123.discord.media',
            guild_id => 'guild_123',
        )
    );
    $supplier.emit($raw-payload);

    ok $event-seen, "Dispatcher correctly fired the event";
}

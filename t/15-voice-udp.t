use v6;
use Test;

# Gate 05: Fail-First — these tests must ALL FAIL before Voice::UDP is implemented.

plan 5;

# TC 15-01: IP Discovery packet structure
subtest 'IP Discovery packet has correct 74-byte structure', {
    use Dusk::Voice::UDP;

    my $udp = Dusk::Voice::UDP.new(
        server-ip   => '127.0.0.1',
        server-port => 50000,
        ssrc        => 0xDEAD_BEEF,
    );

    my $packet = $udp.build-discovery-packet();

    isa-ok $packet, Buf, "Discovery packet is a Buf";
    is $packet.elems, 74, "Packet is exactly 74 bytes";
    # Bytes 0-1: type (0x01 0x00 = Request)
    is $packet[0], 0x00, "Type high byte is 0x00";
    is $packet[1], 0x01, "Type low byte is 0x01 (Request)";
    # Bytes 4-7: SSRC big-endian
    my $ssrc-in-packet = ($packet[4] +< 24) +| ($packet[5] +< 16) +| ($packet[6] +< 8) +| $packet[7];
    is $ssrc-in-packet, 0xDEAD_BEEF, "SSRC correctly encoded big-endian in bytes 4–7";
};

# TC 15-02: Public IP parsed from discovery response
subtest 'Public IP correctly extracted from discovery response', {
    use Dusk::Voice::UDP;

    my $udp = Dusk::Voice::UDP.new(
        server-ip   => '127.0.0.1',
        server-port => 50000,
        ssrc        => 1234,
    );

    # Build a fake 74-byte response with "1.2.3.4\0" starting at byte 8
    my $response = Buf.new(0 xx 74);
    my @ip-bytes = "1.2.3.4".encode('ascii').list;
    for ^@ip-bytes.elems -> $i { $response[$i + 8] = @ip-bytes[$i] }

    my $ip = $udp.parse-discovery-ip($response);
    is $ip, '1.2.3.4', "Public IP parsed correctly from response";
};

# TC 15-03: Public port parsed big-endian from bytes 72-73
subtest 'Public port correctly extracted big-endian from bytes 72–73', {
    use Dusk::Voice::UDP;

    my $udp = Dusk::Voice::UDP.new(
        server-ip   => '127.0.0.1',
        server-port => 50000,
        ssrc        => 1234,
    );

    my $response = Buf.new(0 xx 74);
    # Encode port 54321 (0xD431) big-endian at bytes 72-73
    $response[72] = 0xD4;
    $response[73] = 0x31;

    my $port = $udp.parse-discovery-port($response);
    is $port, 54321, "Public port 54321 parsed correctly";
};

# TC 15-04: send-frame dispatches Blob without blocking
subtest 'send-frame sends without blocking caller thread', {
    use Dusk::Voice::UDP;

    my @frames-sent;
    my $udp = Dusk::Voice::UDP.new(
        server-ip   => '127.0.0.1',
        server-port => 50000,
        ssrc        => 1234,
    );
    $udp.set-mock-socket(-> $data { @frames-sent.push($data) });

    my $test-frame = Buf.new(1 xx 100);
    $udp.send-frame($test-frame);

    is @frames-sent.elems, 1, "Frame was dispatched";
    is @frames-sent[0].elems, 100, "Frame byte length intact";
};

# TC 15-05: Discovery timeout raises VoiceUDPDiscoveryFailed
subtest 'Discovery timeout raises VoiceUDPDiscoveryFailed', {
    use Dusk::Voice::UDP;
    use Dusk::Error;

    my $udp = Dusk::Voice::UDP.new(
        server-ip        => '127.0.0.1',
        server-port      => 50000,
        ssrc             => 1234,
        discovery-timeout => 0.01,
    );
    $udp.set-mock-socket(-> $data { }); # swallow send, never reply

    my $ex;
    try {
        await $udp.discover();
        CATCH { $ex = $_ }
    }

    ok $ex.defined, "An exception was raised";
    ok $ex ~~ Dusk::Error::VoiceUDPDiscoveryFailed
       || ($ex.?exception ~~ Dusk::Error::VoiceUDPDiscoveryFailed),
       "Exception is VoiceUDPDiscoveryFailed (possibly wrapped)";
};

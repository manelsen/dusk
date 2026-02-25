use v6;
use Test;

# Gate 05: Fail-First — these tests must ALL FAIL before Voice::Crypto is implemented.

# Skip all tests if libsodium is not installed
my $libsodium-available = do {
    try { run('ldconfig', '-p', :out).out.slurp ~~ /libsodium/; True } // False
};

unless $libsodium-available {
    say "1..0 # SKIP libsodium not found — install libsodium-dev to run crypto tests";
    exit 0;
}

plan 6;

# TC 17-01: check-libsodium() does not throw when libsodium is present
subtest 'check-libsodium() lives when libsodium is installed', {
    use Dusk::Voice::Crypto;

    lives-ok { check-libsodium() }, "check-libsodium() did not throw";
};

# TC 17-02: Encrypted output is Blob of correct size (12-byte header + payload + 16-byte MAC)
subtest 'Encrypted frame has correct total byte size', {
    use Dusk::Voice::Crypto;

    my $opus = Buf.new(0 xx 100);     # 100 bytes of fake opus data
    my $key  = Buf.new(0 xx 32);      # 32-byte all-zeros key

    my $packet = encrypt-frame($opus, $key, ssrc => 42, sequence => 1, timestamp => 960);

    isa-ok $packet, Blob, "Output is a Blob";
    # 12-byte RTP header + 100-byte opus ciphertext + 16-byte poly1305 MAC
    is $packet.elems, 12 + 100 + 16, "Total packet size is 128 bytes";
};

# TC 17-03: Different nonces produce different ciphertexts
subtest 'Different sequence numbers produce different ciphertexts', {
    use Dusk::Voice::Crypto;

    my $opus = Buf.new(0xAB xx 50);
    my $key  = Buf.new(0x01 xx 32);

    my $p1 = encrypt-frame($opus, $key, ssrc => 1, sequence => 1, timestamp => 960);
    my $p2 = encrypt-frame($opus, $key, ssrc => 1, sequence => 2, timestamp => 1920);

    ok $p1 ne $p2, "Different nonces produce different ciphertexts";
};

# TC 17-04: Sequence number wraps correctly at 2^16
subtest 'Sequence wraps at 2^16 (65536) without error', {
    use Dusk::Voice::Crypto;

    my $opus = Buf.new(0 xx 10);
    my $key  = Buf.new(0 xx 32);

    # seq 65535 (max UInt16) and 65536 (should wrap to 0)
    my $p1 = encrypt-frame($opus, $key, ssrc => 1, sequence => 65535, timestamp => 1);
    my $p2 = encrypt-frame($opus, $key, ssrc => 1, sequence => 65536, timestamp => 2);

    # seq in RTP header bytes 2-3 (UInt16 big-endian)
    is ($p1[2] +< 8) +| $p1[3], 65535, "Sequence 65535 in header";
    is ($p2[2] +< 8) +| $p2[3], 0, "Sequence 65536 wraps to 0 in header";
};

# TC 17-05: RTP header bytes 0-1 have correct version and payload type
subtest 'RTP header bytes 0–1 are correct (V=2, PT=120)', {
    use Dusk::Voice::Crypto;

    my $opus = Buf.new(0 xx 20);
    my $key  = Buf.new(0 xx 32);

    my $packet = encrypt-frame($opus, $key, ssrc => 1, sequence => 1, timestamp => 960);

    is $packet[0], 0x80, "Byte 0: V=2, P=0, X=0, CC=0 (0x80)";
    is $packet[1], 0x78, "Byte 1: M=0, PT=120 (Opus) (0x78)";
};

# TC 17-06: SSRC field at bytes 8-11 matches input SSRC (big-endian)
subtest 'SSRC encoded big-endian at RTP bytes 8–11', {
    use Dusk::Voice::Crypto;

    my $opus = Buf.new(0 xx 10);
    my $key  = Buf.new(0 xx 32);
    my $ssrc = 0xDEAD_BEEF;

    my $packet = encrypt-frame($opus, $key, ssrc => $ssrc, sequence => 1, timestamp => 960);

    my $ssrc-in-packet = ($packet[8]  +< 24) +|
                         ($packet[9]  +< 16) +|
                         ($packet[10] +<  8) +|
                          $packet[11];

    is $ssrc-in-packet, $ssrc, "SSRC 0xDEADBEEF correctly encoded at bytes 8–11";
};

use NativeCall;
use Dusk::Error;

unit module Dusk::Voice::Crypto;

# --- libsodium NativeCall bindings ---
# We link to the versioned name to match what's installed on most Linux systems.
# Detection uses ldconfig/find at load time rather than a ccall probe.

constant LIBSODIUM = 'libsodium.so.23';

my constant KEYBYTES   = 32;
my constant MACBYTES   = 16;
my constant NONCEBYTES = 24;

# RTP constants
my constant RTP_VERSION = 0x80;   # V=2, P=0, X=0, CC=0
my constant RTP_PAYLOAD = 0x78;   # Opus PT=120 (Opus codec)

my Bool $sodium-loaded = False;

sub crypto_secretbox_easy(
    Blob,    # ciphertext out (len = plaintext + MACBYTES)
    Blob,    # plaintext in
    int64,   # plaintext len
    Blob,    # nonce (24 bytes)
    Blob,    # key (32 bytes)
    --> int32
) is native(LIBSODIUM) is symbol('crypto_secretbox_easy') { * }

#| Verify libsodium is installed by probing the ldconfig cache.
#| Raises Dusk::Error::LibsodiumNotFound with install instructions if absent.
sub check-libsodium() is export {
    return if $sodium-loaded;

    # Use ldconfig to check for libsodium presence (Linux) or fall back to a finder
    my $found = (try { run('ldconfig', '-p', :out, :err).out.slurp ~~ /libsodium/ }) // False;
    unless $found {
        # Fallback: check if the .so file exists directly
        $found = '/lib/x86_64-linux-gnu/libsodium.so.23'.IO.e
        || '/usr/lib/libsodium.so'.IO.e
        || '/usr/local/lib/libsodium.so'.IO.e;
    }

    die Dusk::Error::LibsodiumNotFound.new() unless $found;
    $sodium-loaded = True;
}

#| Build a 12-byte RTP header (RFC 3550 format used by Discord).
sub build-rtp-header(Int :$sequence, Int :$timestamp, Int :$ssrc --> Buf) {
    my $seq  = $sequence mod 65536;    # UInt16 wrap
    my $ts   = $timestamp mod 2**32;   # UInt32 wrap
    my $s    = $ssrc mod 2**32;        # UInt32 wrap
    Buf.new(
        RTP_VERSION, RTP_PAYLOAD,
        ($seq  +> 8) +& 0xFF,  $seq        +& 0xFF,
        ($ts   +> 24) +& 0xFF, ($ts  +> 16) +& 0xFF, ($ts  +> 8) +& 0xFF, $ts  +& 0xFF,
        ($s    +> 24) +& 0xFF, ($s   +> 16) +& 0xFF, ($s   +> 8) +& 0xFF, $s   +& 0xFF,
    );
}

#| Build 24-byte nonce: 12-byte RTP header padded with 12 zero bytes.
sub build-nonce(Buf $header --> Blob) {
    Blob.new(|$header.list, |(0 xx (NONCEBYTES - $header.elems)));
}

#| Encrypt one Opus PCM frame, returning a complete RTP+payload Blob for UDP.
#| Raises LibsodiumNotFound if libsodium is not installed.
sub encrypt-frame(
    Buf $opus-data,
    Buf $secret-key,
    Int :$ssrc,
    Int :$sequence,
    Int :$timestamp,
    --> Blob
) is export {
    check-libsodium();

    my $header = build-rtp-header(:$sequence, :$timestamp, :$ssrc);
    my $nonce  = build-nonce($header);

    my $plain  = Blob.new($opus-data.list);
    my $cipher = Blob.new(0 xx ($plain.elems + MACBYTES));

    my $rc = crypto_secretbox_easy($cipher, $plain, $plain.elems, $nonce, Blob.new($secret-key.list));
    die "crypto_secretbox_easy failed: rc=$rc" if $rc != 0;

    Blob.new(|$header.list, |$cipher.list);
}

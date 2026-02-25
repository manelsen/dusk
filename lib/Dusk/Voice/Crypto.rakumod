use NativeCall;
use Dusk::Error;

unit module Dusk::Voice::Crypto;

# --- libsodium NativeCall bindings ---
constant LIBSODIUM = 'libsodium.so.23';

my constant KEYBYTES   = 32;
my constant MACBYTES   = 16;
my constant NONCEBYTES = 24;

# RTP constants
my constant RTP_VERSION = 0x80;   # V=2, P=0, X=0, CC=0
my constant RTP_PAYLOAD = 0x78;   # Opus PT=120

my Bool $sodium-loaded = False;

# xsalsa20_poly1305 — nonce = 12-byte RTP header + 12 zero bytes
sub crypto_secretbox_easy(Blob, Blob, int64, Blob, Blob --> int32)
is native(LIBSODIUM) is symbol('crypto_secretbox_easy') { * }

# xchacha20_poly1305_ietf — nonce = 24 bytes, used for aead_xchacha20_poly1305_rtpsize
sub crypto_aead_xchacha20poly1305_ietf_encrypt(
    Blob,         # ciphertext out (len = plaintext + MACBYTES)
    uint64,       # ciphertext len out (not used, pass 0)
    Blob,         # plaintext
    uint64,       # plaintext len
    Blob,         # additional data (RTP header)
    uint64,       # additional data len
    Blob,         # nsec (always NULL — pass empty Blob)
    Blob,         # nonce (24 bytes)
    Blob,         # key (32 bytes)
    --> int32
) is native(LIBSODIUM) is symbol('crypto_aead_xchacha20poly1305_ietf_encrypt') { * }

#| Verify libsodium is installed.
sub check-libsodium() is export {
    return if $sodium-loaded;
    my $found = (try { run('ldconfig', '-p', :out, :err).out.slurp ~~ /libsodium/ }) // False;
    unless $found {
        $found = '/lib/x86_64-linux-gnu/libsodium.so.23'.IO.e
        || '/usr/lib/libsodium.so'.IO.e
        || '/usr/local/lib/libsodium.so'.IO.e;
    }
    die Dusk::Error::LibsodiumNotFound.new() unless $found;
    $sodium-loaded = True;
}

#| Build a 12-byte RTP header.
sub build-rtp-header(Int :$sequence, Int :$timestamp, Int :$ssrc --> Buf) {
    my $seq = $sequence mod 65536;
    my $ts  = $timestamp mod 2**32;
    my $s   = $ssrc mod 2**32;
    Buf.new(
        RTP_VERSION, RTP_PAYLOAD,
        ($seq +> 8) +& 0xFF,   $seq       +& 0xFF,
        ($ts  +> 24) +& 0xFF, ($ts +> 16) +& 0xFF, ($ts +> 8) +& 0xFF, $ts +& 0xFF,
        ($s   +> 24) +& 0xFF, ($s  +> 16) +& 0xFF, ($s  +> 8) +& 0xFF, $s  +& 0xFF,
    );
}

#| Encrypt one Opus frame using xsalsa20_poly1305.
#| Nonce: 12-byte RTP header padded to 24 bytes.
#| Packet: RTP header ++ ciphertext
sub encrypt-frame(
    Buf $opus-data, Buf $secret-key,
    Int :$ssrc, Int :$sequence, Int :$timestamp,
    --> Blob
) is export {
    check-libsodium();
    my $header = build-rtp-header(:$sequence, :$timestamp, :$ssrc);
    my $nonce  = Blob.new(|$header.list, |(0 xx (NONCEBYTES - $header.elems)));
    my $plain  = Blob.new($opus-data.list);
    my $cipher = Blob.new(0 xx ($plain.elems + MACBYTES));
    my $rc = crypto_secretbox_easy($cipher, $plain, $plain.elems, $nonce, Blob.new($secret-key.list));
    die "crypto_secretbox_easy failed: rc=$rc" if $rc != 0;
    Blob.new(|$header.list, |$cipher.list);
}

#| Encrypt one Opus frame using aead_xchacha20_poly1305_rtpsize.
#| This is the mode Discord currently offers (2024+).
#| Nonce: 4-byte LE incrementing counter appended at the end of the payload.
#| Packet: RTP header ++ AEAD-ciphertext ++ 4-byte-nonce
sub encrypt-frame-xchacha(
    Buf $opus-data, Buf $secret-key,
    Int :$ssrc, Int :$sequence, Int :$timestamp, Int :$nonce-counter = 0,
    --> Blob
) is export {
    check-libsodium();
    my $header = build-rtp-header(:$sequence, :$timestamp, :$ssrc);

    # 24-byte nonce: 4-byte LE counter + 20 zero bytes
    my $nonce = Buf.new(0 xx 24);
    $nonce[0] =  $nonce-counter        +& 0xFF;
    $nonce[1] = ($nonce-counter +>  8) +& 0xFF;
    $nonce[2] = ($nonce-counter +> 16) +& 0xFF;
    $nonce[3] = ($nonce-counter +> 24) +& 0xFF;

    my $plain  = Blob.new($opus-data.list);
    my $cipher = Blob.new(0 xx ($plain.elems + MACBYTES));
    my $ad     = Blob.new($header.list);  # additional data = RTP header

    my $rc = crypto_aead_xchacha20poly1305_ietf_encrypt(
        $cipher, 0, $plain, $plain.elems,
        $ad, $ad.elems, Blob.new, Blob.new($nonce.list), Blob.new($secret-key.list)
    );
    die "crypto_aead_xchacha20poly1305_ietf_encrypt failed: rc=$rc" if $rc != 0;

    # Packet = RTP header ++ ciphertext ++ 4-byte nonce suffix
    Blob.new(|$header.list, |$cipher.list, $nonce[0], $nonce[1], $nonce[2], $nonce[3]);
}

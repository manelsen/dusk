#!/usr/bin/env raku
# Voice Engine Smoke Test
# Spec: https://discord.com/developers/docs/topics/voice-connections
# Voice Gateway v8 | aead_aes256_gcm_rtpsize | OP5 Speaking | NativeCall UDP

use lib 'lib';
use JSON::Fast;
use Cro::HTTP::Client;
use Cro::WebSocket::Client;
use Dusk::Voice::Audio;
use NativeCall;

# ─── POSIX UDP via NativeCall ─────────────────────────────────────────────────
# IO::Socket::INET faz connect() TCP mesmo com :udp no Rakudo.
# Usamos syscalls POSIX diretos.

sub c-socket(int32, int32, int32 --> int32)       is symbol('socket')    is native { * }
sub c-close(int32 --> int32)                       is symbol('close')     is native { * }
sub c-htons(uint16 --> uint16)                     is symbol('htons')     is native { * }
sub c-inet-addr(Str --> uint32)                    is symbol('inet_addr') is native { * }
sub c-setsockopt(int32, int32, int32, Blob, uint32 --> int32)
is symbol('setsockopt') is native { * }
sub c-sendto(int32, Blob, size_t, int32, Blob, uint32 --> ssize_t)
is symbol('sendto')  is native { * }
sub c-recvfrom(int32, Buf, size_t, int32, Blob, uint32 is rw --> ssize_t)
is symbol('recvfrom') is native { * }

sub make-sa(Str $ip, Int $port --> Buf) {
    my $sa = Buf.new(0 xx 16);
    $sa.write-uint16(0, 2);
    $sa.write-uint16(2, c-htons($port));
    $sa.write-uint32(4, c-inet-addr($ip));
    $sa;
}

sub new-udp-fd(--> int32) {
    my $fd = c-socket(2, 2, 0);
    die "socket() = $fd" if $fd < 0;
    my $tv = Buf.new(0 xx 16);
    $tv.write-uint64(0, 5);          # 5s recv timeout
    c-setsockopt($fd, 1, 20, $tv, 16);
    $fd;
}
sub udp-send(int32 $fd, Blob $p, Str $ip, Int $port) {
    c-sendto($fd, $p, $p.elems, 0, make-sa($ip, $port), 16);
}
sub udp-recv(int32 $fd, Int $n = 74 --> Buf) {
    my $buf = Buf.new(0 xx $n);
    my $sa  = Buf.new(0 xx 16);
    my uint32 $alen = 16;
    my $got = c-recvfrom($fd, $buf, $n, 0, $sa, $alen);
    $got > 0 ?? Buf.new($buf.subbuf(0, $got).list) !! Buf.new;
}

# ─── libsodium — AES-256-GCM (aead_aes256_gcm_rtpsize) ──────────────────────
# Nonce: 4-byte big-endian incrementing counter, appended at end of packet
# Packet: RTP-header(12) ++ GCM-ciphertext(N+MACBYTES) ++ nonce(4)

constant LIBSODIUM = 'libsodium.so.23';
sub crypto_aead_aes256gcm_encrypt(
    Blob,   # ciphertext out
    uint64, # clen_p (pass 0 = ignored)
    Blob,   # plaintext
    uint64, # plen
    Blob,   # additional data (RTP header)
    uint64, # adlen
    Blob,   # nsec (NULL)
    Blob,   # nonce (12 bytes for GCM)
    Blob,   # key (32 bytes)
    --> int32
) is symbol('crypto_aead_aes256gcm_encrypt') is native(LIBSODIUM) { * }

sub encrypt-aes256gcm(
    Buf $opus, Buf $key,
    Int :$ssrc, Int :$seq, Int :$ts, Int :$nonce-ctr
    --> Buf
) {
    # Build 12-byte RTP header
    my $header = Buf.new(
        0x80, 0x78,
        ($seq +> 8) +& 0xFF, $seq +& 0xFF,
        ($ts  +> 24) +& 0xFF, ($ts +> 16) +& 0xFF, ($ts +> 8) +& 0xFF, $ts +& 0xFF,
        ($ssrc +> 24) +& 0xFF, ($ssrc +> 16) +& 0xFF, ($ssrc +> 8) +& 0xFF, $ssrc +& 0xFF,
    );

    # 12-byte nonce: 4-byte BE counter padded with 8 zeros
    my $nonce = Buf.new(0 xx 12);
    $nonce[0] = ($nonce-ctr +> 24) +& 0xFF;
    $nonce[1] = ($nonce-ctr +> 16) +& 0xFF;
    $nonce[2] = ($nonce-ctr +>  8) +& 0xFF;
    $nonce[3] =  $nonce-ctr        +& 0xFF;

    my $plain  = Blob.new($opus.list);
    my $cipher = Blob.new(0 xx ($plain.elems + 16));  # +MACBYTES(16)

    my $rc = crypto_aead_aes256gcm_encrypt(
        $cipher, 0,
        $plain,  $plain.elems,
        Blob.new($header.list), 12,
        Blob.new,
        Blob.new($nonce.list),
        Blob.new($key.list),
    );
    die "AES-256-GCM encrypt failed: rc=$rc" if $rc != 0;

    # Packet = RTP header ++ ciphertext ++ 4-byte nonce suffix
    Buf.new(|$header.list, |$cipher.list, $nonce[0], $nonce[1], $nonce[2], $nonce[3]);
}

# ─── Config ───────────────────────────────────────────────────────────────────
my $token      = %*ENV<DISCORD_BOT_TOKEN> or die "DISCORD_BOT_TOKEN ausente";
my $guild-id   = %*ENV<GUILD_ID>          or die "GUILD_ID ausente";
my $channel-id = %*ENV<VOICE_CHANNEL_ID>  or die "VOICE_CHANNEL_ID ausente";

say "=== Dusk Voice Engine — Smoke Test ===\n";

# ─── 1. User ID ───────────────────────────────────────────────────────────────
say "[1] Obtendo ID do bot...";
my $me = from-json(await (await Cro::HTTP::Client.new(
            base-uri => 'https://discord.com',
            headers  => [Authorization => "Bot $token"],
        ).get('/api/v10/users/@me')).body-text);
my $user-id = $me<id>.Int;
say "    Bot: $me<username> (ID: $user-id)";

# ─── 2. Gateway principal → VOICE_SERVER_UPDATE ───────────────────────────────
say "\n[2] Gateway principal...";
my $gw    = await Cro::WebSocket::Client.new.connect('wss://gateway.discord.gg/?v=10&encoding=json');
my $gw-ch = Channel.new;
start { react { whenever $gw-ch -> $p { $gw.send($p) } } }

my ($session-id, $voice-token, $voice-endpoint, $voice-session-id);
my $voice-got = Promise.new;

react {
    whenever $gw.messages -> $msg {
        my $d = from-json(await $msg.body-text);
        given $d<op> {
            when 10 {
                my $iv = $d<d><heartbeat_interval>;
                say "    HELLO ({$iv}ms)";
                start { loop { sleep $iv/1000; $gw-ch.send(to-json({op=>1, d=>Nil})) } }
                $gw-ch.send(to-json({op=>2, d=>{
                                token=>$token, intents=>0,
                                properties=>{os=>'linux',browser=>'dusk',device=>'dusk'}
                }}));
            }
            when 0 {
                given $d<t> {
                    when 'READY' {
                        $session-id = $d<d><session_id>;
                        say "    READY session=$session-id";
                        $gw-ch.send(to-json({op=>4, d=>{
                                        guild_id=>$guild-id, channel_id=>$channel-id,
                                        self_mute=>False, self_deaf=>False
                        }}));
                    }
                    when 'VOICE_STATE_UPDATE' {
                        $voice-session-id = $d<d><session_id> if $d<d><session_id>;
                        say "    VOICE_STATE_UPDATE session=$voice-session-id";
                    }
                    when 'VOICE_SERVER_UPDATE' {
                        $voice-token    = $d<d><token>;
                        $voice-endpoint = $d<d><endpoint>.subst(/^'wss://'/, '');
                            say "    VOICE_SERVER_UPDATE endpoint=$voice-endpoint";
                            $voice-got.keep if $voice-got.status == Planned;
                            done;
                            }
                            }
                            }
                            }
                            }
                            whenever Promise.in(12) { say "    TIMEOUT"; done }
                            }
                            die "Sem VOICE_SERVER_UPDATE" unless $voice-got.status == Kept;

                            # ─── 3-5. Voice Gateway v8 ────────────────────────────────────────────────────
                            say "\n[3-5] Voice Gateway v8...";
                            my $vgw   = await Cro::WebSocket::Client.new.connect("wss://{$voice-endpoint}/?v=8");
                            my $vch   = Channel.new;
                            start { react { whenever $vch -> $p { $vgw.send($p) } } }

                            my ($ssrc, $server-ip, $server-port, $secret-key, $enc-mode);
                            my $vs-done  = Promise.new;
                            my $vseq-ack = 0;

                            react {
                            whenever $vgw.messages -> $msg {
                            my $d = from-json(await $msg.body-text);
                            $vseq-ack = $d<seq> if $d<seq>;
                            given $d<op> {
                            when 8 {  # HELLO
                            my $iv = $d<d><heartbeat_interval>;
                            say "    Voice HELLO ({$iv}ms)";
                            start { loop { sleep $iv/1000;
                            $vch.send(to-json({op=>3, d=>{t=>(now*1000).Int, seq_ack=>$vseq-ack}})) } }
                            $vch.send(to-json({op=>0, d=>{
                            server_id  => $guild-id,
                            user_id    => ~$user-id,
                            session_id => ($voice-session-id // $session-id),
                            token      => $voice-token,
                            }}));
                            say "    OP 0 IDENTIFY";
                            }
                            when 2 {  # READY → UDP Discovery
                            $ssrc        = $d<d><ssrc>;
                            $server-ip   = $d<d><ip>;
                            $server-port = $d<d><port>;
                            my @modes    = @($d<d><modes>);
                            $enc-mode    = @modes[0];  # usar o primeiro modo oferecido
                            say "    OP 2 READY — SSRC=$ssrc ip=$server-ip:$server-port";
                            say "    Modos: " ~ @modes.join(', ');
                            say "    Modo escolhido: $enc-mode";

                            start {
                            CATCH { default { say "ERRO UDP: " ~ .message } }
                            my $fd  = new-udp-fd();
                            my $pkt = Buf.new(0 xx 74);
                            $pkt[0]=0; $pkt[1]=1; $pkt[2]=0; $pkt[3]=70;
                            $pkt[4]=($ssrc+>24)+&0xFF; $pkt[5]=($ssrc+>16)+&0xFF;
                            $pkt[6]=($ssrc+>8)+&0xFF;  $pkt[7]=$ssrc+&0xFF;
                            say "    IP Discovery...";
                            udp-send($fd, $pkt, $server-ip, $server-port);
                            my $resp = udp-recv($fd, 74);
                            c-close($fd);
                            if $resp.elems >= 74 {
                            my $pub-ip   = Buf.new($resp[8..71].grep({$_!=0}).list).decode('ascii');
                        my $pub-port = ($resp[72]+<8)+|$resp[73];
                        say "    IP público: $pub-ip:$pub-port";
                        $vch.send(to-json({op=>1, d=>{
                                        protocol=>'udp',
                                        data=>{address=>$pub-ip, port=>$pub-port, mode=>$enc-mode}
                        }}));
                        say "    OP 1 SELECT_PROTOCOL";
                    } else {
                        say "    Discovery falhou ({$resp.elems}B)";
                    }
                }
            }
            when 4 {  # SESSION_DESCRIPTION
                $secret-key = Buf.new(@($d<d><secret_key>));
                $enc-mode   = $d<d><mode>;
                say "    OP 4 SESSION_DESCRIPTION — {$secret-key.elems}B key, mode=$enc-mode ✅";
                $vs-done.keep if $vs-done.status == Planned;
                done;
            }
            when 6 { say "    OP 6 ACK" }
        }
    }
    whenever Promise.in(25) { say "    TIMEOUT Voice handshake"; done }
}
die "SESSION_DESCRIPTION não recebida" unless $vs-done.status == Kept;

# ─── 6. Tocar áudio ───────────────────────────────────────────────────────────
say "\n[6] Enviando áudio...";
$vch.send(to-json({op=>5, d=>{speaking=>1, delay=>0, ssrc=>$ssrc}}));
say "    OP 5 SPEAKING ✅";

my $sine = $*TMPDIR.child('dusk-smoke.ogg');
run 'ffmpeg', '-y', '-f', 'lavfi', '-i', 'sine=frequency=440:duration=3',
'-ac', '2', '-ar', '48000', '-c:a', 'libopus', '-b:a', '96k',
$sine.Str, :err(Nil), :out(Nil);

my $audio     = Dusk::Voice::Audio.new(source => $sine.Str);
my $play-fd   = new-udp-fd();
my ($seq, $ts, $frames, $nc) = 0, 0, 0, 0;

react {
    whenever $audio.frames -> $opus {
        my $packet = encrypt-aes256gcm(
            Buf.new($opus.list), $secret-key,
            ssrc => $ssrc, seq => ++$seq, ts => ($ts += 960), nonce-ctr => ++$nc,
        );
        udp-send($play-fd, Buf.new($packet.list), $server-ip, $server-port);
        $frames++;
        sleep 0.020;
    }
}

c-close($play-fd);
$vch.send(to-json({op=>5, d=>{speaking=>0, delay=>0, ssrc=>$ssrc}}));
$sine.unlink;

say "\n✅ $frames frames Opus enviados ({($frames*0.02).fmt('%.1f')}s)";
say "   Se ouviu 440Hz → Voice Engine funcional ponta a ponta! 🎺";

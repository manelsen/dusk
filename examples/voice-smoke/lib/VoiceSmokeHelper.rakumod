## VoiceSmokeHelper — shared utilities for all Dusk voice smoke tests.
## Encapsulates: Gateway v10 → Voice Gateway v8 handshake, POSIX UDP, AES-256-GCM encryption.

unit module VoiceSmokeHelper;

use JSON::Fast;
use Cro::HTTP::Client;
use Cro::WebSocket::Client;
use Dusk::Voice::Audio;
use NativeCall;

# --- POSIX UDP ----------------------------------------------------------------
sub c-socket(int32, int32, int32 --> int32)            is symbol('socket')    is native is export { * }
sub c-close(int32 --> int32)                           is symbol('close')     is native is export { * }
sub c-htons(uint16 --> uint16)                         is symbol('htons')     is native is export { * }
sub c-inet-addr(Str --> uint32)                        is symbol('inet_addr') is native is export { * }
sub c-setsockopt(int32, int32, int32, Blob, uint32 --> int32)
    is symbol('setsockopt') is native is export { * }
sub c-sendto(int32, Blob, size_t, int32, Blob, uint32 --> ssize_t)
    is symbol('sendto')  is native is export { * }
sub c-recvfrom(int32, Buf, size_t, int32, Blob, uint32 is rw --> ssize_t)
    is symbol('recvfrom') is native is export { * }

sub make-sockaddr(Str $ip, Int $port --> Buf) is export {
    my $sa = Buf.new(0 xx 16);
    $sa.write-uint16(0, 2);
    $sa.write-uint16(2, c-htons($port));
    $sa.write-uint32(4, c-inet-addr($ip));
    $sa;
}

sub udp-new(--> int32) is export {
    my $fd = c-socket(2, 2, 0);
    die "socket() = $fd" if $fd < 0;
    my $tv = Buf.new(0 xx 16);
    $tv.write-uint64(0, 5);
    c-setsockopt($fd, 1, 20, $tv, 16);
    $fd;
}

sub udp-send(int32 $fd, Blob $p, Str $ip, Int $port) is export {
    c-sendto($fd, $p, $p.elems, 0, make-sockaddr($ip, $port), 16);
}

sub udp-recv(int32 $fd, Int $n = 74 --> Buf) is export {
    my $buf = Buf.new(0 xx $n);
    my $sa  = Buf.new(0 xx 16);
    my uint32 $alen = 16;
    my $got = c-recvfrom($fd, $buf, $n, 0, $sa, $alen);
    $got > 0 ?? Buf.new($buf.subbuf(0, $got).list) !! Buf.new;
}

# --- AES-256-GCM (aead_aes256_gcm_rtpsize) -----------------------------------
constant LIBSODIUM = 'libsodium.so.23';

sub crypto_aead_aes256gcm_encrypt(Blob, uint64, Blob, uint64, Blob, uint64, Blob, Blob, Blob --> int32)
    is symbol('crypto_aead_aes256gcm_encrypt') is native(LIBSODIUM) is export { * }

sub encrypt-rtp(Buf $opus, Buf $key, Int :$ssrc, Int :$seq, Int :$ts, Int :$nc --> Buf) is export {
    my $h = Buf.new(
        0x80, 0x78,
        ($seq +> 8) +& 0xFF, $seq +& 0xFF,
        ($ts  +> 24) +& 0xFF, ($ts  +> 16) +& 0xFF, ($ts  +> 8) +& 0xFF, $ts  +& 0xFF,
        ($ssrc+> 24) +& 0xFF, ($ssrc+> 16) +& 0xFF, ($ssrc+> 8) +& 0xFF, $ssrc+& 0xFF,
    );
    my $nonce = Buf.new(0 xx 12);
    $nonce[0] = ($nc +> 24) +& 0xFF;
    $nonce[1] = ($nc +> 16) +& 0xFF;
    $nonce[2] = ($nc +>  8) +& 0xFF;
    $nonce[3] =  $nc        +& 0xFF;
    my $plain  = Blob.new($opus.list);
    my $cipher = Blob.new(0 xx ($plain.elems + 16));
    my $rc = crypto_aead_aes256gcm_encrypt(
        $cipher, 0, $plain, $plain.elems,
        Blob.new($h.list), 12, Blob.new,
        Blob.new($nonce.list), Blob.new($key.list),
    );
    die "AES-GCM failed: rc=$rc" if $rc != 0;
    Buf.new(|$h.list, |$cipher.list, $nonce[0], $nonce[1], $nonce[2], $nonce[3]);
}

# --- Voice session structure --------------------------------------------------
class VoiceSession is export {
    has Str $.token      is required;
    has Str $.guild-id   is required;
    has Str $.channel-id is required;

    has Str    $.server-ip;
    has Int    $.server-port;
    has Int    $.ssrc;
    has Buf    $.secret-key;
    has Str    $.enc-mode;

    has        $!gw-ws;
    has        $!vgw-ws;
    has Channel $!gw-ch;
    has Channel $!vch;
    has int32   $!udp-fd;

    method bot-id(--> Int) {
        from-json(await (await Cro::HTTP::Client.new(
            base-uri => 'https://discord.com',
            headers  => [Authorization => "Bot $!token"],
        ).get('/api/v10/users/@me')).body-text)<id>.Int;
    }

    #| Performs full handshake and stores internal attributes.
    #| Returns self for chaining.
    method connect(--> VoiceSession) {
        my $user-id = self.bot-id;

        # Main Gateway
        $!gw-ws = await Cro::WebSocket::Client.new
            .connect('wss://gateway.discord.gg/?v=10&encoding=json');
        $!gw-ch = Channel.new;
        start { react { whenever $!gw-ch -> $p { $!gw-ws.send($p) } } }

        my ($session-id, $voice-token, $voice-endpoint, $voice-session-id);
        my $vgot = Promise.new;

        react {
            whenever $!gw-ws.messages -> $msg {
                my $d = from-json(await $msg.body-text);
                given $d<op> {
                    when 10 {
                        my $iv = $d<d><heartbeat_interval>;
                        start { loop { sleep $iv/1000; $!gw-ch.send(to-json({op=>1,d=>Nil})) } }
                        $!gw-ch.send(to-json({op=>2, d=>{
                            token=>$!token, intents=>0,
                            properties=>{os=>'linux',browser=>'dusk',device=>'dusk'}
                        }}));
                    }
                    when 0 {
                        given $d<t> {
                            when 'READY' {
                                $session-id = $d<d><session_id>;
                                $!gw-ch.send(to-json({op=>4, d=>{
                                    guild_id=>$!guild-id, channel_id=>$!channel-id,
                                    self_mute=>False, self_deaf=>False
                                }}));
                            }
                            when 'VOICE_STATE_UPDATE' {
                                $voice-session-id = $d<d><session_id> if $d<d><session_id>;
                            }
                            when 'VOICE_SERVER_UPDATE' {
                                $voice-token    = $d<d><token>;
                                $voice-endpoint = $d<d><endpoint>.subst(/^'wss://'/, '');
                                $vgot.keep if $vgot.status == Planned;
                                done;
                            }
                        }
                    }
                }
            }
            whenever Promise.in(15) { done }
        }
        die "Missing VOICE_SERVER_UPDATE" unless $vgot.status == Kept;

        # Voice Gateway v8
        $!vgw-ws = await Cro::WebSocket::Client.new
            .connect("wss://$voice-endpoint/?v=8");
        $!vch = Channel.new;
        start { react { whenever $!vch -> $p { $!vgw-ws.send($p) } } }

        my $sdone = Promise.new;
        my $vseq-ack = 0;

        react {
            whenever $!vgw-ws.messages -> $msg {
                my $d = from-json(await $msg.body-text);
                $vseq-ack = $d<seq> if $d<seq>;
                given $d<op> {
                    when 8 {
                        my $iv = $d<d><heartbeat_interval>;
                        start { loop { sleep $iv/1000;
                            $!vch.send(to-json({op=>3, d=>{t=>(now*1000).Int, seq_ack=>$vseq-ack}})) } }
                        $!vch.send(to-json({op=>0, d=>{
                            server_id  => $!guild-id,
                            user_id    => ~$user-id,
                            session_id => ($voice-session-id // $session-id),
                            token      => $voice-token,
                        }}));
                    }
                    when 2 {
                        $!ssrc        = $d<d><ssrc>;
                        $!server-ip   = $d<d><ip>;
                        $!server-port = $d<d><port>;
                        my @modes     = @($d<d><modes>);
                        $!enc-mode    = @modes[0];

                        start {
                            CATCH { default { warn "UDP Discovery: " ~ .message } }
                            my $fd  = udp-new();
                            my $pkt = Buf.new(0 xx 74);
                            $pkt[0]=0; $pkt[1]=1; $pkt[2]=0; $pkt[3]=70;
                            $pkt[4]=($!ssrc+>24)+&0xFF; $pkt[5]=($!ssrc+>16)+&0xFF;
                            $pkt[6]=($!ssrc+>8)+&0xFF;  $pkt[7]=$!ssrc+&0xFF;
                            udp-send($fd, $pkt, $!server-ip, $!server-port);
                            my $r = udp-recv($fd, 74);
                            c-close($fd);
                            if $r.elems >= 74 {
                                my $pub-ip   = Buf.new($r[8..71].grep({$_!=0}).list).decode('ascii');
                                my $pub-port = ($r[72]+<8)+|$r[73];
                                $!vch.send(to-json({op=>1, d=>{
                                    protocol=>'udp',
                                    data=>{address=>$pub-ip, port=>$pub-port, mode=>$!enc-mode}
                                }}));
                            }
                        }
                    }
                    when 4 {
                        $!secret-key = Buf.new(@($d<d><secret_key>));
                        $!enc-mode   = $d<d><mode>;
                        $sdone.keep if $sdone.status == Planned;
                        done;
                    }
                }
            }
            whenever Promise.in(25) { done }
        }
        die "SESSION_DESCRIPTION not received" unless $sdone.status == Kept;

        $!udp-fd = udp-new();
        self;
    }

    #| Sends OP 5 Speaking on/off.
    method speaking(Bool $on) {
        $!vch.send(to-json({op=>5, d=>{
            speaking => $on ?? 1 !! 0,
            delay    => 0,
            ssrc     => $!ssrc,
        }}));
    }

    #| Plays an audio file and returns the number of frames sent.
    method play-file(Str $path --> Int) {
        self.speaking(True);
        my $audio = Dusk::Voice::Audio.new(source => $path);
        my ($seq, $ts, $nc, $frames) = 0, 0, 0, 0;
        react {
            whenever $audio.frames -> $opus {
                my $pkt = encrypt-rtp(
                    Buf.new($opus.list), $!secret-key,
                    ssrc => $!ssrc, seq => ++$seq, ts => ($ts += 960), nc => ++$nc,
                );
                udp-send($!udp-fd, Buf.new($pkt.list), $!server-ip, $!server-port);
                $frames++;
                sleep 0.020;
            }
        }
        self.speaking(False);
        $frames;
    }

    #| Moves to another voice channel in the same server.
    method move-to(Str $new-channel-id) {
        $!channel-id = $new-channel-id;
        $!gw-ch.send(to-json({op=>4, d=>{
            guild_id=>$!guild-id, channel_id=>$new-channel-id,
            self_mute=>False, self_deaf=>False
        }}));
        sleep 0.5;  # wait for VOICE_STATE_UPDATE
    }

    #| Disconnects from the voice channel.
    method disconnect() {
        # OP 4 with channel_id null = disconnect
        $!gw-ch.send(to-json({op=>4, d=>{
            guild_id=>$!guild-id, channel_id=>Any,
            self_mute=>False, self_deaf=>False
        }}));
        c-close($!udp-fd) if $!udp-fd;
    }
}

# --- Smoke test result --------------------------------------------------------
class SmokeResult is export {
    has Str  $.name    is required;
    has Bool $.passed  = False;
    has Str  $.detail  = '';
    has Rat  $.elapsed = 0.0;

    method ok(Str $msg)  { $!passed = True;  $!detail = $msg  }
    method fail(Str $msg) { $!passed = False; $!detail = $msg }

    method gist(--> Str) {
        my $icon = $!passed ?? '✅' !! '❌';
        "$icon  [{$.name.fmt('%-30s')}]  {$!elapsed.fmt('%.2f')}s  {$!detail}"
    }
}

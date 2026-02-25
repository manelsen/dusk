use Dusk::Voice::Gateway;
use Dusk::Voice::UDP;
use Dusk::Voice::Audio;
use Dusk::Voice::Crypto;
use Dusk::Error;

unit class Dusk::Voice::Client;

#| Guild ID for this voice session.
has Str $.guild-id   is required;

#| Voice channel ID to connect to.
has Str $.channel-id is required;

#| User ID of the bot.
has Int $.user-id    is required;

#| Set from VOICE_STATE_UPDATE before calling connect().
has Str $.session-id is rw = '';

#| Set from VOICE_SERVER_UPDATE before calling connect().
has Str $.token      is rw = '';

#| Set from VOICE_SERVER_UPDATE before calling connect().
has Str $.endpoint   is rw = '';

has Bool $!connected = False;
has $!gw;
has $!udp;
has $!stop-audio = False;

#| Whether the bot is currently connected to a voice channel.
method is-connected(--> Bool) { $!connected }

#| Establish full Voice connection: WebSocket handshake + UDP IP Discovery.
#| Requires session-id, token, and endpoint to be set beforehand.
method connect(--> Promise) {
    start {
        $!gw = Dusk::Voice::Gateway.new(
            endpoint   => $!endpoint,
            token      => $!token,
            session-id => $!session-id,
            guild-id   => $!guild-id.Int,
            user-id    => $!user-id,
        );

        await $!gw.connect();

        # UDP IP Discovery
        $!udp = Dusk::Voice::UDP.new(
            server-ip   => $!gw.server-ip,
            server-port => $!gw.server-port,
            ssrc        => $!gw.ssrc,
        );

        my $discovery = await $!udp.discover();

        # Tell Discord our public IP/port
        $!gw.send-select-protocol(ip => $discovery<ip>, port => $discovery<port>);

        # Wait for SESSION_DESCRIPTION (OP 4) — secret key arrives here
        my $session-ready = Promise.in(10);
        await Promise.anyof($session-ready, start { loop { last if $!gw.secret-key.elems == 32; sleep 0.1 } });
        die Dusk::Error::VoiceSessionTimeout.new() if $!gw.secret-key.elems != 32;

        $!connected = True;
    }
}

#| Play audio from $source (file path). Blocks until audio ends or stop() is called.
method play(Str $source --> Promise) {
    start {
        die "Not connected to voice" unless $!connected;
        $!stop-audio = False;

        my $audio = Dusk::Voice::Audio.new(source => $source);
        my $seq   = 0;
        my $ts    = 0;

        react {
            whenever $audio.frames() -> $pcm-frame {
                last if $!stop-audio;

                my $packet = Dusk::Voice::Crypto::encrypt-frame(
                    Buf.new($pcm-frame.list),
                    Buf.new($!gw.secret-key.list),
                    ssrc      => $!gw.ssrc,
                    sequence  => ++$seq,
                    timestamp => ($ts += 960),
                );
                $!udp.send-frame(Buf.new($packet.list));

                # Pace UDP frames at 20ms intervals
                sleep 0.020;
            }
        }
    }
}

#| Stop audio playback immediately.
method stop() {
    $!stop-audio = True;
}

#| Disconnect from voice, close WebSocket and UDP socket.
method disconnect() {
    $!stop-audio = True;
    $!gw.disconnect()  if $!gw;
    $!udp.close()      if $!udp;
    $!connected = False;
}

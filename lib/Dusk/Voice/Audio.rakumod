use Dusk::Error;

unit class Dusk::Voice::Audio;

#| Path to the audio source file (mp3, wav, ogg, flac, raw PCM, etc.).
has Str $.source      is required;

#| Path to the ffmpeg binary. Override in tests.
has Str $.ffmpeg-path = 'ffmpeg';

#| Audio channels — Discord requires 2 (stereo).
has Int $.channels    = 2;

#| Opus target bitrate in kbps.
has Int $.bitrate     = 96;

#| Parse OGG pages from a Buf, emit raw Opus packets via $supplier.
#| Returns the leftover (partial page) bytes for the next call.
#| Skips the first 2 pages (OpusHead + OpusTags header pages).
sub parse-ogg(Buf $data, Supplier $supplier, Int $page-count is rw --> Buf) {
    my $buf = $data;

    loop {
        # Need at least the fixed 27-byte header
        last if $buf.elems < 27;

        # Locate "OggS" magic
        my $pos = 0;
        my $found = False;
        while $pos <= $buf.elems - 4 {
            if $buf[$pos]   == 0x4F && $buf[$pos+1] == 0x67 &&
            $buf[$pos+2] == 0x67 && $buf[$pos+3] == 0x53 {
                $found = True;
                last;
            }
            $pos++;
        }
        last unless $found;

        # Trim everything before the magic
        $buf = Buf.new($buf.subbuf($pos).list) if $pos > 0;
        last if $buf.elems < 27;

        my $n-segs     = $buf[26];
        my $hdr-size   = 27 + $n-segs;
        last if $buf.elems < $hdr-size;

        # Segment table (lacing values)
        my @lace = $buf[27 ..^ $hdr-size];
        my $body-size = [+] @lace;
        last if $buf.elems < $hdr-size + $body-size;

        $page-count++;

        if $page-count > 2 {
            # Reconstruct packets using OGG lacing:
            # segments < 255 terminate a packet; segments of 255 continue it.
            my $body-offset = $hdr-size;
            my $pkt-buf     = Buf.new;

            for @lace -> $lace-val {
                $pkt-buf.append($buf.subbuf($body-offset, $lace-val));
                $body-offset += $lace-val;
                if $lace-val < 255 {
                    # End of packet
                    $supplier.emit(Buf.new($pkt-buf.list)) if $pkt-buf.elems > 0;
                    $pkt-buf = Buf.new;
                }
            }
            # Any remainder in $pkt-buf continues into the next page (lacing boundary);
            # we discard it here as it will be part of the next page's first segment.
        }

        $buf = Buf.new($buf.subbuf($hdr-size + $body-size).list);
    }

    $buf;
}

#| Returns a Supply that emits one raw Opus packet (Buf) per 20ms frame.
#| Packets are ready to be encrypted and sent over Discord RTP.
method frames(--> Supply) {
    my $supplier = Supplier.new;

    start {
        # For raw PCM .raw files: declare input format explicitly.
        my @input-flags = $!source.ends-with('.raw')
        ?? ('-f', 's16le', '-ar', '48000', '-ac', ~$!channels)
        !! ();

        # Produce Ogg/Opus; we extract raw Opus packets from the OGG pages.
        my $proc = Proc::Async.new(
            $!ffmpeg-path, '-y',
            |@input-flags,
            '-i',              $!source,
            '-ac',             ~$!channels,
            '-ar',             '48000',
            '-c:a',            'libopus',
            '-b:a',            "{$!bitrate}k",
            '-frame_duration', '20',
            '-f',              'ogg',
            '-',
            :err,
        );

        my $ogg-buf    = Buf.new;
        my Int $pages  = 0;

        react {
            whenever $proc.stdout(:bin) -> $chunk {
                $ogg-buf.append($chunk);
                $ogg-buf = parse-ogg($ogg-buf, $supplier, $pages);
            }
            whenever $proc.start {
                $ogg-buf = parse-ogg($ogg-buf, $supplier, $pages) if $ogg-buf.elems > 0;
                $supplier.done;
            }
            CATCH {
                default {
                    $supplier.quit(Dusk::Error::FfmpegNotFound.new());
                }
            }
        }
    }

    $supplier.Supply;
}

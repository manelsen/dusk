use Dusk::Error;

unit class Dusk::Voice::Audio;

#| Path to the audio source file. Use '-' for stdin.
has Str $.source     is required;

#| Number of PCM samples per 20ms frame (Discord standard: 960 @ 48kHz).
has Int $.frame-size = 960;

#| Number of audio channels (Discord standard: 2 stereo).
has Int $.channels   = 2;

#| Returns a Supply that emits one Buf per 20ms PCM frame.
#| Each frame is exactly frame-size × channels × 2 bytes (Int16 LE).
method frames(--> Supply) {
    my $bytes-per-frame = $!frame-size * $!channels * 2;  # Int16 = 2 bytes
    my $supplier = Supplier.new;

    start {
        my $proc = Proc::Async.new(
            'ffmpeg',
            '-i', $!source,
            '-ac', ~$!channels,
            '-ar', '48000',
            '-f',  's16le',
            '-',
            :err,
        );

        my $buffer = Buf.new;

        react {
            whenever $proc.stdout(:bin) -> $chunk {
                $buffer.append($chunk);
                while $buffer.elems >= $bytes-per-frame {
                    $supplier.emit(Buf.new($buffer.subbuf(0, $bytes-per-frame).list));
                    $buffer = Buf.new($buffer.subbuf($bytes-per-frame).list);
                }
            }
            whenever $proc.start {
                $supplier.emit(Buf.new($buffer.list)) if $buffer.elems > 0;
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

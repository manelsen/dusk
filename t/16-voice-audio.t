use v6;
use Test;

# Gate 05: Fail-First — these tests must ALL FAIL before Voice::Audio is implemented.

# Skip gracefully if ffmpeg is not installed on this machine
my $ffmpeg-available = (try { run('which', 'ffmpeg', :out, :err).exitcode == 0 }) // False;
unless $ffmpeg-available {
    say "1..0 # SKIP ffmpeg not found — install ffmpeg to run audio tests";
    exit 0;
}

plan 5;

# Fixture: create a small PCM raw file for testing
my $pcm-fixture = $*TMPDIR.child('dusk-test-audio.raw');
# 2 frames of silence: 960 samples × 2 ch × 2 bytes = 3840 bytes × 2
$pcm-fixture.spurt(Buf.new(0 xx (3840 * 2)));

# TC 16-01: frames() returns a Supply
subtest 'frames() returns a Supply', {
    use Dusk::Voice::Audio;

    my $audio = Dusk::Voice::Audio.new(source => $pcm-fixture.Str);
    my $s = $audio.frames();
    isa-ok $s, Supply, "frames() returns a Supply";
};

# TC 16-02: First emitted frame is a non-empty Buf
subtest 'First frame is a non-empty Buf', {
    use Dusk::Voice::Audio;

    my $audio = Dusk::Voice::Audio.new(source => $pcm-fixture.Str);
    my $first-frame;
    react {
        whenever $audio.frames() -> $frame {
            $first-frame = $frame;
            done;
        }
    }
    ok $first-frame.defined, "First frame emitted";
    isa-ok $first-frame, Buf, "First frame is a Buf";
    ok $first-frame.elems > 0, "First frame is non-empty";
};

# TC 16-03: Frame size is correct PCM size (960×2ch×2bytes = 3840)
subtest 'PCM frame size is exactly frame-size × channels × 2 bytes', {
    use Dusk::Voice::Audio;

    my $audio = Dusk::Voice::Audio.new(
        source     => $pcm-fixture.Str,
        frame-size => 960,
        channels   => 2,
    );
    my @frames;
    react {
        whenever $audio.frames() -> $frame {
            @frames.push($frame);
            done if @frames.elems >= 1;
        }
    }
    is @frames[0].elems, 960 * 2 * 2, "Frame is exactly 3840 bytes (960×2ch×2bytes)";
};

# TC 16-04: Supply completes after end of source
subtest 'Supply emits done after source exhausted', {
    use Dusk::Voice::Audio;

    my $audio = Dusk::Voice::Audio.new(source => $pcm-fixture.Str);
    my $done-seen = False;
    my @all-frames;
    react {
        whenever $audio.frames() -> $frame {
            @all-frames.push($frame);
            LAST { $done-seen = True }
        }
    }
    ok $done-seen, "Supply completed after end of source";
    is @all-frames.elems, 2, "Exactly 2 frames from 2-frame fixture";
};

# TC 16-05: FfmpegNotFound raised when ffmpeg not on PATH
subtest 'Missing ffmpeg raises FfmpegNotFound', {
    use Dusk::Voice::Audio;
    use Dusk::Error;

    # Override PATH to empty so ffmpeg cannot be found
    temp %*ENV<PATH> = '';

    throws-like {
        my $audio = Dusk::Voice::Audio.new(source => $pcm-fixture.Str);
        react { whenever $audio.frames() {} }
    },
    Dusk::Error::FfmpegNotFound,
    "FfmpegNotFound raised when ffmpeg absent from PATH";
};

# Cleanup fixture
$pcm-fixture.unlink if $pcm-fixture.e;

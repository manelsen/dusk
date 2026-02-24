use v6.d;

sub measure(&code) {
    my $start = now;
    &code();
    my $end = now;
    return $end - $start;
}

my $workers = 20;
my $ops-per-worker = 5000;
my $total-ops = $workers * $ops-per-worker;

say "=== Dusk Cache Architecture Benchmarks ===";
say "Workers: $workers | Ops per worker: $ops-per-worker | Total Ops: $total-ops";
say "-" x 50;

# ---------------------------------------------------------
# 1. Lock-based Hash (Balanced Read/Write)
# ---------------------------------------------------------
class LockCache {
    has %!store;
    has Lock $!lock .= new;

    method put($k, $v) {
        $!lock.protect: { %!store{$k} = $v }
    }
    method get($k) {
        $!lock.protect: { %!store{$k} }
    }
    method elems() {
        $!lock.protect: { %!store.elems }
    }
}

my $lock-cache = LockCache.new;
my $t-lock = measure {
    my @promises;
    for 1..$workers -> $w {
        @promises.push: start {
            for 1..$ops-per-worker -> $i {
                $lock-cache.put("{$w}-{$i}", "data");
                my $val = $lock-cache.get("{$w}-{$i}");
            }
        }
    }
    await @promises;
};

say "1. Lock-based Hash (Balanced):";
say "   Time:  " ~ $t-lock.fmt('%.4f') ~ "s";
say "   Elems: " ~ $lock-cache.elems;
say "   TPS:   " ~ (($total-ops * 2) / $t-lock).Int ~ " ops/sec";
say "-" x 50;


# ---------------------------------------------------------
# 2. Lock-based Hash (Read-Heavy - 90% Reads, 10% Writes)
# ---------------------------------------------------------
my $read-heavy = LockCache.new;
my $t-read = measure {
    my @promises;
    # Pre-populate
    $read-heavy.put("key-1", "data");
    
    for 1..$workers -> $w {
        @promises.push: start {
            for 1..$ops-per-worker -> $i {
                if $i %% 10 {
                    $read-heavy.put("{$w}-{$i}", "data");
                } else {
                    my $val = $read-heavy.get("key-1");
                }
            }
        }
    }
    await @promises;
};

say "2. Lock-based Hash (90% Reads):";
say "   Time:  " ~ $t-read.fmt('%.4f') ~ "s";
say "   Elems: " ~ $read-heavy.elems;
say "   TPS:   " ~ ($total-ops / $t-read).Int ~ " ops/sec";
say "-" x 50;


# ---------------------------------------------------------
# 3. LRU Queue Arrays (Messages approach)
# ---------------------------------------------------------
class LRUCache {
    has @!store;
    has Lock $!lock .= new;
    has Int $.max = 10_000;

    method put($v) {
        $!lock.protect: {
            @!store.push($v);
            @!store.shift if @!store.elems > $!max;
        }
    }
    method elems() { $!lock.protect: { @!store.elems } }
}

my $lru-cache = LRUCache.new(max => 5000);
my $t-lru = measure {
    my @promises;
    for 1..$workers -> $w {
        @promises.push: start {
            for 1..$ops-per-worker -> $i {
                $lru-cache.put("data-{$w}-{$i}");
            }
        }
    }
    await @promises;
};

say "3. Bounded LRU Array (Max 5000):";
say "   Time:  " ~ $t-lru.fmt('%.4f') ~ "s";
say "   Elems: " ~ $lru-cache.elems;
say "   TPS:   " ~ ($total-ops / $t-lru).Int ~ " writes/sec";
say "-" x 50;

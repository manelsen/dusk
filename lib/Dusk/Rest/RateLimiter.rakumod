use v6.d;

unit class Dusk::Rest::RateLimiter;

class Bucket {
    has Int $.limit is rw = 1;
    has Int $.remaining is rw = 1;
    has Rat $.reset-after is rw = 0.0;
    has Instant $.reset-at is rw = now;
    has Lock $!lock = Lock.new;
    has @!queue;
    has Bool $!timer-running = False;

    method acquire(--> Promise) {
        $!lock.protect: {
            # 1. Handle automatic reset if time has passed
            if now >= $!reset-at {
                $!remaining = $!limit;
            }

            # 2. If we have capacity, use it
            if $!remaining > 0 {
                $!remaining--;
                return Promise.kept;
            }

            # 3. Otherwise, queue the request
            my $p = Promise.new;
            @!queue.push($p);
            
            # 4. Ensure a timer is scheduled to drain the queue
            self!schedule-drain unless $!timer-running;
            
            return $p;
        }
    }

    method !schedule-drain() {
        $!timer-running = True;
        my $wait = max(0.01, $!reset-at - now);
        
        start {
            sleep $wait;
            $!lock.protect: {
                $!timer-running = False;
                # Reset capacity if time has passed
                if now >= $!reset-at {
                    $!remaining = $!limit;
                }
                
                # Drain as many as we can
                while @!queue && $!remaining > 0 {
                    my $qp = @!queue.shift;
                    $qp.keep;
                    $!remaining--;
                }
                
                # If there's more in the queue, reschedule
                self!schedule-drain if @!queue;
            }
        }
    }

    method update(%headers) {
        $!lock.protect: {
            $!limit       = (%headers<x-ratelimit-limit> // $!limit).Int;
            $!remaining   = (%headers<x-ratelimit-remaining> // $!remaining).Int;
            $!reset-after = (%headers<x-ratelimit-reset-after> // $!reset-after).Rat;
            $!reset-at    = now + $!reset-after;
        }
    }
}

has %!buckets;
has Lock $!global-lock = Lock.new;
has Instant $!global-reset = now;
has Promise $!global-promise = Promise.kept;

method acquire(Str $bucket-id --> Promise) {
    # 1. Check global lockout
    my $gp;
    $!global-lock.protect: {
        if now < $!global-reset {
            $gp = $!global-promise;
        }
    }

    if $gp.defined {
        return start {
            await $gp;
            await self!get-bucket($bucket-id).acquire;
        };
    }

    # 2. Check bucket limit
    return self!get-bucket($bucket-id).acquire;
}

method update(Str $bucket-id, %headers) {
    self!get-bucket($bucket-id).update(%headers);
}

method global-wait(Rat $duration) {
    $!global-lock.protect: {
        $!global-reset = now + $duration;
        $!global-promise = Promise.new;
        start {
            sleep $duration;
            $!global-promise.keep;
        }
    }
}

method !get-bucket(Str $id --> Bucket) {
    $!global-lock.protect: {
        %!buckets{$id} //= Bucket.new;
    }
}

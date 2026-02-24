=begin pod
=head1 Dusk::Cache

Agressive, high-performance in-memory cache for Discord objects.
Uses native Raku C<Lock> for thread-safety on state hashes, and a bounded C<LRU Array>
for high-volume events like messages to prevent Out-Of-Memory.
Invalidates and populates automatically via Gateway dispatch events.

=head2 Usage

    use Dusk::Cache;
    use Dusk::Gateway::Dispatcher;

    # By default, caches everything with max 10,000 messages.
    # You can disable specific caches to save memory:
    my $cache = Dusk::Cache.new(
        max-messages => 5000,
        disable      => <presences typing message-content>
    );

    $cache.listen($dispatcher);
    
    my $guild = $cache.get-guild('123456');

=end pod

unit class Dusk::Cache;

has %!guilds;
has %!channels;
has %!users;
has @!messages;

has Lock $!lock .= new;

has Int $.max-messages = 10_000;
has     @.disable;
has     %!disabled-lookup;
has     @!taps;

submethod TWEAK {
    %!disabled-lookup = @!disable.map: { $_ => True };
}

# --- Internal Core Setters (Lock Protected) ---

method put-guild(Str $id, %data) {
    return if %!disabled-lookup<guilds>;
    $!lock.protect: { %!guilds{$id} = %data }
}

method put-channel(Str $id, %data) {
    return if %!disabled-lookup<channels>;
    $!lock.protect: { %!channels{$id} = %data }
}

method put-user(Str $id, %data) {
    return if %!disabled-lookup<users>;
    $!lock.protect: { %!users{$id} = %data }
}

method put-message(%data) {
    return if %!disabled-lookup<messages>;
    $!lock.protect: {
        @!messages.push(%data);
        @!messages.shift if @!messages.elems > $!max-messages;
    }
}

# --- Query (Lock Protected) ---

method get-guild(Str $id --> Hash) {
    $!lock.protect: { %!guilds{$id} // %() }
}

method get-channel(Str $id --> Hash) {
    $!lock.protect: { %!channels{$id} // %() }
}

method get-user(Str $id --> Hash) {
    $!lock.protect: { %!users{$id} // %() }
}

method guild-count(--> Int)   { $!lock.protect: { %!guilds.elems } }
method channel-count(--> Int) { $!lock.protect: { %!channels.elems } }
method user-count(--> Int)    { $!lock.protect: { %!users.elems } }
method message-count(--> Int) { $!lock.protect: { @!messages.elems } }

method all-guilds()   { $!lock.protect: { %!guilds.values.List } }
method all-channels() { $!lock.protect: { %!channels.values.List } }
method all-messages() { $!lock.protect: { @!messages.List } }

# --- Remove (Lock Protected) ---

method remove-guild(Str $id)   { $!lock.protect: { %!guilds.DELETE-KEY($id) } }
method remove-channel(Str $id) { $!lock.protect: { %!channels.DELETE-KEY($id) } }
method remove-user(Str $id)    { $!lock.protect: { %!users.DELETE-KEY($id) } }

# --- Gateway Integration ---

method listen($dispatcher) {
    @!taps.push: $dispatcher.on-guild-create.tap: -> $ev {
        my $raw = $ev.raw;
        self.put-guild(~$raw<id>, $raw);
        if $raw<channels> {
            self.put-channel(~$_<id>, $_) for $raw<channels>.list;
        }
        if $raw<members> {
            self.put-user(~$_<user><id>, $_<user>) for $raw<members>.list.grep({ $_<user> });
        }
    };

    @!taps.push: $dispatcher.on-guild-delete.tap: -> $ev { self.remove-guild(~$ev.id) };
    
    @!taps.push: $dispatcher.on-channel-create.tap: -> $ev { self.put-channel(~$ev.channel.id, $ev.raw) };
    @!taps.push: $dispatcher.on-channel-update.tap: -> $ev { self.put-channel(~$ev.channel.id, $ev.raw) };
    @!taps.push: $dispatcher.on-channel-delete.tap: -> $ev { self.remove-channel(~$ev.channel.id) };
    
    @!taps.push: $dispatcher.on-message-create.tap: -> $ev {
        self.put-message($ev.raw);
        my $a = $ev.raw<author>;
        self.put-user(~$a<id>, $a) if $a;
    };
    
    @!taps.push: $dispatcher.on-guild-member-add.tap: -> $ev {
        my $u = $ev.raw<user>;
        self.put-user(~$u<id>, $u) if $u;
    };
}

method stop() {
    .close for @!taps;
    @!taps = [];
}

method clear() {
    $!lock.protect: {
        %!guilds   = ();
        %!channels = ();
        %!users    = ();
        @!messages = [];
    }
}

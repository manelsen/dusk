=begin pod
=head1 Dusk::Cache

In-memory cache for Discord objects (Guilds, Channels, Users).
Invalidated automatically via Gateway dispatch events.

=head2 Usage

use Dusk::Cache;
use Dusk::Gateway::Dispatcher;

my $cache = Dusk::Cache.new;

# Wire up to Gateway events
$cache.listen($dispatcher);

# Query cache
my $guild = $cache.get-guild('123456');
my @channels = $cache.get-channels('123456');
my $user = $cache.get-user('789');

=end pod

unit class Dusk::Cache;

has %!guilds;
has %!channels;
has %!users;
has @!taps;

# --- Store ---

method put-guild(Str $id, %data) {
    %!guilds{$id} = %data;
}

method put-channel(Str $id, %data) {
    %!channels{$id} = %data;
}

method put-user(Str $id, %data) {
    %!users{$id} = %data;
}

# --- Query ---

method get-guild(Str $id --> Hash) {
    return %!guilds{$id} // %();
}

method get-channel(Str $id --> Hash) {
    return %!channels{$id} // %();
}

method get-user(Str $id --> Hash) {
    return %!users{$id} // %();
}

method guild-count(--> Int)   { %!guilds.elems }
method channel-count(--> Int) { %!channels.elems }
method user-count(--> Int)    { %!users.elems }

method all-guilds()   { %!guilds.values }
method all-channels() { %!channels.values }

# --- Remove ---

method remove-guild(Str $id)   { %!guilds.DELETE-KEY($id) }
method remove-channel(Str $id) { %!channels.DELETE-KEY($id) }
method remove-user(Str $id)    { %!users.DELETE-KEY($id) }

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
        my $a = $ev.raw<author>;
        self.put-user(~$a<id>, $a) if $a;
    };
    @!taps.push: $dispatcher.on-guild-member-add.tap: -> $ev {
        my $u = $ev.raw<user>;
        self.put-user(~$u<id>, $u) if $u;
    };
    @!taps.push: $dispatcher.on-guild-member-remove.tap: -> $ev { };
}

method stop() {
    .close for @!taps;
    @!taps = [];
}

method clear() {
    %!guilds   = ();
    %!channels = ();
    %!users    = ();
}

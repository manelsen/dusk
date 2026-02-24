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

method remove-guild(Str $id)   { %!guilds{$id}:delete }
method remove-channel(Str $id) { %!channels{$id}:delete }
method remove-user(Str $id)    { %!users{$id}:delete }

# --- Gateway Integration ---

method listen($dispatcher) {
    @!taps.push: $dispatcher.on-guild-create.tap: -> %d {
        self.put-guild(~%d<id>, %d);
        # Cache channels from guild payload
        if %d<channels> {
            for %d<channels>.list -> %ch {
                self.put-channel(~%ch<id>, %ch);
            }
        }
        # Cache members
        if %d<members> {
            for %d<members>.list -> %m {
                self.put-user(~%m<user><id>, %m<user>) if %m<user>;
            }
        }
    };

    @!taps.push: $dispatcher.on('GUILD_DELETE').tap: -> %d {
        self.remove-guild(~%d<id>);
    };

    @!taps.push: $dispatcher.on('CHANNEL_CREATE').tap: -> %d {
        self.put-channel(~%d<id>, %d);
    };

    @!taps.push: $dispatcher.on('CHANNEL_UPDATE').tap: -> %d {
        self.put-channel(~%d<id>, %d);
    };

    @!taps.push: $dispatcher.on('CHANNEL_DELETE').tap: -> %d {
        self.remove-channel(~%d<id>);
    };

    @!taps.push: $dispatcher.on-message-create.tap: -> %d {
        if %d<author> {
            self.put-user(~%d<author><id>, %d<author>);
        }
    };

    @!taps.push: $dispatcher.on('GUILD_MEMBER_ADD').tap: -> %d {
        self.put-user(~%d<user><id>, %d<user>) if %d<user>;
    };

    @!taps.push: $dispatcher.on('GUILD_MEMBER_REMOVE').tap: -> %d {
        # Don't remove user from cache — might be in other guilds
    };
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

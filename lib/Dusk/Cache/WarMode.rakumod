use v6.d;

unit class Dusk::Cache::WarMode;

#| Configuração de um Shard individual.
class Shard {
    has %!data;
    has Lock $!lock .= new;

    method put(Str $id, $val) {
        $!lock.protect: { %!data{$id} = $val }
    }

    method get(Str $id) {
        $!lock.protect: { %!data{$id} }
    }

    method remove(Str $id) {
        $!lock.protect: { %!data.DELETE-KEY($id) }
    }

    method count(--> Int) {
        $!lock.protect: { %!data.elems }
    }

    method clear() {
        $!lock.protect: { %!data = () }
    }
    
    method values() {
        $!lock.protect: { %!data.values.List }
    }
}

#| Número de shards (deve ser potência de 2 para o hash rápido).
constant SHARDS = 64;
constant MASK   = SHARDS - 1;

has @!guild-shards   = (1..SHARDS).map({ Shard.new });
has @!user-shards    = (1..SHARDS).map({ Shard.new });
has @!channel-shards = (1..SHARDS).map({ Shard.new });

has atomicint $!guild-count   = 0;
has atomicint $!user-count    = 0;
has atomicint $!channel-count = 0;

has @!taps;

#| Função de Hash rápida para IDs do Discord (Snowflakes).
#| Como Snowflakes são strings numéricas, pegamos os últimos bits.
sub hash-id(Str $id --> Int) {
    # Pega os últimos 6 bits do ID numérico para decidir o shard
    ($id.substr(*-2) // 0).Int +& MASK;
}

# --- Guilds ---
method put-guild(Str $id, $data) {
    my $idx = hash-id($id);
    my $shard = @!guild-shards[$idx];
    my $existed = $shard.get($id).defined;
    $shard.put($id, $data);
    $!guild-count++ unless $existed;
}
method get-guild(Str $id) { @!guild-shards[hash-id($id)].get($id) }
method remove-guild(Str $id) {
    my $shard = @!guild-shards[hash-id($id)];
    if $shard.get($id).defined {
        $shard.remove($id);
        $!guild-count--;
    }
}

# --- Users ---
method put-user(Str $id, $data) {
    my $idx = hash-id($id);
    my $shard = @!user-shards[$idx];
    my $existed = $shard.get($id).defined;
    $shard.put($id, $data);
    $!user-count++ unless $existed;
}
method get-user(Str $id) { @!user-shards[hash-id($id)].get($id) }

# --- Channels ---
method put-channel(Str $id, $data) {
    my $idx = hash-id($id);
    my $shard = @!channel-shards[$idx];
    my $existed = $shard.get($id).defined;
    $shard.put($id, $data);
    $!channel-count++ unless $existed;
}
method get-channel(Str $id) { @!channel-shards[hash-id($id)].get($id) }

# --- Stats ---
method guild-count()   { $!guild-count }
method user-count()    { $!user-count }
method channel-count() { $!channel-count }

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
    
    @!taps.push: $dispatcher.on-message-create.tap: -> $ev {
        my $a = $ev.raw<author>;
        self.put-user(~$a<id>, $a) if $a;
    };
}

method stop() {
    .close for @!taps;
    @!taps = [];
}

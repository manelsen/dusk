use v6.d;
use Test;
use Dusk::Internal::Parser;
use Dusk::Cache::WarMode;
use Dusk::Model::Guild;
use JSON::Fast;

plan 1;

# 1. Preparar Payload Gigante (Servidor com 10k membros)
diag "Preparing War-Mode Payload...";
my @members;
for 1..10000 -> $i { 
    @members.push({ user => { id => "ID$i", username => "User$i" }, roles => [] }); 
}
my %giant-guild = (
    id => "GUILD_WAR_1",
    name => "Warfront",
    members => @members,
    channels => (1..100).map({ { id => "$_", name => "ch", type => 0 } }).List
);
my $json-string = to-json(%giant-guild);

my $parser = Dusk::Internal::Parser.new(mode => ModeNative);
my $cache  = Dusk::Cache::WarMode.new;

subtest 'Total War: Native Parser + Sharded Cache' => {
    my $iterations = 100; # 100 servidores gigantes por thread
    my $threads = 10;
    
    diag "Launching $threads threads. Each processing $iterations giant guilds...";
    my $start = now;
    
    my @promises;
    for 1..$threads -> $t {
        @promises.push: start {
            for 1..$iterations -> $i {
                # PASSO 1: Parse Nativo (Metal)
                my $guild-obj = $parser.parse($json-string, model => Dusk::Model::Guild);
                
                # PASSO 2: Caching (Sharded)
                # Simulamos a lógica do Gateway: guardar guild, canais e membros
                $cache.put-guild($guild-obj.id ~ "-$t-$i", $guild-obj);
                
                # Simular extração de membros do objeto parseado para o cache de usuários
                # (Nota: No protótipo nativo mapeamos apenas ID e Name por enquanto)
                $cache.put-user("U-{$guild-obj.id}-$i", { name => "User" });
            }
        }
    }
    
    await Promise.allof(@promises);
    my $end = now;
    my $duration = $end - $start;
    
    diag "Total Time: {$duration.round(0.01)}s";
    diag "Throughput: {( ($iterations * $threads * $json-string.encode.elems) / 1024 / 1024 / $duration ).round(0.1)} MB/s";
    diag "Objects in Cache: {$cache.guild-count} guilds";
    
    ok $duration < 10, "Processed 1GB+ of JSON and populated cache under 10s";
};

done-testing;

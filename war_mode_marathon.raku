use v6.d;
use Dusk::Internal::Parser;
use Dusk::Cache::WarMode;
use Dusk::Model::Guild;
use JSON::Fast;

# Configurações Sustentáveis
my $duration = 300; # 5 minutos
my $threads  = 2;
my $log-file = 'war_mode_marathon.log';

# Preparar Payload (~150KB)
my @members;
for 1..1000 -> $i { @members.push({ user => { id => "ID$i", username => "U$i" }, roles => [] }); }
my $json-string = to-json({ id => "G", name => "WarMode", members => @members });
my $payload-size = $json-string.encode.elems;

my $parser = Dusk::Internal::Parser.new(mode => ModeNative);
my $cache  = Dusk::Cache::WarMode.new;
my $fh = open $log-file, :w;

say "Starting 5-minute marathon in foreground. Monitor: war_mode_marathon.log";
$fh.say: "--- MARATHON START ({now}) ---";

my atomicint $total-count = 0;
my $start-time = now;

my @promises;
for 1..$threads -> $t {
    @promises.push: start {
        while now - $start-time < $duration {
            try {
                my $obj = $parser.parse($json-string, model => Dusk::Model::Guild);
                $cache.put-guild("G-" ~ ($total-count % 5000), $obj);
                $total-count++;
                
                if $total-count % 1000 == 0 {
                    my $elapsed = now - $start-time;
                    my $tp = ($total-count * $payload-size / 1024 / 1024 / ($elapsed || 1)).round(0.1);
                    my $log-line = "[{$elapsed.Int}s] Processed: $total-count | Throughput: $tp MB/s";
                    $fh.say: $log-line;
                    $fh.flush;
                    # Também imprime no stdout para eu não parecer travado
                    say $log-line if $total-count % 5000 == 0;
                }
                # Sem sleep para estresse real, mas com cache limitado
            }
        }
    }
}

await Promise.allof(@promises);

my $final-elapsed = now - $start-time;
$fh.say: "--- MARATHON FINISHED --- Total: $total-count ---";
$fh.close;
say "Marathon finished successfully.";

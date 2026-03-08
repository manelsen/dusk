use v6.d;
use Dusk::Internal::Parser;
use Dusk::Model::Guild;

my %guild-data = (
    name => 'Mega Server',
    members => []
);

use JSON::Fast;
my $json = to-json(%guild-data);
my $parser = Dusk::Internal::Parser.new;
my $guild = $parser.parse($json, model => Dusk::Model::Guild);

say "Type: ", $guild.WHAT;
if $guild ~~ Dusk::Model::Guild {
    say "Name: ", $guild.name;
} else {
    say "Not a Guild object!";
    say $guild.perl;
}

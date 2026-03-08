use v6.d;
use Dusk::Internal::Parser;
use Dusk::Model::Guild;

my $json = '{"name": "test"}';
my $parser = Dusk::Internal::Parser.new(mode => ModeNQP);
my $obj = $parser.parse($json, model => Dusk::Model::Guild);

say "WHAT: ", $obj.WHAT;
say "Is Guild: ", $obj ~~ Dusk::Model::Guild;
say "Name: ", $obj.name;

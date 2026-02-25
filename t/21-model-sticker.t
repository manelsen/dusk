use v6.d;
use Test;
use JSON::Fast;
use Dusk::Model::Sticker;

plan 1;

subtest 'Sticker Parsing' => {
    my $json = "t/fixtures/rest_sticker.json".IO.slurp;
    my $data = from-json($json);
    
    my $sticker = Dusk::Model::Sticker.new(|$data[0]);
    
    isa-ok $sticker, Dusk::Model::Sticker, 'Correct type';
    is $sticker.id, "1457719681048907870", 'ID parsed';
    is $sticker.name, "grond_morning", 'Name parsed';
    is $sticker.tags, "coffee", 'Tags parsed';
    is $sticker.type, 2, 'Type parsed';
    is $sticker.format-type, 1, 'Format type parsed';
    is $sticker.guild-id, "1212124712629440612", 'Guild ID parsed';
};

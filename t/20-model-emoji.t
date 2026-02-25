use v6.d;
use Test;
use JSON::Fast;
use Dusk::Model::Emoji;

plan 1;

subtest 'Emoji Parsing' => {
    my $json = "t/fixtures/rest_emoji.json".IO.slurp;
    my $data = from-json($json);
    
    my $emoji = Dusk::Model::Emoji.new(|$data[0]);
    
    isa-ok $emoji, Dusk::Model::Emoji, 'Correct type';
    is $emoji.id, "1457062926287376497", 'ID parsed';
    is $emoji.name, "UniHands", 'Name parsed';
    nok $emoji.animated, 'Animated is false';
    ok $emoji.available, 'Available is true';
};

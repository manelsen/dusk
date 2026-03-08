use v6.d;
use Test;
use Dusk::Internal::Parser;
use Dusk::Model::User;

plan 4;

my $parser = Dusk::Internal::Parser.new;

subtest 'Malformed JSON' => {
    my $bad-json = '{"id": "123", "username": "test"'; # Faltando chave
    dies-ok { $parser.parse($bad-json) }, 'Throws error on incomplete JSON';
};

subtest 'Invalid Types' => {
    my $bad-json = '{"id": 12345}'; # ID deveria ser string, Raku vai reclamar se não houver coerção
    dies-ok { $parser.parse($bad-json, model => Dusk::Model::User) }, 'Throws error on model type mismatch';
};

subtest 'Empty or Null Data' => {
    is $parser.parse(''), Any, 'Empty string returns Any';
    is $parser.parse('null'), Any, 'Null JSON returns Any';
};

subtest 'Extreme Nesting (Security)' => {
    # Testar se um JSON profundamente aninhado estoura a pilha
    my $nested = '[' x 1000 ~ ']' x 1000;
    lives-ok { $parser.parse($nested) }, 'Handles 1000 levels of nesting without crashing VM';
};

done-testing;

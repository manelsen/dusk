use v6.d;
use JSON::Fast;

unit class Dusk::Internal::Parser::Raku;

#| O adapter Raku puro usa JSON::Fast e chama from-json nos modelos.
method parse($data, :$model) {
    return Any unless $data;
    
    my $json = from-json($data);
    
    if $model && $model.raku !~~ / ^ [Any|Mu] $/ {
        if $json {
            try {
                if $json ~~ Positional {
                    return $json.map({ $model.from-json($_) }).List;
                } else {
                    return $model.from-json($json);
                }
                CATCH { default { die "Dusk::Error::ModelInstantiationError: { .message }" } }
            }
        }
    }
    return $json;
}

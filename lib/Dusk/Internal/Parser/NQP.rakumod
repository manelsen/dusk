use v6.d;
use nqp;
use JSON::Fast;

unit class Dusk::Internal::Parser::NQP;

#| O adapter NQP ignora o MOP do Raku para instanciar modelos em alta velocidade.
method parse($data, :$model) {
    return Any unless $data;
    
    my $json = from-json($data);
    
    if ($model.defined || ($model.^name ne 'Any' && $model.^name ne 'Mu')) && $json {
        if $json ~~ Positional {
            my @list;
            for $json.list -> $item {
                @list.push(self!hydrate($model, $item));
            }
            return @list.List;
        } else {
            return self!hydrate($model, $json);
        }
    }
    return $json;
}

has %!attr-cache;

#| Hydrate injeta os dados do Hash diretamente nos atributos do objeto.
method !hydrate($class, $data) {
    # 1. Cria a instância via metamodelo
    my $obj = $class.CREATE;
    
    # 2. Busca ou gera o mapa de atributos para esta classe
    my $class-name = $class.^name;
    my %map = %!attr-cache{$class-name} // self!build-attr-map($class);

    # 3. Injeção direta
    for $data.kv -> $key, $val {
        my $attr = %map{$key};
        if $attr {
            try {
                $attr.set_value($obj, $val);
                CATCH { default { } }
            }
        }
    }
    
    return $obj;
}

method !build-attr-map($class) {
    my %map;
    for $class.^attributes -> $attr {
        # Converte $!guild-id para guild_id para bater com o JSON
        my $key = $attr.name.substr(2).subst('-', '_', :g);
        %map{$key} = $attr;
    }
    %!attr-cache{$class.^name} = %map;
}

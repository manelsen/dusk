use v6.d;
use Dusk::Util::JSONTraits;

unit role Dusk::Model::MapJSON;

#| Converte um Hash snake_case do Discord para o formato kebab-case esperado pelo .new da classe.
method from-json($self: Hash $data) {
    my %args;
    
    my $bool-attrs = /:i 'disabled'|'tts'|'mention'|'ephemeral'|'bot'|'system'|'nsfw'|'hoist'|'managed'|'mentionable'|'available'|'revoked'|'pending'/;

    for $self.^attributes -> $attr {
        my $kebab-name = $attr.name.substr(2);
        my $snake-name = $kebab-name.subst('-', '_', :g);
        
        if $data{$snake-name}:exists {
            my $val = $data{$snake-name};
            my $type = $attr.type;

            if $type.^name eq 'Bool' {
                %args{$kebab-name} = ?$val if $val.defined;
            }
            elsif $type ~~ Int {
                if $val ~~ Str && $val ~~ /:i ^ <[0..9a..f]>+ $/ {
                    %args{$kebab-name} = :16($val);
                } else {
                    %args{$kebab-name} = ($val // 0).Int;
                }
            }
            elsif $type ~~ Str {
                %args{$kebab-name} = $val.defined ?? ~$val !! '';
            }
            else {
                %args{$kebab-name} = $val;
            }
        } else {
            # Fallback para tipos básicos se não existe no JSON
            my $type = $attr.type;
            my $k-name = $kebab-name;
            
            if $type.^name eq 'Bool' || $k-name ~~ $bool-attrs { 
                %args{$k-name} = False; 
            }
            elsif $type ~~ Int { %args{$k-name} = 0 }
            elsif $attr.name ~~ /^ '$' / { %args{$k-name} = '' }
        }
    }
    
    return $self.new(|%args);
}

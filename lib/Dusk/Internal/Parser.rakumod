use v6.d;

unit class Dusk::Internal::Parser;

#| Tipos de parsers suportados
my enum ParserMode is export <ModeRaku ModeNQP ModeNative>;

has ParserMode $.mode = ModeRaku;
has $!adapter;

submethod TWEAK() {
    if $!mode == ModeRaku {
        require Dusk::Internal::Parser::Raku;
        $!adapter = Dusk::Internal::Parser::Raku.new;
    } elsif $!mode == ModeNQP {
        require Dusk::Internal::Parser::NQP;
        $!adapter = Dusk::Internal::Parser::NQP.new;
    } elsif $!mode == ModeNative {
        require Dusk::Internal::Parser::Native;
        $!adapter = Dusk::Internal::Parser::Native.new;
    }
}

#| Método principal: transforma JSON (Str ou Buf) em um Objeto ou Lista de Objetos.
method parse($data, :$model) {
    $!adapter.parse($data, :$model);
}

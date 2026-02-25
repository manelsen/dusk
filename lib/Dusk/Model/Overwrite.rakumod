use v6.d;

unit class Dusk::Model::Overwrite;

has Str $.id   is required;
has Int $.type is required;
has Str $.allow;
has Str $.deny;

method new(*%args) {
    self.bless(
        id    => ~(%args<id> // ''),
        type  => (%args<type> // 0).Int,
        allow => ~(%args<allow> // '0'),
        deny  => ~(%args<deny> // '0'),
    )
}

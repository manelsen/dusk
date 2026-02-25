use v6.d;

unit class Dusk::Model::Emoji;

has Str $.id;
has Str $.name;
has Bool $.animated;
has Bool $.managed;
has Bool $.available;

method new(*%args) {
    self.bless(
        id        => %args<id> // Str,
        name      => ~(%args<name> // ''),
        animated  => ?%args<animated>,
        managed   => ?%args<managed>,
        available => ?%args<available>,
    )
}

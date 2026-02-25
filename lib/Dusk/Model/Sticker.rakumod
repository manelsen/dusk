use v6.d;

unit class Dusk::Model::Sticker;

has Str $.id           is required;
has Str $.name         is required;
has Str $.description;
has Str $.tags;
has Int $.type;
has Int $.format-type;
has Bool $.available;
has Str $.guild-id;

method new(*%args) {
    self.bless(
        id          => ~(%args<id> // ''),
        name        => ~(%args<name> // ''),
        description => %args<description> // '',
        tags        => %args<tags> // '',
        type        => (%args<type> // 1).Int,
        format-type => (%args<format_type> // 1).Int,
        available   => ?%args<available>,
        guild-id    => %args<guild_id> // '',
    )
}

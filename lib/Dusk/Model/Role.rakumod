use v6.d;

unit class Dusk::Model::Role;

has Str $.id           is required;
has Str $.name         is required;
has Int $.color;
has Bool $.hoist;
has Str $.icon;
has Str $.unicode-emoji;
has Int $.position;
has Str $.permissions;
has Bool $.managed;
has Bool $.mentionable;

method new(*%args) {
    self.bless(
        id            => ~(%args<id> // ''),
        name          => ~(%args<name> // ''),
        color         => (%args<color> // 0).Int,
        hoist         => ?%args<hoist>,
        icon          => %args<icon> // '',
        unicode-emoji => %args<unicode_emoji> // '',
        position      => (%args<position> // 0).Int,
        permissions   => ~(%args<permissions> // '0'),
        managed       => ?%args<managed>,
        mentionable   => ?%args<mentionable>,
    )
}

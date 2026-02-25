use v6.d;

unit class Dusk::Model::Embed;

has Str $.title;
has Str $.type;
has Str $.description;
has Str $.url;
has Str $.timestamp;
has Int $.color;
has %.footer;
has %.image;
has %.thumbnail;
has %.video;
has %.provider;
has %.author;
has @.fields;

method new(*%args) {
    self.bless(
        title       => %args<title> // '',
        type        => %args<type> // 'rich',
        description => %args<description> // '',
        url         => %args<url> // '',
        timestamp   => %args<timestamp> // '',
        color       => (%args<color> // 0) ~~ Str ?? :16(%args<color>) !! (%args<color> // 0).Int,
        footer      => %args<footer> // {},
        image       => %args<image> // {},
        thumbnail   => %args<thumbnail> // {},
        video       => %args<video> // {},
        provider    => %args<provider> // {},
        author      => %args<author> // {},
        fields      => @(%args<fields> // []),
    )
}

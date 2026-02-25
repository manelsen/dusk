use v6.d;

unit class Dusk::Model::Attachment;

has Str $.id           is required;
has Str $.filename     is required;
has Str $.description;
has Str $.content-type;
has Int $.size;
has Str $.url;
has Str $.proxy-url;
has Int $.height;
has Int $.width;
has Bool $.ephemeral;

method new(*%args) {
    self.bless(
        id           => ~(%args<id> // ''),
        filename     => ~(%args<filename> // ''),
        description  => %args<description> // '',
        content-type => %args<content_type> // '',
        size         => (%args<size> // 0).Int,
        url          => %args<url> // '',
        proxy-url    => %args<proxy_url> // '',
        height       => %args<height> // Int,
        width        => %args<width> // Int,
        ephemeral    => ?%args<ephemeral>,
    )
}

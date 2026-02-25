use v6.d;
use Dusk::Util::JSONTraits;

unit class Dusk::Model::Attachment;

has $.id           is required;
has $.filename     is required;
has $.description;
has $.content-type;
has $.size;
has $.url;
has $.proxy-url;
has $.height;
has $.width;
has $.ephemeral;

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

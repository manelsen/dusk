use v6.d;
use Dusk::Util::JSONTraits;

unit class Dusk::Model::Entitlement is export;

has Str $.id;
has Str $.sku-id;
has Str $.application-id;
has Str $.user-id;
has Int $.type;
has Bool $.deleted;
has Instant $.starts-at;
has Instant $.ends-at;
has Str $.guild-id;

method from-json($data) {
    my %m = jmap($data);
    self.new(
        id             => %m<id>,
        sku-id         => %m<sku-id>,
        application-id => %m<application-id>,
        user-id        => %m<user-id> // '',
        type           => %m<type>,
        deleted        => ?%m<deleted>,
        starts-at      => %m<starts-at> ?? Instant.from-rfc3339(%m<starts-at>) !! Nil,
        ends-at        => %m<ends-at> ?? Instant.from-rfc3339(%m<ends-at>) !! Nil,
        guild-id       => %m<guild-id> // '',
    )
}

use v6.d;
use Dusk::Util::JSONTraits;

unit class Dusk::Model::Component;

has $.type is required;
has $.style;
has $.label;
has %.emoji;
has $.custom-id;
has $.url;
has $.disabled;
has Dusk::Model::Component @.components;

method new(*%args) {
    my Dusk::Model::Component @components = (%args<components> // []).map({ Dusk::Model::Component.new(|$_) });

    self.bless(
        type       => (%args<type> // 1).Int,
        style      => (%args<style> // 0).Int,
        label      => %args<label> // '',
        emoji      => %args<emoji> // {},
        custom-id  => %args<custom_id> // '',
        url        => %args<url> // '',
        disabled   => ?%args<disabled>,
        components => @components,
    )
}

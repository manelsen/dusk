use v6.d;

unit class Dusk::Model::Component;

has Int $.type is required;
has Int $.style;
has Str $.label;
has %.emoji;
has Str $.custom-id;
has Str $.url;
has Bool $.disabled;
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

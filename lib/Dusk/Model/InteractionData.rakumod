use v6.d;

unit class Dusk::Model::InteractionData;

has Str $.id;
has Str $.name;
has Int $.type;
has @.options;
has Str $.custom-id;
has Int $.component-type;
has @.values;
has Str $.target-id;
has %.resolved;

method new(*%args) {
    self.bless(
        id             => %args<id> // Str,
        name           => %args<name> // '',
        type           => (%args<type> // 0).Int,
        options        => @(%args<options> // []),
        custom-id      => %args<custom_id> // '',
        component-type => (%args<component_type> // 0).Int,
        values         => @(%args<values> // []),
        target-id      => %args<target_id> // '',
        resolved       => %args<resolved> // {},
    )
}

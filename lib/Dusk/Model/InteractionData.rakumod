use Dusk::Util::JSONTraits;

unit class Dusk::Model::InteractionData;

has Str  $.id             = '';
has Str  $.name           = '';
has Int  $.type           = 0;
has      @.options;
has Str  $.custom-id      = '';
has Int  $.component-type = 0;
has      @.values;
has Str  $.target-id      = '';
has      %.resolved;

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

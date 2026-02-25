use Dusk::Util::JSONTraits;

unit class Dusk::Model::StageInstance;

has Str  $.id                       = '';
has Str  $.guild-id                 = '';
has Str  $.channel-id               = '';
has Str  $.topic                    = '';
has Int  $.privacy-level            = 1;
has Bool $.discoverable-disabled    = False;
has Str  $.guild-scheduled-event-id = '';

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

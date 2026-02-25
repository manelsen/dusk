use Dusk::Util::JSONTraits;

unit class Dusk::Model::Sticker;

has Str  $.id          = '';
has Str  $.name        = '';
has Str  $.description = '';
has Str  $.tags        = '';
has Int  $.type        = 1;
has Int  $.format-type = 1;
has Bool $.available  = True;
has Str  $.guild-id    = '';

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

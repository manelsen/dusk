use Dusk::Util::JSONTraits;

unit class Dusk::Model::Emoji;

has Str  $.id        = '';
has Str  $.name      = '';
has Bool $.animated  = False;
has Bool $.managed   = False;
has Bool $.available = False;

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

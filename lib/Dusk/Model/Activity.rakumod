use Dusk::Util::JSONTraits;

unit class Dusk::Model::Activity;

has Str  $.name           = '';
has Int  $.type           = 0;
has Str  $.url            = '';
has Str  $.created-at     = '';
has      %.timestamps;
has Str  $.application-id = '';
has Str  $.details        = '';
has Str  $.state          = '';
has      %.emoji;
has      %.party;
has      %.assets;
has      %.secrets;
has Bool $.instance      = False;
has Int  $.flags          = 0;
has      @.buttons;

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

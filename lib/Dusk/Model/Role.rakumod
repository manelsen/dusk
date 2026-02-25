use Dusk::Util::JSONTraits;

unit class Dusk::Model::Role;

has Str  $.id           = '';
has Str  $.name         = '';
has Int  $.color        = 0;
has Bool $.hoist       = False;
has Str  $.icon         = '';
has Str  $.unicode-emoji = '';
has Int  $.position     = 0;
has Str  $.permissions  = '0';
has Bool $.managed     = False;
has Bool $.mentionable = False;

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

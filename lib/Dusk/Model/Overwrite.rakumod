use Dusk::Util::JSONTraits;

unit class Dusk::Model::Overwrite;

has Str  $.id    = '';
has Int  $.type  = 0;
has Str  $.allow = '0';
has Str  $.deny  = '0';

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

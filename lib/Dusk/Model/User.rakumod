use v6.d;
use Dusk::Util::JSONTraits;

unit class Dusk::Model::User is export is export;

has Str  $.id            = '';
has Str  $.username      = '';
has Str  $.discriminator = '';
has      $.avatar;
has Bool $.bot           = False;
has Bool $.system        = False;

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

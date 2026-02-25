use v6.d;
use Dusk::Util::JSONTraits;

unit class Dusk::Model::User;

has Str  $.id            = '';
has Str  $.username      = '';
has Str  $.discriminator = '';
has Str  $.avatar        = '';
has Bool $.bot           = False;
has Bool $.system        = False;

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

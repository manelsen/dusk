use Dusk::Util::JSONTraits;
unit class Dusk::Model::Guild;

has $.id                 = '';
has $.name               = '';
has $.owner-id           = '';
has $.verification-level = 0;

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

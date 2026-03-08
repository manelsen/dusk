use Dusk::Util::JSONTraits;

unit class Dusk::Model::Team is export;

has Str  $.id            = '';
has Str  $.icon          = '';
has Str  $.name          = '';
has Str  $.owner-user-id = '';
has      @.members;

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

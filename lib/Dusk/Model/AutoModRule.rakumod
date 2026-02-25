use Dusk::Util::JSONTraits;

unit class Dusk::Model::AutoModRule;

has Str  $.id           = '';
has Str  $.guild-id     = '';
has Str  $.name         = '';
has Str  $.creator-id   = '';
has Int  $.event-type   = 0;
has Int  $.trigger-type = 0;
has      %.trigger-metadata;
has      @.actions;
has Bool $.enabled     = False;
has      @.exempt-roles;
has      @.exempt-channels;

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

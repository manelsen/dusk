use Dusk::Util::JSONTraits;

unit class Dusk::Model::ScheduledEvent;

has Str  $.id                   = '';
has Str  $.guild-id             = '';
has Str  $.channel-id           = '';
has Str  $.creator-id           = '';
has Str  $.name                 = '';
has Str  $.description          = '';
has Str  $.scheduled-start-time = '';
has Str  $.scheduled-end-time   = '';
has Int  $.privacy-level        = 2;
has Int  $.status               = 1;
has Int  $.entity-type          = 1;
has Str  $.entity-id            = '';
has      %.entity-metadata;
has      $.creator; # Dusk::Model::User
has Int  $.user-count           = 0;
has Str  $.image                = '';

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

submethod TWEAK(:$creator) {
    if $creator && $creator ~~ Hash {
        require Dusk::Model::User;
        $!creator = ::('Dusk::Model::User').from-json($creator);
    }
}

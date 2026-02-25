use Dusk::Util::JSONTraits;

unit class Dusk::Model::VoiceState;

has Str  $.guild-id                   = '';
has Str  $.channel-id                 = '';
has Str  $.user-id                   = '';
has      $.member; # Dusk::Model::Member
has Str  $.session-id                 = '';
has Bool $.deaf                      = False;
has Bool $.mute                      = False;
has Bool $.self-deaf                 = False;
has Bool $.self-mute                 = False;
has Bool $.self-stream               = False;
has Bool $.self-video                = False;
has Bool $.suppress                  = False;
has Str  $.request-to-speak-timestamp = '';

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

submethod TWEAK(:$member) {
    if $member && $member ~~ Hash {
        require Dusk::Model::Member;
        $!member = ::('Dusk::Model::Member').from-json($member);
    }
}

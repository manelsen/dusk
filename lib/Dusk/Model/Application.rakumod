use Dusk::Util::JSONTraits;

unit class Dusk::Model::Application;

has Str $.id                     = '';
has Str $.name                   = '';
has Str $.icon                   = '';
has Str $.description            = '';
has Str @.rpc-origins;
has Bool $.bot-public            = False;
has Bool $.bot-require-code-grant = False;
has Str $.terms-of-service-url   = '';
has Str $.privacy-policy-url     = '';
has $.owner; # Dusk::Model::User
has Str $.summary                = '';
has Str $.verify-key             = '';
has $.team; # Dusk::Model::Team
has Str $.guild-id               = '';
has Str $.primary-guild-id       = '';
has Str $.slug                   = '';
has Str $.cover-image            = '';
has Int $.flags                  = 0;

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

submethod TWEAK(:$owner, :$team) {
    if $owner && $owner ~~ Hash {
        require Dusk::Model::User;
        $!owner = ::('Dusk::Model::User').from-json($owner);
    }
    if $team && $team ~~ Hash {
        require Dusk::Model::Team;
        $!team  = ::('Dusk::Model::Team').from-json($team);
    }
}

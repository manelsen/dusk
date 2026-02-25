use Dusk::Util::JSONTraits;

unit class Dusk::Model::Webhook;

has Str  $.id             = '';
has Int  $.type           = 1;
has Str  $.guild-id       = '';
has Str  $.channel-id     = '';
has      $.user; # Dusk::Model::User
has Str  $.name           = '';
has Str  $.avatar         = '';
has Str  $.token          = '';
has Str  $.application-id = '';
has      %.source-guild;
has      %.source-channel;
has Str  $.url            = '';

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

submethod TWEAK(:$user) {
    if $user && $user ~~ Hash {
        require Dusk::Model::User;
        $!user = ::('Dusk::Model::User').from-json($user);
    }
}

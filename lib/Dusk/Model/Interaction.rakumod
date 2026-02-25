use Dusk::Util::JSONTraits;

unit class Dusk::Model::Interaction;

has Str $.id             = '';
has Str $.application-id = '';
has Int $.type           = 0;
has $.data; # Dusk::Model::InteractionData
has Str $.guild-id       = '';
has Str $.channel-id     = '';
has $.member; # Dusk::Model::Member
has $.user;   # Dusk::Model::User
has Str $.token          = '';
has Int $.version        = 1;
has $.message; # Dusk::Model::Message
has Str $.app-permissions = '';
has Str $.locale          = '';
has Str $.guild-locale    = '';

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

submethod TWEAK(:$data, :$member, :$user, :$message) {
    if $data && $data ~~ Hash {
        require Dusk::Model::InteractionData;
        $!data = ::('Dusk::Model::InteractionData').from-json($data);
    }
    if $member && $member ~~ Hash {
        require Dusk::Model::Member;
        $!member = ::('Dusk::Model::Member').from-json($member);
    }
    if $user && $user ~~ Hash {
        require Dusk::Model::User;
        $!user = ::('Dusk::Model::User').from-json($user);
    }
    if $message && $message ~~ Hash {
        require Dusk::Model::Message;
        $!message = ::('Dusk::Model::Message').from-json($message);
    }
    
    if !$!user.defined && $!member.defined {
        $!user = $!member.user;
    }
}

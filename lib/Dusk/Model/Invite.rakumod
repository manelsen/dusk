use Dusk::Util::JSONTraits;

unit class Dusk::Model::Invite;

has Str $.code                       = '';
has     $.guild;   # Dusk::Model::Guild
has     $.channel; # Dusk::Model::Channel
has     $.inviter; # Dusk::Model::User
has Int $.target-type                = 0;
has     $.target-user; # Dusk::Model::User
has     %.target-application;
has Int $.approximate-presence-count = 0;
has Int $.approximate-member-count   = 0;
has Str $.expires-at                 = '';
has Int $.uses                       = 0;
has Int $.max-uses                   = 0;
has Int $.max-age                    = 0;
has Bool $.temporary                 = False;
has Str $.created-at                 = '';

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

submethod TWEAK(:$guild, :$channel, :$inviter, :$target-user) {
    if $guild && $guild ~~ Hash {
        require Dusk::Model::Guild;
        $!guild = ::('Dusk::Model::Guild').from-json($guild);
    }
    if $channel && $channel ~~ Hash {
        require Dusk::Model::Channel;
        $!channel = ::('Dusk::Model::Channel').from-json($channel);
    }
    if $inviter && $inviter ~~ Hash {
        require Dusk::Model::User;
        $!inviter = ::('Dusk::Model::User').from-json($inviter);
    }
    if $target-user && $target-user ~~ Hash {
        require Dusk::Model::User;
        $!target-user = ::('Dusk::Model::User').from-json($target-user);
    }
}

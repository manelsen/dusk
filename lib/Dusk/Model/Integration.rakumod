use Dusk::Util::JSONTraits;

unit class Dusk::Model::Integration;

has Str $.id                = '';
has Str $.name              = '';
has Str $.type              = '';
has Bool $.enabled          = False;
has Bool $.syncing          = False;
has Str $.role-id           = '';
has Bool $.enable-emoticons = False;
has Int $.expire-behavior   = 0;
has Int $.expire-grace-period = 0;
has $.user; # Dusk::Model::User
has %.account;
has Str $.synced-at         = '';
has Int $.subscriber-count  = 0;
has Bool $.revoked          = False;
has %.application;
has @.scopes;

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

submethod TWEAK(:$user) {
    if $user && $user ~~ Hash {
        require Dusk::Model::User;
        $!user = ::('Dusk::Model::User').from-json($user);
    }
}

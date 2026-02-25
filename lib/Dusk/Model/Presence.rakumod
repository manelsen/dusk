use Dusk::Util::JSONTraits;

unit class Dusk::Model::Presence;

has      $.user; # Dusk::Model::User
has Str  $.guild-id = '';
has Str  $.status   = 'offline';
has      @.activities; # Dusk::Model::Activity
has      %.client-status;

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

submethod TWEAK(:$user, :$activities) {
    if $user && $user ~~ Hash {
        require Dusk::Model::User;
        $!user = ::('Dusk::Model::User').from-json($user);
    }
    
    if $activities && $activities ~~ Positional {
        require Dusk::Model::Activity;
        @!activities = $activities.map({ 
            $_ ~~ Dusk::Model::Activity ?? $_ !! ::('Dusk::Model::Activity').from-json($_) 
        });
    }
}

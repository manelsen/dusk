use Dusk::Util::JSONTraits;

unit class Dusk::Model::Channel;

has Str $.id                  = '';
has Str $.name                = '';
has Int $.type                = 0;
has Str $.guild-id            = '';
has Int $.position            = 0;
has Str $.topic               = '';
has Bool $.nsfw               = False;
has Str $.last-message-id     = '';
has Int $.bitrate             = 0;
has Int $.user-limit          = 0;
has Int $.rate-limit-per-user = 0;
has Str $.parent-id           = '';
has Str $.rtc-region          = '';
has Int $.video-quality-mode  = 1;
has @.permission-overwrites;

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

submethod TWEAK(:$permission-overwrites) {
    if $permission-overwrites && $permission-overwrites ~~ Positional {
        require Dusk::Model::Overwrite;
        @!permission-overwrites = $permission-overwrites.map({ 
            $_ ~~ Dusk::Model::Overwrite ?? $_ !! ::('Dusk::Model::Overwrite').from-json($_) 
        });
    }
}

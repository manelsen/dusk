use Dusk::Util::JSONTraits;

unit class Dusk::Model::Message;

has Str $.id               = '';
has Str $.channel-id       = '';
has Str $.content          = '';
has     $.author; # Dusk::Model::User
has     @.embeds;
has     @.components;
has     @.attachments;
has Bool $.tts             = False;
has Bool $.mention-everyone = False;
has Str $.timestamp        = '';
has Str $.edited-timestamp = '';
has Int $.type             = 0;
has Int $.flags            = 0;

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

submethod TWEAK(:$author, :$embeds, :$components, :$attachments) {
    if $author && $author ~~ Hash {
        require Dusk::Model::User;
        $!author = ::('Dusk::Model::User').from-json($author);
    }
    
    if $embeds && $embeds ~~ Positional {
        require Dusk::Model::Embed;
        @!embeds = $embeds.map({ $_ ~~ Dusk::Model::Embed ?? $_ !! ::('Dusk::Model::Embed').from-json($_) });
    }
    if $components && $components ~~ Positional {
        require Dusk::Model::Component;
        @!components = $components.map({ $_ ~~ Dusk::Model::Component ?? $_ !! ::('Dusk::Model::Component').from-json($_) });
    }
    if $attachments && $attachments ~~ Positional {
        require Dusk::Model::Attachment;
        @!attachments = $attachments.map({ $_ ~~ Dusk::Model::Attachment ?? $_ !! ::('Dusk::Model::Attachment').from-json($_) });
    }
}

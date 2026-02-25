use v6.d;
use Dusk::Model::User;
use Dusk::Model::Embed;
use Dusk::Model::Component;
use Dusk::Model::Attachment;

unit class Dusk::Model::Message;

has Str $.id           is required;
has Str $.channel-id   is required;
has Str $.content      is required;
has Dusk::Model::User $.author;
has Dusk::Model::Embed @.embeds;
has Dusk::Model::Component @.components;
has Dusk::Model::Attachment @.attachments;
has Bool $.tts;
has Bool $.mention-everyone;
has Str $.timestamp;
has Str $.edited-timestamp;
has Int $.type;
has Int $.flags;

method new(*%args) {
    my $author = %args<author> ?? Dusk::Model::User.new(|%args<author>) !! Dusk::Model::User;
    my Dusk::Model::Embed @embeds = (%args<embeds> // []).map({ Dusk::Model::Embed.new(|$_) });
    my Dusk::Model::Component @components = (%args<components> // []).map({ Dusk::Model::Component.new(|$_) });
    my Dusk::Model::Attachment @attachments = (%args<attachments> // []).map({ Dusk::Model::Attachment.new(|$_) });

    self.bless(
        id               => ~(%args<id> // ''),
        channel-id       => ~(%args<channel_id> // ''),
        content          => ~(%args<content> // ''),
        author           => $author,
        embeds           => @embeds,
        components       => @components,
        attachments      => @attachments,
        tts              => ?%args<tts>,
        mention-everyone => ?%args<mention_everyone>,
        timestamp        => ~(%args<timestamp> // ''),
        edited-timestamp => ~(%args<edited_timestamp> // ''),
        type             => (%args<type> // 0).Int,
        flags            => (%args<flags> // 0).Int,
    )
}

use v6.d;
use Dusk::Model::User;

unit class Dusk::Model::ScheduledEvent;

has Str $.id           is required;
has Str $.guild-id     is required;
has Str $.channel-id;
has Str $.creator-id;
has Str $.name         is required;
has Str $.description;
has Str $.scheduled-start-time is required;
has Str $.scheduled-end-time;
has Int $.privacy-level;
has Int $.status;
has Int $.entity-type;
has Str $.entity-id;
has %.entity-metadata;
has Dusk::Model::User $.creator;
has Int $.user-count;
has Str $.image;

method new(*%args) {
    my $creator = %args<creator> ?? Dusk::Model::User.new(|%args<creator>) !! Dusk::Model::User;

    self.bless(
        id                   => ~(%args<id> // ''),
        guild-id             => ~(%args<guild_id> // ''),
        channel-id           => %args<channel_id> // '',
        creator-id           => %args<creator_id> // '',
        name                 => ~(%args<name> // ''),
        description          => %args<description> // '',
        scheduled-start-time => ~(%args<scheduled_start_time> // ''),
        scheduled-end-time   => %args<scheduled_end_time> // '',
        privacy-level        => (%args<privacy_level> // 2).Int,
        status               => (%args<status> // 1).Int,
        entity-type          => (%args<entity_type> // 1).Int,
        entity-id            => %args<entity_id> // '',
        entity-metadata      => %args<entity_metadata> // {},
        creator              => $creator,
        user-count           => (%args<user_count> // 0).Int,
        image                => %args<image> // '',
    )
}

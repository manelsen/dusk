=begin pod
=head1 Dusk::Model::Channel

Represents a Discord channel (text, voice, category, etc).

=head2 Attributes

=item C<Str $.id> — Snowflake ID (required)
=item C<Str $.name> — Channel name (required)
=item C<Int $.type> — Channel type: 0=GUILD_TEXT, 2=GUILD_VOICE, etc (required)
=item C<Str $.guild-id> — Parent guild ID (optional, absent for DMs)

=end pod

use Dusk::Model::Overwrite;

unit class Dusk::Model::Channel;

has Str $.id           is required;
has Str $.name;
has Int $.type         is required;
has Str $.guild-id;
has Int $.position;
has Str $.topic;
has Bool $.nsfw;
has Str $.last-message-id;
has Int $.bitrate;
has Int $.user-limit;
has Int $.rate-limit-per-user;
has Str $.parent-id;
has Str $.rtc-region;
has Int $.video-quality-mode;
has Dusk::Model::Overwrite @.permission-overwrites;

method new(*%args) {
    my Dusk::Model::Overwrite @overwrites = (%args<permission_overwrites> // []).map({ Dusk::Model::Overwrite.new(|$_) });

    self.bless(
        id                  => ~(%args<id> // ''),
        name                => %args<name> // '',
        type                => (%args<type> // 0).Int,
        guild-id            => %args<guild_id> // '',
        position            => (%args<position> // 0).Int,
        topic               => %args<topic> // '',
        nsfw                => ?%args<nsfw>,
        last-message-id     => %args<last_message_id> // '',
        bitrate             => (%args<bitrate> // 0).Int,
        user-limit          => (%args<user_limit> // 0).Int,
        rate-limit-per-user => (%args<rate_limit_per_user> // 0).Int,
        parent-id           => %args<parent_id> // '',
        rtc-region          => %args<rtc_region> // '',
        video-quality-mode  => (%args<video_quality_mode> // 1).Int,
        permission-overwrites => @overwrites,
    )
}

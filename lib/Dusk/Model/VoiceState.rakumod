use v6.d;
use Dusk::Model::Member;

unit class Dusk::Model::VoiceState;

has Str $.guild-id;
has Str $.channel-id;
has Str $.user-id      is required;
has Dusk::Model::Member $.member;
has Str $.session-id   is required;
has Bool $.deaf        is required;
has Bool $.mute        is required;
has Bool $.self-deaf   is required;
has Bool $.self-mute   is required;
has Bool $.self-stream;
has Bool $.self-video  is required;
has Bool $.suppress    is required;
has Str $.request-to-speak-timestamp;

method new(*%args) {
    my $member = %args<member> ?? Dusk::Model::Member.new(|%args<member>) !! Dusk::Model::Member;

    self.bless(
        guild-id                   => %args<guild_id> // '',
        channel-id                 => %args<channel_id> // '',
        user-id                    => ~(%args<user_id> // ''),
        member                     => $member,
        session-id                 => ~(%args<session_id> // ''),
        deaf                       => ?%args<deaf>,
        mute                       => ?%args<mute>,
        self-deaf                  => ?%args<self_deaf>,
        self-mute                  => ?%args<self_mute>,
        self-stream                => ?%args<self_stream>,
        self-video                 => ?%args<self_video>,
        suppress                   => ?%args<suppress>,
        request-to-speak-timestamp => %args<request_to_speak_timestamp> // '',
    )
}

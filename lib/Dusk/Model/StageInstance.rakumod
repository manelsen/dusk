use v6.d;

unit class Dusk::Model::StageInstance;

has Str $.id                   is required;
has Str $.guild-id             is required;
has Str $.channel-id           is required;
has Str $.topic                is required;
has Int $.privacy-level        is required;
has Bool $.discoverable-disabled;
has Str $.guild-scheduled-event-id;

method new(*%args) {
    self.bless(
        id                       => ~(%args<id> // ''),
        guild-id                 => ~(%args<guild_id> // ''),
        channel-id               => ~(%args<channel_id> // ''),
        topic                    => ~(%args<topic> // ''),
        privacy-level            => (%args<privacy_level> // 1).Int,
        discoverable-disabled    => ?%args<discoverable_disabled>,
        guild-scheduled-event-id => %args<guild_scheduled_event_id> // '',
    )
}

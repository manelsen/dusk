use v6.d;

unit class Dusk::Model::AutoModRule;

has Str $.id           is required;
has Str $.guild-id     is required;
has Str $.name         is required;
has Str $.creator-id   is required;
has Int $.event-type   is required;
has Int $.trigger-type is required;
has %.trigger-metadata;
has @.actions;
has Bool $.enabled;
has @.exempt-roles;
has @.exempt-channels;

method new(*%args) {
    self.bless(
        id               => ~(%args<id> // ''),
        guild-id         => ~(%args<guild_id> // ''),
        name             => ~(%args<name> // ''),
        creator-id       => ~(%args<creator_id> // ''),
        event-type       => (%args<event_type> // 1).Int,
        trigger-type     => (%args<trigger_type> // 1).Int,
        trigger-metadata => %args<trigger_metadata> // {},
        actions          => @(%args<actions> // []),
        enabled          => ?%args<enabled>,
        exempt-roles     => @(%args<exempt_roles> // []),
        exempt-channels  => @(%args<exempt_channels> // []),
    )
}

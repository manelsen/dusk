unit class Dusk::Model::Channel;

has $.id      is required;
has $.name    is required;
has $.type is required;
has $.guild-id;

method new(*%args) {
    self.bless(
        id       => %args<id>,
        name     => %args<name>,
        type     => %args<type>,
        guild-id => %args<guild_id>,
    )
}

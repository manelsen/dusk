unit class Dusk::Model::Guild;

has $.id      is required;
has $.name    is required;
has $.owner-id;
has $.verification-level;

method new(*%args) {
    self.bless(
        id                 => %args<id>,
        name               => %args<name>,
        owner-id           => %args<owner_id>,
        verification-level => %args<verification_level>,
    )
}

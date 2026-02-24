unit class Dusk::Model::User;

has $.id      is required;
has $.username;
has $.discriminator;
has $.avatar;
has $.bot    = False;
has $.system = False;

method new(*%args) {
    self.bless(
        id            => %args<id>,
        username      => %args<username>,
        discriminator => %args<discriminator>,
        avatar        => %args<avatar>,
        bot           => %args<bot> // False,
        system        => %args<system> // False,
    )
}

=begin pod
=head1 Dusk::Model::User

Represents a Discord user (bot or human).

=head2 Attributes

=item C<Str $.id> — Snowflake ID (required)
=item C<Str $.username> — Display name
=item C<Str $.discriminator> — Legacy 4-digit discriminator
=item C<Str $.avatar> — Avatar hash
=item C<Bool $.bot> — Whether this user is a bot
=item C<Bool $.system> — Whether this is a system user

=end pod

unit class Dusk::Model::User;

has Str  $.id      is required;
has Str  $.username = '';
has Str  $.discriminator = '';
has Str  $.avatar = '';
has Bool $.bot    = False;
has Bool $.system = False;

method new(*%args) {
    self.bless(
        id            => ~(%args<id> // ''),
        username      => ~(%args<username> // ''),
        discriminator => ~(%args<discriminator> // ''),
        avatar        => ~(%args<avatar> // ''),
        bot           => ?(%args<bot> // False),
        system        => ?(%args<system> // False),
    )
}

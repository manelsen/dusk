=begin pod
=head1 Dusk::Model::Guild

Represents a Discord guild (server).

=head2 Attributes

=item C<Str $.id> — Snowflake ID (required)
=item C<Str $.name> — Guild name (required)
=item C<Str $.owner-id> — Owner's user ID
=item C<Int $.verification-level> — 0=NONE, 1=LOW, 2=MEDIUM, 3=HIGH, 4=VERY_HIGH

=end pod

unit class Dusk::Model::Guild;

has Str $.id      is required;
has Str $.name    is required;
has Str $.owner-id = '';
has Int $.verification-level = 0;

method new(*%args) {
    self.bless(
        id                 => ~(%args<id> // ''),
        name               => ~(%args<name> // ''),
        owner-id           => ~(%args<owner_id> // ''),
        verification-level => +(%args<verification_level> // 0),
    )
}

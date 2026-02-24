=begin pod
=head1 Dusk::Model::Channel

Represents a Discord channel (text, voice, category, etc).

=head2 Attributes

=item C<Str $.id> — Snowflake ID (required)
=item C<Str $.name> — Channel name (required)
=item C<Int $.type> — Channel type: 0=GUILD_TEXT, 2=GUILD_VOICE, etc (required)
=item C<Str $.guild-id> — Parent guild ID (optional, absent for DMs)

=end pod

unit class Dusk::Model::Channel;

has Str $.id      is required;
has Str $.name    is required;
has Int $.type    is required;
has Str $.guild-id = '';

method new(*%args) {
    self.bless(
        id       => ~(%args<id> // ''),
        name     => ~(%args<name> // ''),
        type     => +(%args<type> // 0),
        guild-id => ~(%args<guild_id> // ''),
    )
}

=begin pod
=head1 Dusk::Model::Message

Represents a Discord message with nested author.

=head2 Attributes

=item C<Str $.id> — Snowflake ID (required)
=item C<Str $.channel-id> — Channel where message was sent (required)
=item C<Str $.content> — Text content (required)
=item C<Dusk::Model::User $.author> — Message author

=end pod

use Dusk::Model::User;

unit class Dusk::Model::Message;

#| O ID único (Snowflake) da mensagem.
has Str $.id         is required;
#| O ID do canal onde a mensagem foi enviada.
has Str $.channel-id is required;
#| O texto principal da mensagem.
has Str $.content    is required;
#| O objeto representando o autor da mensagem.
has Dusk::Model::User $.author;

method new(*%args) {
    my $author = Dusk::Model::User;
    if %args<author> {
        $author = Dusk::Model::User.new(
            id            => %args<author><id>,
            username      => %args<author><username>,
            discriminator => %args<author><discriminator>
        );
    }

    self.bless(
        id         => ~(%args<id> // ''),
        channel-id => ~(%args<channel_id> // ''),
        content    => ~(%args<content> // ''),
        author     => $author,
    )
}

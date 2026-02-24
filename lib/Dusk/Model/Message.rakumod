use Dusk::Model::User;

unit class Dusk::Model::Message;

has $.id         is required;
has $.channel-id is required;
has $.content    is required;
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
        id         => %args<id>,
        channel-id => %args<channel_id> // '',
        content    => %args<content> // '',
        author     => $author,
    )
}

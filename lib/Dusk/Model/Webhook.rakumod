use v6.d;
use Dusk::Model::User;

unit class Dusk::Model::Webhook;

has Str $.id           is required;
has Int $.type         is required;
has Str $.guild-id;
has Str $.channel-id;
has Dusk::Model::User $.user;
has Str $.name;
has Str $.avatar;
has Str $.token;
has Str $.application-id;
has %.source-guild;
has %.source-channel;
has Str $.url;

method new(*%args) {
    my $user = %args<user> ?? Dusk::Model::User.new(|%args<user>) !! Dusk::Model::User;

    self.bless(
        id             => ~(%args<id> // ''),
        type           => (%args<type> // 1).Int,
        guild-id       => %args<guild_id> // '',
        channel-id     => %args<channel_id> // '',
        user           => $user,
        name           => %args<name> // '',
        avatar         => %args<avatar> // '',
        token          => %args<token> // '',
        application-id => %args<application_id> // '',
        source-guild   => %args<source_guild> // {},
        source-channel => %args<source_channel> // {},
        url            => %args<url> // '',
    )
}

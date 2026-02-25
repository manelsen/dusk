use v6.d;
use Dusk::Model::User;
use Dusk::Model::Member;
use Dusk::Model::Message;
use Dusk::Model::InteractionData;

unit class Dusk::Model::Interaction;

has Str $.id           is required;
has Str $.application-id is required;
has Int $.type         is required;
has Dusk::Model::InteractionData $.data;
has Str $.guild-id;
has Str $.channel-id;
has Dusk::Model::Member $.member;
has Dusk::Model::User   $.user;
has Str $.token        is required;
has Int $.version      is required;
has Dusk::Model::Message $.message;
has Str $.app-permissions;
has Str $.locale;
has Str $.guild-locale;

method new(*%args) {
    my $data    = %args<data> ?? Dusk::Model::InteractionData.new(|%args<data>) !! Dusk::Model::InteractionData;
    my $member  = %args<member> ?? Dusk::Model::Member.new(|%args<member>) !! Dusk::Model::Member;
    my $user    = %args<user>   ?? Dusk::Model::User.new(|%args<user>)     !! ($member ?? $member.user !! Dusk::Model::User);
    my $message = %args<message> ?? Dusk::Model::Message.new(|%args<message>) !! Dusk::Model::Message;

    self.bless(
        id              => ~(%args<id> // ''),
        application-id  => ~(%args<application_id> // ''),
        type            => (%args<type> // 0).Int,
        data            => $data,
        guild-id        => %args<guild_id> // '',
        channel-id      => %args<channel_id> // '',
        member          => $member,
        user            => $user,
        token           => ~(%args<token> // ''),
        version         => (%args<version> // 1).Int,
        message         => $message,
        app-permissions => %args<app_permissions> // '',
        locale          => %args<locale> // '',
        guild-locale    => %args<guild_locale> // '',
    )
}

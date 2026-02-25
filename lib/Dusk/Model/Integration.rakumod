use v6.d;
use Dusk::Model::User;

unit class Dusk::Model::Integration;

has Str $.id   is required;
has Str $.name is required;
has Str $.type is required;
has Bool $.enabled;
has Bool $.syncing;
has Str $.role-id;
has Bool $.enable-emoticons;
has Int $.expire-behavior;
has Int $.expire-grace-period;
has Dusk::Model::User $.user;
has %.account;
has Str $.synced-at;
has Int $.subscriber-count;
has Bool $.revoked;
has %.application;
has @.scopes;

method new(*%args) {
    my $user = %args<user> ?? Dusk::Model::User.new(|%args<user>) !! Dusk::Model::User;

    self.bless(
        id                  => ~(%args<id> // ''),
        name                => ~(%args<name> // ''),
        type                => ~(%args<type> // ''),
        enabled             => ?%args<enabled>,
        syncing             => ?%args<syncing>,
        role-id             => %args<role_id> // '',
        enable-emoticons    => ?%args<enable_emoticons>,
        expire-behavior     => (%args<expire_behavior> // 0).Int,
        expire-grace-period => (%args<expire_grace_period> // 0).Int,
        user                => $user,
        account             => %args<account> // {},
        synced-at           => %args<synced_at> // '',
        subscriber-count    => (%args<subscriber_count> // 0).Int,
        revoked             => ?%args<revoked>,
        application         => %args<application> // {},
        scopes              => @(%args<scopes> // []),
    )
}

use v6.d;
use Dusk::Model::User;
use Dusk::Model::Team;

unit class Dusk::Model::Application;

has Str $.id   is required;
has Str $.name is required;
has Str $.icon;
has Str $.description;
has Str @.rpc-origins;
has Bool $.bot-public;
has Bool $.bot-require-code-grant;
has Str $.terms-of-service-url;
has Str $.privacy-policy-url;
has Dusk::Model::User $.owner;
has Str $.summary;
has Str $.verify-key;
has Dusk::Model::Team $.team;
has Str $.guild-id;
has Str $.primary-guild-id;
has Str $.slug;
has Str $.cover-image;
has Int $.flags;

method new(*%args) {
    my $owner = %args<owner> ?? Dusk::Model::User.new(|%args<owner>) !! Dusk::Model::User;
    my $team  = %args<team>  ?? Dusk::Model::Team.new(|%args<team>)   !! Dusk::Model::Team;

    self.bless(
        id                     => ~(%args<id> // ''),
        name                   => ~(%args<name> // ''),
        icon                   => %args<icon> // '',
        description            => %args<description> // '',
        rpc-origins            => @(%args<rpc_origins> // []),
        bot-public             => ?%args<bot_public>,
        bot-require-code-grant => ?%args<bot_require_code_grant>,
        terms-of-service-url   => %args<terms_of_service_url> // '',
        privacy-policy-url     => %args<privacy_policy_url> // '',
        owner                  => $owner,
        summary                => %args<summary> // '',
        verify-key             => %args<verify_key> // '',
        team                   => $team,
        guild-id               => %args<guild_id> // '',
        primary-guild-id       => %args<primary_guild_id> // '',
        slug                   => %args<slug> // '',
        cover-image            => %args<cover_image> // '',
        flags                  => (%args<flags> // 0).Int,
    )
}

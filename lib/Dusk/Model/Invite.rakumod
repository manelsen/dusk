use v6.d;
use Dusk::Model::User;
use Dusk::Model::Guild;
use Dusk::Model::Channel;

unit class Dusk::Model::Invite;

has Str $.code         is required;
has Dusk::Model::Guild $.guild;
has Dusk::Model::Channel $.channel;
has Dusk::Model::User $.inviter;
has Int $.target-type;
has Dusk::Model::User $.target-user;
has %.target-application;
has Int $.approximate-presence-count;
has Int $.approximate-member-count;
has Str $.expires-at;
has Int $.uses;
has Int $.max-uses;
has Int $.max-age;
has Bool $.temporary;
has Str $.created-at;

method new(*%args) {
    my $guild   = %args<guild> ?? Dusk::Model::Guild.new(|%args<guild>) !! Dusk::Model::Guild;
    my $channel = %args<channel> ?? Dusk::Model::Channel.new(|%args<channel>) !! Dusk::Model::Channel;
    my $inviter = %args<inviter> ?? Dusk::Model::User.new(|%args<inviter>) !! Dusk::Model::User;
    my $t-user  = %args<target_user> ?? Dusk::Model::User.new(|%args<target_user>) !! Dusk::Model::User;

    self.bless(
        code                       => ~(%args<code> // ''),
        guild                      => $guild,
        channel                    => $channel,
        inviter                    => $inviter,
        target-type                => (%args<target_type> // 0).Int,
        target-user                => $t-user,
        target-application         => %args<target_application> // {},
        approximate-presence-count => (%args<approximate_presence_count> // 0).Int,
        approximate-member-count   => (%args<approximate_member_count> // 0).Int,
        expires-at                 => %args<expires_at> // '',
        uses                       => (%args<uses> // 0).Int,
        max-uses                   => (%args<max_uses> // 0).Int,
        max-age                    => (%args<max_age> // 0).Int,
        temporary                  => ?%args<temporary>,
        created-at                 => %args<created_at> // '',
    )
}

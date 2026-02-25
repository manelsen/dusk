use v6.d;
use Dusk::Model::User;

unit class Dusk::Model::Member;

has Dusk::Model::User $.user;
has Str $.nick;
has Str $.avatar;
has Str @.roles;
has Str $.joined-at;
has Str $.premium-since;
has Bool $.deaf;
has Bool $.mute;
has Int $.flags;
has Bool $.pending;
has Str $.permissions;
has Str $.communication-disabled-until;

method new(*%args) {
    my $user = %args<user> ?? Dusk::Model::User.new(|%args<user>) !! Dusk::Model::User;
    
    self.bless(
        user                         => $user,
        nick                         => %args<nick> // '',
        avatar                       => %args<avatar> // '',
        roles                        => @(%args<roles> // []),
        joined-at                    => ~(%args<joined_at> // ''),
        premium-since                => ~(%args<premium_since> // ''),
        deaf                         => ?%args<deaf>,
        mute                         => ?%args<mute>,
        flags                        => (%args<flags> // 0).Int,
        pending                      => ?%args<pending>,
        permissions                  => ~(%args<permissions> // ''),
        communication-disabled-until => ~(%args<communication_disabled_until> // ''),
    )
}

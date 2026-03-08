use v6.d;

unit class Dusk::Model::PartialMember is export is export;

has $.user;
has Str $.nick;
has Str $.avatar;
has Positional $.roles;
has Str $.joined-at;
has Str $.premium-since;
has Bool $.deaf;
has Bool $.mute;
has Str $.flags;
has Str $.permissions;
has Str $.communication-disabled-until;

method new(*%args) {
    self.bless(|%args);
}

use v6.d;
use Dusk::Model::User;
use Dusk::Model::Activity;

unit class Dusk::Model::Presence;

has Dusk::Model::User $.user;
has Str $.guild-id;
has Str $.status;
has Dusk::Model::Activity @.activities;
has %.client-status;

method new(*%args) {
    my $user = %args<user> ?? Dusk::Model::User.new(|%args<user>) !! Dusk::Model::User;
    my Dusk::Model::Activity @activities = (%args<activities> // []).map({ Dusk::Model::Activity.new(|$_) });

    self.bless(
        user          => $user,
        guild-id      => %args<guild_id> // '',
        status        => %args<status> // 'offline',
        activities    => @activities,
        client-status => %args<client_status> // {},
    )
}

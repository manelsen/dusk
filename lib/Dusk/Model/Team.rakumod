use v6.d;
use Dusk::Model::User;

unit class Dusk::Model::Team;

has Str $.id   is required;
has Str $.icon;
has Str $.name is required;
has Str $.owner-user-id is required;
has @.members;

method new(*%args) {
    self.bless(
        id            => ~(%args<id> // ''),
        icon          => %args<icon> // '',
        name          => ~(%args<name> // ''),
        owner-user-id => ~(%args<owner_user_id> // ''),
        members       => @(%args<members> // []),
    )
}

use v6.d;
use Dusk::Util::JSONTraits;

unit class Dusk::Model::Guild is export;

has Str $.id;
has Str $.name;
has Str $.owner-id;
has Int $.verification-level;
has Positional $.members;
has Positional $.channels;
has Positional $.roles;

method from-json($data) {
    self.new(|jmap($data))
}

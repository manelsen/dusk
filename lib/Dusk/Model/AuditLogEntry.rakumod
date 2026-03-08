use v6.d;
use Dusk::Util::JSONTraits;

unit class Dusk::Model::AuditLogEntry is export;

has Str $.id;
has Str $.target-id;
has Positional $.changes;
has Str $.user-id;
has Int $.action-type;
has Hash $.options;
has Str $.reason;

method from-json($data) {
    self.new(|jmap($data));
}

use v6.d;

unit class Dusk::Model::AuditLogChange is export is export;

has Str $.key;
has Str $.new-value;
has Str $.old-value;

method new(Str :$key!, :$new-value, :$old-value) {
    self.bless(:$key, :$new-value, :$old-value);
}

method from-json(Hash $data --> Dusk::Model::AuditLogChange) {
    self.new(
        key => $data<key> // '',
        new-value => $data<new_value> // '',
        old-value => $data<old_value> // '',
    );
}

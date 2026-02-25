use Dusk::Util::JSONTraits;

unit class Dusk::Model::AuditLog;

has @.audit-log-entries;
has @.users;
has @.webhooks;
has @.integrations;
has @.threads;
has @.application-commands;

method new(*%args) { self.bless(|%args) }

method from-json($data) { self.new(|jmap($data)) }

submethod TWEAK(:$users) {
    if $users && $users ~~ Positional {
        require Dusk::Model::User;
        @!users = $users.map({ $_ ~~ Dusk::Model::User ?? $_ !! ::('Dusk::Model::User').from-json($_) });
    }
}

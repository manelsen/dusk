use v6.d;
use Dusk::Model::User;

unit class Dusk::Model::AuditLog;

has @.audit-log-entries;
has Dusk::Model::User @.users;
has @.webhooks;
has @.integrations;
has @.threads;
has @.application-commands;

method new(*%args) {
    my Dusk::Model::User @users = (%args<users> // []).map({ Dusk::Model::User.new(|$_) });
    
    self.bless(
        audit-log-entries    => @(%args<audit_log_entries> // []),
        users                => @users,
        webhooks             => @(%args<webhooks> // []),
        integrations         => @(%args<integrations> // []),
        threads              => @(%args<threads> // []),
        application-commands => @(%args<application_commands> // []),
    )
}

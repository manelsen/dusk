=begin pod
=head1 Dusk::Gateway::Dispatcher

Routes incoming Gateway dispatch events (op:0) to typed Supply streams.
Consumers subscribe via C<.on('EVENT_NAME')> or convenience methods.

=head2 Usage

    my $dispatcher = Dusk::Gateway::Dispatcher.new(events => $event-supply);
    react {
        whenever $dispatcher.on-message-create -> $data {
            say "Message: $data<content>";
        }
        whenever $dispatcher.on-guild-create -> $data {
            say "Guild: $data<name>";
        }
    }

=end pod

use Dusk::Gateway::Payload;

unit class Dusk::Gateway::Dispatcher;

has Supply $.events is required;   # Supply of Dusk::Gateway::Payload

method on(Str $event-name --> Supply) {
    $!events.grep({ .is-dispatch && .t eq $event-name }).map({ .d });
}

# Convenience methods for common events
method on-ready(--> Supply)                  { self.on('READY') }
method on-message-create(--> Supply)         { self.on('MESSAGE_CREATE') }
method on-message-update(--> Supply)         { self.on('MESSAGE_UPDATE') }
method on-message-delete(--> Supply)         { self.on('MESSAGE_DELETE') }
method on-guild-create(--> Supply)           { self.on('GUILD_CREATE') }
method on-interaction-create(--> Supply)     { self.on('INTERACTION_CREATE') }
method on-thread-create(--> Supply)          { self.on('THREAD_CREATE') }
method on-presence-update(--> Supply)        { self.on('PRESENCE_UPDATE') }
method on-typing-start(--> Supply)           { self.on('TYPING_START') }
method on-channel-create(--> Supply)         { self.on('CHANNEL_CREATE') }
method on-channel-update(--> Supply)         { self.on('CHANNEL_UPDATE') }
method on-channel-delete(--> Supply)         { self.on('CHANNEL_DELETE') }
method on-guild-member-add(--> Supply)       { self.on('GUILD_MEMBER_ADD') }
method on-guild-member-remove(--> Supply)    { self.on('GUILD_MEMBER_REMOVE') }
method on-guild-member-update(--> Supply)    { self.on('GUILD_MEMBER_UPDATE') }

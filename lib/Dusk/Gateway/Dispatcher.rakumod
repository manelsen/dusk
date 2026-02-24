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

#| The native Supply from which the dispatcher receives raw payloads from C<Connection>.
has Supply $.events is required;   # Supply of Dusk::Gateway::Payload

#| Subscribes to a generic Gateway event ("OP_DISPATCH") and returns a filtered L<Supply> containing the payload's root hash ("d").
method on(Str $event-name --> Supply) {
    $!events.grep({ .is-dispatch && .t eq $event-name }).map({ .d });
}

use Dusk::Event::Events;

# --- Convenience Methods ---
#| Returns L<Supply> containing strongly-typed L<Dusk::Event::Events::*> representations of each event.

#| Emitted when the bot's session is successfully established.
method on-ready(--> Supply)                  { self.on('READY').map( { Dusk::Event::Events::Ready.new(raw => $_) }) }
#| Emitted when a new message is created in a channel.
method on-message-create(--> Supply)         { self.on('MESSAGE_CREATE').map( { Dusk::Event::Events::MessageCreate.new(raw => $_) }) }
method on-message-update(--> Supply)         { self.on('MESSAGE_UPDATE').map( { Dusk::Event::Events::MessageUpdate.new(raw => $_) }) }
method on-message-delete(--> Supply)         { self.on('MESSAGE_DELETE').map( { Dusk::Event::Events::MessageDelete.new(raw => $_) }) }
#| Emitted when a new Guild becomes available to the bot (bot startup or invite accepted).
method on-guild-create(--> Supply)           { self.on('GUILD_CREATE').map( { Dusk::Event::Events::GuildCreate.new(raw => $_) }) }
method on-guild-delete(--> Supply)           { self.on('GUILD_DELETE').map( { Dusk::Event::Events::GuildDelete.new(raw => $_) }) }
#| Emitted when a user interacts with a Slash Command or UI Component. Central to v10 Bot development.
method on-interaction-create(--> Supply)     { self.on('INTERACTION_CREATE').map( { Dusk::Event::Events::InteractionCreate.new(raw => $_) }) }
method on-thread-create(--> Supply)          { self.on('THREAD_CREATE').map( { Dusk::Event::Events::ThreadCreate.new(raw => $_) }) }
method on-presence-update(--> Supply)        { self.on('PRESENCE_UPDATE').map( { Dusk::Event::Events::PresenceUpdate.new(raw => $_) }) }
method on-typing-start(--> Supply)           { self.on('TYPING_START').map( { Dusk::Event::Events::TypingStart.new(raw => $_) }) }
method on-channel-create(--> Supply)         { self.on('CHANNEL_CREATE').map( { Dusk::Event::Events::ChannelCreate.new(raw => $_) }) }
method on-channel-update(--> Supply)         { self.on('CHANNEL_UPDATE').map( { Dusk::Event::Events::ChannelUpdate.new(raw => $_) }) }
method on-channel-delete(--> Supply)         { self.on('CHANNEL_DELETE').map( { Dusk::Event::Events::ChannelDelete.new(raw => $_) }) }
method on-guild-member-add(--> Supply)       { self.on('GUILD_MEMBER_ADD').map( { Dusk::Event::Events::GuildMemberAdd.new(raw => $_) }) }
method on-guild-member-remove(--> Supply)    { self.on('GUILD_MEMBER_REMOVE').map( { Dusk::Event::Events::GuildMemberRemove.new(raw => $_) }) }
method on-guild-member-update(--> Supply)    { self.on('GUILD_MEMBER_UPDATE') } # Placeholder for full model
method on-voice-state-update(--> Supply)     { self.on('VOICE_STATE_UPDATE').map( { Dusk::Event::Events::VoiceStateUpdate.new(raw => $_) }) }
method on-voice-server-update(--> Supply)    { self.on('VOICE_SERVER_UPDATE').map( { Dusk::Event::Events::VoiceServerUpdate.new(raw => $_) }) }

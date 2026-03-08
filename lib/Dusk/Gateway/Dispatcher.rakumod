=begin pod
=head1 Dusk::Gateway::Dispatcher

Routes incoming Gateway dispatch events (op:0) to typed Supply streams.
Consumers subscribe via C<.on('EVENT_NAME')> or convenience methods.

=head2 Usage

my $dispatcher = Dusk::Gateway::Dispatcher.new(events => $event-supply);
react {
    whenever $dispatcher.on-message-create -> $event {
        say "Message from {$event.message.author.username}: {$event.message.content}";
    }
}

=end pod

use Dusk::Gateway::Payload;
use Dusk::Util::JSONTraits;
use Dusk::Event::Events;

unit class Dusk::Gateway::Dispatcher;

#| The native Supply from which the dispatcher receives raw payloads from C<Connection>.
has Supply $.events is required;   # Supply of Dusk::Gateway::Payload

#| Subscribes to a generic Gateway event ("OP_DISPATCH") and returns a filtered L<Supply> containing the payload's root hash ("d").
method on(Str $event-name --> Supply) {
    $!events.grep({ .is-dispatch && .t eq $event-name }).map({ .d });
}

# --- Core Session ---
method on-ready(--> Supply) { self.on('READY').map( { Dusk::Event::Events::Ready.new(raw => $_) }) }
method on-resumed(--> Supply) { self.on('RESUMED').map( { Dusk::Event::Events::Resumed.new(raw => $_) }) }

# --- Messages ---
method on-message-create(--> Supply) { self.on('MESSAGE_CREATE').map( { Dusk::Event::Events::MessageCreate.new(raw => $_) }) }
method on-message-update(--> Supply) { self.on('MESSAGE_UPDATE').map( { Dusk::Event::Events::MessageUpdate.new(raw => $_) }) }
method on-message-delete(--> Supply) { self.on('MESSAGE_DELETE').map( { Dusk::Event::Events::MessageDelete.new(raw => $_) }) }
method on-message-delete-bulk(--> Supply) { self.on('MESSAGE_DELETE_BULK').map( { Dusk::Event::Events::MessageDeleteBulk.new(raw => $_) }) }

# --- Reactions ---
method on-message-reaction-add(--> Supply) { self.on('MESSAGE_REACTION_ADD').map( { Dusk::Event::Events::MessageReactionAdd.new(raw => $_) }) }
method on-message-reaction-remove(--> Supply) { self.on('MESSAGE_REACTION_REMOVE').map( { Dusk::Event::Events::MessageReactionRemove.new(raw => $_) }) }
method on-message-reaction-remove-all(--> Supply) { self.on('MESSAGE_REACTION_REMOVE_ALL').map( { Dusk::Event::Events::MessageReactionRemoveAll.new(raw => $_) }) }

# --- Guilds ---
method on-guild-create(--> Supply) { self.on('GUILD_CREATE').map( { Dusk::Event::Events::GuildCreate.new(raw => $_) }) }
method on-guild-update(--> Supply) { self.on('GUILD_UPDATE').map( { Dusk::Event::Events::GuildUpdate.new(raw => $_) }) }
method on-guild-delete(--> Supply) { self.on('GUILD_DELETE').map( { Dusk::Event::Events::GuildDelete.new(raw => $_) }) }
method on-guild-audit-log-entry-create(--> Supply) { self.on('GUILD_AUDIT_LOG_ENTRY_CREATE').map( { Dusk::Event::Events::GuildAuditLogEntryCreate.new(raw => $_) }) }
method on-guild-ban-add(--> Supply) { self.on('GUILD_BAN_ADD').map( { Dusk::Event::Events::GuildBanAdd.new(raw => $_) }) }
method on-guild-ban-remove(--> Supply) { self.on('GUILD_BAN_REMOVE').map( { Dusk::Event::Events::GuildBanRemove.new(raw => $_) }) }
method on-guild-emojis-update(--> Supply) { self.on('GUILD_EMOJIS_UPDATE').map( { Dusk::Event::Events::GuildEmojisUpdate.new(raw => $_) }) }
method on-guild-stickers-update(--> Supply) { self.on('GUILD_STICKERS_UPDATE').map( { Dusk::Event::Events::GuildStickersUpdate.new(raw => $_) }) }
method on-guild-integrations-update(--> Supply) { self.on('GUILD_INTEGRATIONS_UPDATE').map( { Dusk::Event::Events::GuildIntegrationsUpdate.new(raw => $_) }) }

# --- Members ---
method on-guild-member-add(--> Supply) { self.on('GUILD_MEMBER_ADD').map( { Dusk::Event::Events::GuildMemberAdd.new(raw => $_) }) }
method on-guild-member-remove(--> Supply) { self.on('GUILD_MEMBER_REMOVE').map( { Dusk::Event::Events::GuildMemberRemove.new(raw => $_) }) }
method on-guild-member-update(--> Supply) { self.on('GUILD_MEMBER_UPDATE').map( { Dusk::Event::Events::GuildMemberUpdate.new(raw => $_) }) }

# --- Roles ---
method on-guild-role-create(--> Supply) { self.on('GUILD_ROLE_CREATE').map( { Dusk::Event::Events::GuildRoleCreate.new(raw => $_) }) }
method on-guild-role-update(--> Supply) { self.on('GUILD_ROLE_UPDATE').map( { Dusk::Event::Events::GuildRoleUpdate.new(raw => $_) }) }
method on-guild-role-delete(--> Supply) { self.on('GUILD_ROLE_DELETE').map( { Dusk::Event::Events::GuildRoleDelete.new(raw => $_) }) }

# --- Channels & Threads ---
method on-channel-create(--> Supply) { self.on('CHANNEL_CREATE').map( { Dusk::Event::Events::ChannelCreate.new(raw => $_) }) }
method on-channel-update(--> Supply) { self.on('CHANNEL_UPDATE').map( { Dusk::Event::Events::ChannelUpdate.new(raw => $_) }) }
method on-channel-delete(--> Supply) { self.on('CHANNEL_DELETE').map( { Dusk::Event::Events::ChannelDelete.new(raw => $_) }) }
method on-thread-create(--> Supply) { self.on('THREAD_CREATE').map( { Dusk::Event::Events::ThreadCreate.new(raw => $_) }) }
method on-thread-update(--> Supply) { self.on('THREAD_UPDATE').map( { Dusk::Event::Events::ThreadUpdate.new(raw => $_) }) }
method on-thread-delete(--> Supply) { self.on('THREAD_DELETE').map( { Dusk::Event::Events::ThreadDelete.new(raw => $_) }) }

# --- Interactions ---
method on-interaction-create(--> Supply) { self.on('INTERACTION_CREATE').map( { Dusk::Event::Events::InteractionCreate.new(raw => $_) }) }

# --- Presence & Typing ---
method on-presence-update(--> Supply) { self.on('PRESENCE_UPDATE').map( { Dusk::Event::Events::PresenceUpdate.new(raw => $_) }) }
method on-typing-start(--> Supply) { self.on('TYPING_START').map( { Dusk::Event::Events::TypingStart.new(raw => $_) }) }
method on-user-update(--> Supply) { self.on('USER_UPDATE').map( { Dusk::Event::Events::UserUpdate.new(raw => $_) }) }

# --- Voice ---
method on-voice-state-update(--> Supply) { self.on('VOICE_STATE_UPDATE').map( { Dusk::Event::Events::VoiceStateUpdate.new(raw => $_) }) }
method on-voice-server-update(--> Supply) { self.on('VOICE_SERVER_UPDATE').map( { Dusk::Event::Events::VoiceServerUpdate.new(raw => $_) }) }

# --- Auto Moderation ---
method on-auto-moderation-rule-create(--> Supply) { self.on('AUTO_MODERATION_RULE_CREATE').map( { Dusk::Event::Events::AutoModerationRuleCreate.new(raw => $_) }) }
method on-auto-moderation-rule-update(--> Supply) { self.on('AUTO_MODERATION_RULE_UPDATE').map( { Dusk::Event::Events::AutoModerationRuleUpdate.new(raw => $_) }) }
method on-auto-moderation-rule-delete(--> Supply) { self.on('AUTO_MODERATION_RULE_DELETE').map( { Dusk::Event::Events::AutoModerationRuleDelete.new(raw => $_) }) }
method on-auto-moderation-action-execution(--> Supply) { self.on('AUTO_MODERATION_ACTION_EXECUTION').map( { Dusk::Event::Events::AutoModerationActionExecution.new(raw => $_) }) }

# --- Stage Instances ---
method on-stage-instance-create(--> Supply) { self.on('STAGE_INSTANCE_CREATE').map( { Dusk::Event::Events::StageInstanceCreate.new(raw => $_) }) }
method on-stage-instance-update(--> Supply) { self.on('STAGE_INSTANCE_UPDATE').map( { Dusk::Event::Events::StageInstanceUpdate.new(raw => $_) }) }
method on-stage-instance-delete(--> Supply) { self.on('STAGE_INSTANCE_DELETE').map( { Dusk::Event::Events::StageInstanceDelete.new(raw => $_) }) }

# --- Entitlements ---
method on-entitlement-create(--> Supply) { self.on('ENTITLEMENT_CREATE').map( { Dusk::Event::Events::EntitlementCreate.new(raw => $_) }) }
method on-entitlement-update(--> Supply) { self.on('ENTITLEMENT_UPDATE').map( { Dusk::Event::Events::EntitlementUpdate.new(raw => $_) }) }
method on-entitlement-delete(--> Supply) { self.on('ENTITLEMENT_DELETE').map( { Dusk::Event::Events::EntitlementDelete.new(raw => $_) }) }

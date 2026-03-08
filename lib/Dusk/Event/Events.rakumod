use v6.d;
use Dusk::Event;
use Dusk::Model::Message;
use Dusk::Model::User;
use Dusk::Model::Guild;
use Dusk::Model::Channel;
use Dusk::Model::Interaction;
use Dusk::Model::Member;
use Dusk::Model::Role;
use Dusk::Model::VoiceState;
use Dusk::Model::Presence;
use Dusk::Model::Emoji;
use Dusk::Model::Sticker;
use Dusk::Model::AuditLogEntry;
use Dusk::Model::AutoModRule;
use Dusk::Model::ScheduledEvent;
use Dusk::Model::StageInstance;
use Dusk::Model::Entitlement;

unit module Dusk::Event::Events;

# --- Core Session ---
class Ready does Dusk::Event {
    method v(--> Int) { $!raw<v> }
    method user(--> Dusk::Model::User) { Dusk::Model::User.from-json($!raw<user> || {}) }
    method guilds(--> Positional) { $!raw<guilds> }
    method session-id(--> Str) { $!raw<session_id> }
    method resume-gateway-url(--> Str) { $!raw<resume_gateway_url> }
}
class Resumed does Dusk::Event { }

# --- Messages ---
class MessageCreate does Dusk::Event {
    method message(--> Dusk::Model::Message) { Dusk::Model::Message.from-json($!raw || {}) }
    method guild-id(--> Str) { $!raw<guild_id> // '' }
}
class MessageUpdate does Dusk::Event {
    method message(--> Dusk::Model::Message) { Dusk::Model::Message.from-json($!raw || {}) }
}
class MessageDelete does Dusk::Event {
    method id(--> Str) { $!raw<id> }
    method channel-id(--> Str) { $!raw<channel_id> }
    method guild-id(--> Str) { $!raw<guild_id> // '' }
}
class MessageDeleteBulk does Dusk::Event {
    method ids(--> Positional) { $!raw<ids> }
    method channel-id(--> Str) { $!raw<channel_id> }
    method guild-id(--> Str) { $!raw<guild_id> // '' }
}

# --- Reactions ---
class MessageReactionAdd does Dusk::Event {
    method user-id(--> Str) { $!raw<user_id> }
    method channel-id(--> Str) { $!raw<channel_id> }
    method message-id(--> Str) { $!raw<message_id> }
    method guild-id(--> Str) { $!raw<guild_id> // '' }
    method emoji(--> Dusk::Model::Emoji) { Dusk::Model::Emoji.from-json($!raw<emoji> || {}) }
    method member(--> Dusk::Model::Member) { Dusk::Model::Member.from-json($!raw<member> || {}) if $!raw<member> }
}
class MessageReactionRemove does Dusk::Event {
    method user-id(--> Str) { $!raw<user_id> }
    method channel-id(--> Str) { $!raw<channel_id> }
    method message-id(--> Str) { $!raw<message_id> }
    method emoji(--> Dusk::Model::Emoji) { Dusk::Model::Emoji.from-json($!raw<emoji> || {}) }
}
class MessageReactionRemoveAll does Dusk::Event {
    method channel-id(--> Str) { $!raw<channel_id> }
    method message-id(--> Str) { $!raw<message_id> }
    method guild-id(--> Str) { $!raw<guild_id> // '' }
}

# --- Guilds ---
class GuildCreate does Dusk::Event {
    method guild(--> Dusk::Model::Guild) { Dusk::Model::Guild.from-json($!raw || {}) }
}
class GuildUpdate does Dusk::Event {
    method guild(--> Dusk::Model::Guild) { Dusk::Model::Guild.from-json($!raw || {}) }
}
class GuildDelete does Dusk::Event {
    method id(--> Str) { $!raw<id> }
    method unavailable(--> Bool) { ?($!raw<unavailable> // False) }
}
class GuildAuditLogEntryCreate does Dusk::Event {
    method entry(--> Dusk::Model::AuditLogEntry) { Dusk::Model::AuditLogEntry.from-json($!raw || {}) }
}
class GuildBanAdd does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> }
    method user(--> Dusk::Model::User) { Dusk::Model::User.from-json($!raw<user> || {}) }
}
class GuildBanRemove does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> }
    method user(--> Dusk::Model::User) { Dusk::Model::User.from-json($!raw<user> || {}) }
}
class GuildEmojisUpdate does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> }
    method emojis(--> Positional) { ($!raw<emojis> // []).map({ Dusk::Model::Emoji.from-json($_) }).List }
}
class GuildStickersUpdate does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> }
    method stickers(--> Positional) { ($!raw<stickers> // []).map({ Dusk::Model::Sticker.from-json($_) }).List }
}
class GuildIntegrationsUpdate does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> }
}

# --- Members ---
class GuildMemberAdd does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> }
    method member(--> Dusk::Model::Member) { Dusk::Model::Member.from-json($!raw || {}) }
}
class GuildMemberRemove does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> }
    method user(--> Dusk::Model::User) { Dusk::Model::User.from-json($!raw<user> || {}) }
}
class GuildMemberUpdate does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> }
    method user(--> Dusk::Model::User) { Dusk::Model::User.from-json($!raw<user> || {}) }
    method member(--> Dusk::Model::Member) { Dusk::Model::Member.from-json($!raw || {}) }
}

# --- Roles ---
class GuildRoleCreate does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> }
    method role(--> Dusk::Model::Role) { Dusk::Model::Role.from-json($!raw<role> || {}) }
}
class GuildRoleUpdate does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> }
    method role(--> Dusk::Model::Role) { Dusk::Model::Role.from-json($!raw<role> || {}) }
}
class GuildRoleDelete does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> }
    method role-id(--> Str) { $!raw<role_id> }
}

# --- Channels & Threads ---
class ChannelCreate does Dusk::Event {
    method channel(--> Dusk::Model::Channel) { Dusk::Model::Channel.from-json($!raw || {}) }
}
class ChannelUpdate does Dusk::Event {
    method channel(--> Dusk::Model::Channel) { Dusk::Model::Channel.from-json($!raw || {}) }
}
class ChannelDelete does Dusk::Event {
    method channel(--> Dusk::Model::Channel) { Dusk::Model::Channel.from-json($!raw || {}) }
}
class ThreadCreate does Dusk::Event {
    method thread(--> Dusk::Model::Channel) { Dusk::Model::Channel.from-json($!raw || {}) }
}
class ThreadUpdate does Dusk::Event {
    method thread(--> Dusk::Model::Channel) { Dusk::Model::Channel.from-json($!raw || {}) }
}
class ThreadDelete does Dusk::Event {
    method id(--> Str) { $!raw<id> }
    method guild-id(--> Str) { $!raw<guild_id> }
    method parent-id(--> Str) { $!raw<parent_id> }
    method type(--> Int) { $!raw<type> }
}

# --- Interactions ---
class InteractionCreate does Dusk::Event {
    method interaction(--> Dusk::Model::Interaction) { Dusk::Model::Interaction.from-json($!raw || {}) }
}

# --- Presence & Typing ---
class PresenceUpdate does Dusk::Event {
    method presence(--> Dusk::Model::Presence) { Dusk::Model::Presence.from-json($!raw || {}) }
}
class TypingStart does Dusk::Event {
    method channel-id(--> Str) { $!raw<channel_id> }
    method guild-id(--> Str) { $!raw<guild_id> // '' }
    method user-id(--> Str) { $!raw<user_id> }
    method timestamp(--> Int) { $!raw<timestamp> }
}
class UserUpdate does Dusk::Event {
    method user(--> Dusk::Model::User) { Dusk::Model::User.from-json($!raw || {}) }
}

# --- Voice ---
class VoiceStateUpdate does Dusk::Event {
    method voice-state(--> Dusk::Model::VoiceState) { Dusk::Model::VoiceState.from-json($!raw || {}) }
}
class VoiceServerUpdate does Dusk::Event {
    method token(--> Str) { $!raw<token> }
    method guild-id(--> Str) { $!raw<guild_id> }
    method endpoint(--> Str) { $!raw<endpoint> // '' }
}

# --- Auto Moderation ---
class AutoModerationRuleCreate does Dusk::Event {
    method rule(--> Dusk::Model::AutoModRule) { Dusk::Model::AutoModRule.from-json($!raw || {}) }
}
class AutoModerationRuleUpdate does Dusk::Event {
    method rule(--> Dusk::Model::AutoModRule) { Dusk::Model::AutoModRule.from-json($!raw || {}) }
}
class AutoModerationRuleDelete does Dusk::Event {
    method rule(--> Dusk::Model::AutoModRule) { Dusk::Model::AutoModRule.from-json($!raw || {}) }
}
class AutoModerationActionExecution does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> }
    method action(--> Hash) { $!raw<action> }
    method rule-id(--> Str) { $!raw<rule_id> }
    method user-id(--> Str) { $!raw<user_id> }
    method content(--> Str) { $!raw<content> // '' }
}

# --- Stage Instances ---
class StageInstanceCreate does Dusk::Event {
    method instance(--> Dusk::Model::StageInstance) { Dusk::Model::StageInstance.from-json($!raw || {}) }
}
class StageInstanceUpdate does Dusk::Event {
    method instance(--> Dusk::Model::StageInstance) { Dusk::Model::StageInstance.from-json($!raw || {}) }
}
class StageInstanceDelete does Dusk::Event {
    method instance(--> Dusk::Model::StageInstance) { Dusk::Model::StageInstance.from-json($!raw || {}) }
}

# --- Entitlements ---
class EntitlementCreate does Dusk::Event {
    method entitlement(--> Dusk::Model::Entitlement) { Dusk::Model::Entitlement.from-json($!raw || {}) }
}
class EntitlementUpdate does Dusk::Event {
    method entitlement(--> Dusk::Model::Entitlement) { Dusk::Model::Entitlement.from-json($!raw || {}) }
}
class EntitlementDelete does Dusk::Event {
    method entitlement(--> Dusk::Model::Entitlement) { Dusk::Model::Entitlement.from-json($!raw || {}) }
}

# --- Pins & Invites ---
class ChannelPinsUpdate does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> // '' }
    method channel-id(--> Str) { $!raw<channel_id> }
    method last-pin-timestamp(--> Str) { $!raw<last_pin_timestamp> // '' }
}

class InviteCreate does Dusk::Event {
    method channel-id(--> Str) { $!raw<channel_id> }
    method code(--> Str) { $!raw<code> }
    method guild-id(--> Str) { $!raw<guild_id> // '' }
}

class InviteDelete does Dusk::Event {
    method channel-id(--> Str) { $!raw<channel_id> }
    method code(--> Str) { $!raw<code> }
    method guild-id(--> Str) { $!raw<guild_id> // '' }
}

# --- Reactions ---
class MessageReactionRemoveEmoji does Dusk::Event {
    method channel-id(--> Str) { $!raw<channel_id> }
    method message-id(--> Str) { $!raw<message_id> }
    method guild-id(--> Str) { $!raw<guild_id> // '' }
    method emoji(--> Hash) { $!raw<emoji> // {} }
}

# --- Threads ---
class ThreadListSync does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> }
    method channel-ids(--> Positional) { $!raw<channel_ids> // [] }
    method threads(--> Positional) { $!raw<threads> // [] }
}

class ThreadMemberUpdate does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> }
    method id(--> Str) { $!raw<id> }
    method user-id(--> Str) { $!raw<user_id> }
    method member(--> Hash) { $!raw<member> // {} }
}

class ThreadMembersUpdate does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> }
    method id(--> Str) { $!raw<id> }
    method guild-member-count(--> Int) { $!raw<guild_member_count> // 0 }
    method added-members(--> Positional) { $!raw<added_members> // [] }
    method removed-member-ids(--> Positional) { $!raw<removed_member_ids> // [] }
}

# --- Webhooks ---
class WebhooksUpdate does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> }
    method channel-id(--> Str) { $!raw<channel_id> // '' }
}

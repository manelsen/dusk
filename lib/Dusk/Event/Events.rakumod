use v6.d;
use Dusk::Event;
use Dusk::Model::Message;
use Dusk::Model::User;
use Dusk::Model::Guild;
use Dusk::Model::Channel;
use Dusk::Model::Interaction;
use Dusk::Model::Member;
use Dusk::Model::VoiceState;
use Dusk::Model::Presence;

unit module Dusk::Event::Events;

#| Triggered when the Bot successfully connects and the session is established.
class Ready does Dusk::Event {
    method v(--> Int) { $!raw<v> }
    method user(--> Dusk::Model::User) { Dusk::Model::User.from-json($!raw<user> || {}) }
    method guilds(--> Positional) { $!raw<guilds> }
    method session-id(--> Str) { $!raw<session_id> }
    method resume-gateway-url(--> Str) { $!raw<resume_gateway_url> }
}

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

class GuildCreate does Dusk::Event {
    method guild(--> Dusk::Model::Guild) { Dusk::Model::Guild.from-json($!raw || {}) }
    method channels(--> Positional) { ($!raw<channels> // []).map({ Dusk::Model::Channel.from-json($_) }).List }
    method members(--> Positional) { ($!raw<members> // []).map({ Dusk::Model::Member.from-json($_) }).List }
}

class GuildDelete does Dusk::Event {
    method id(--> Str) { $!raw<id> }
    method unavailable(--> Bool) { ?($!raw<unavailable> // False) }
}

class InteractionCreate does Dusk::Event {
    method interaction(--> Dusk::Model::Interaction) { Dusk::Model::Interaction.from-json($!raw || {}) }
}

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

class GuildMemberAdd does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> }
    method member(--> Dusk::Model::Member) { Dusk::Model::Member.from-json($!raw || {}) }
}

class GuildMemberRemove does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> }
    method user(--> Dusk::Model::User) { Dusk::Model::User.from-json($!raw<user> || {}) }
}

class PresenceUpdate does Dusk::Event {
    method presence(--> Dusk::Model::Presence) { Dusk::Model::Presence.from-json($!raw || {}) }
}

class TypingStart does Dusk::Event {
    method channel-id(--> Str) { $!raw<channel_id> }
    method guild-id(--> Str) { $!raw<guild_id> // '' }
    method user-id(--> Str) { $!raw<user_id> }
    method timestamp(--> Int) { $!raw<timestamp> }
}

class VoiceStateUpdate does Dusk::Event {
    method voice-state(--> Dusk::Model::VoiceState) { Dusk::Model::VoiceState.from-json($!raw || {}) }
}

class VoiceServerUpdate does Dusk::Event {
    method token(--> Str) { $!raw<token> }
    method guild-id(--> Str) { $!raw<guild_id> }
    method endpoint(--> Str) { $!raw<endpoint> // '' }
}

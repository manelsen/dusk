=begin pod
=head1 Dusk::Event::Events

Typed models for Discord Gateway dispatch events.
These wrap the raw Hash payloads into C<Dusk::Event> objects, allowing
fluent access to underlying types like C<Dusk::Model::Message>.

=end pod

use Dusk::Event;
use Dusk::Model::Message;
use Dusk::Model::User;
use Dusk::Model::Guild;
use Dusk::Model::Channel;

unit module Dusk::Event::Events;

#| Evento disparado quando o Bot se conecta com sucesso e a sessão é estabelecida.
class Ready does Dusk::Event {
    method v(--> Int) { $!raw<v> }
    method user(--> Dusk::Model::User) { Dusk::Model::User.new(|$!raw<user>) }
    method guilds(--> Positional) { $!raw<guilds> }
    method session-id(--> Str) { $!raw<session_id> }
    method resume-gateway-url(--> Str) { $!raw<resume_gateway_url> }
}

#| Emitido quando uma nova mensagem (texto, anexo, embed) é enviada em um canal.
class MessageCreate does Dusk::Event {
    method message(--> Dusk::Model::Message) { Dusk::Model::Message.new(|$!raw) }
    method guild-id(--> Str) { $!raw<guild_id> // '' }
}

#| Emitido quando o conteúdo ou embeds de uma mensagem são alterados.
class MessageUpdate does Dusk::Event {
    method id(--> Str) { $!raw<id> }
    method channel-id(--> Str) { $!raw<channel_id> }
    method content(--> Str) { $!raw<content> // '' }
}

#| Emitido quando uma mensagem é previamente deletada do canal.
class MessageDelete does Dusk::Event {
    method id(--> Str) { $!raw<id> }
    method channel-id(--> Str) { $!raw<channel_id> }
    method guild-id(--> Str) { $!raw<guild_id> // '' }
}

#| Emitido no login (preenchendo a cache de servidores) ou quando o bot entra num Guild novo.
class GuildCreate does Dusk::Event {
    method guild(--> Dusk::Model::Guild) { Dusk::Model::Guild.new(|$!raw) }
    method channels(--> Positional) { $!raw<channels> // [] }
    method members(--> Positional) { $!raw<members> // [] }
}

#| Emitido quando o bot é removido de um servidor ou ocorrem falhas de indisponibilidade (Outages).
class GuildDelete does Dusk::Event {
    method id(--> Str) { $!raw<id> }
    method unavailable(--> Bool) { ?($!raw<unavailable> // False) }
}

#| O coração das aplicações v10: Evento gerado por Slash Commands, Botões ou Formulários (Modals).
class InteractionCreate does Dusk::Event {
    method id(--> Str) { $!raw<id> }
    method application-id(--> Str) { $!raw<application_id> }
    method type(--> Int) { $!raw<type> }
    method data(--> Hash) { $!raw<data> // %() }
    method guild-id(--> Str) { $!raw<guild_id> // '' }
    method channel(--> Dusk::Model::Channel) { Dusk::Model::Channel.new(|$!raw<channel>) }
    method token(--> Str) { $!raw<token> }
    method version(--> Int) { $!raw<version> }
    method user(--> Dusk::Model::User) {
        $!raw<member>
        ?? Dusk::Model::User.new(|$!raw<member><user>)
        !! Dusk::Model::User.new(|$!raw<user>)
    }
}

class ChannelCreate does Dusk::Event {
    method channel(--> Dusk::Model::Channel) { Dusk::Model::Channel.new(|$!raw) }
}

class ChannelUpdate does Dusk::Event {
    method channel(--> Dusk::Model::Channel) { Dusk::Model::Channel.new(|$!raw) }
}

class ChannelDelete does Dusk::Event {
    method channel(--> Dusk::Model::Channel) { Dusk::Model::Channel.new(|$!raw) }
}

class ThreadCreate does Dusk::Event {
    method thread(--> Dusk::Model::Channel) { Dusk::Model::Channel.new(|$!raw) }
}

class GuildMemberAdd does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> }
    method user(--> Dusk::Model::User) { Dusk::Model::User.new(|$!raw<user>) }
    method roles(--> Positional) { $!raw<roles> // [] }
}

class GuildMemberRemove does Dusk::Event {
    method guild-id(--> Str) { $!raw<guild_id> }
    method user(--> Dusk::Model::User) { Dusk::Model::User.new(|$!raw<user>) }
}

class PresenceUpdate does Dusk::Event {
    method user(--> Dusk::Model::User) { Dusk::Model::User.new(|$!raw<user>) }
    method guild-id(--> Str) { $!raw<guild_id> }
    method status(--> Str) { $!raw<status> }
}

class TypingStart does Dusk::Event {
    method channel-id(--> Str) { $!raw<channel_id> }
    method guild-id(--> Str) { $!raw<guild_id> // '' }
    method user-id(--> Str) { $!raw<user_id> }
    method timestamp(--> Int) { $!raw<timestamp> }
}

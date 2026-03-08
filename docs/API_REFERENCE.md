# Dusk API Reference

## Table of Contents

- [Core](#core)
- [REST API](#rest-api)
- [Gateway](#gateway)
- [Voice](#voice)
- [Models](#models)
- [Enums](#enums)
- [Events](#events)

---

## Core

### Dusk::Rest::Endpoint

Main class for all REST API endpoints.

```raku
use Dusk::Rest::Endpoint;

# Get a channel
my $route = Dusk::Rest::Endpoint.get-channel(channel-id => '123');

# Send a message
my $msg-route = Dusk::Rest::Endpoint.post-channels-messages(
    channel-id => '123',
    content => 'Hello!'
);
```

---

## REST API

### Application Endpoints

#### GET /applications/@me

Get information about the current application.

```raku
my $route = Dusk::Rest::Endpoint.get-applications-me();
```

#### PATCH /applications/@me

Update information about the current application.

```raku
my $route = Dusk::Rest::Endpoint.patch-applications-me(
    description => 'New description',
);
```

#### GET /applications/{application.id}

Get information about an application.

```raku
my $route = Dusk::Rest::Endpoint.get-application(
    application-id => '123'
);
```

#### GET /applications/{application.id}/role-connections/metadata

Get role connection metadata for an application.

```raku
my $route = Dusk::Rest::Endpoint.get-applications-role-connections-metadata(
    application-id => '123'
);
```

### Channel Endpoints

#### GET /channels/{channel.id}

Get a channel object.

```raku
my $route = Dusk::Rest::Endpoint.get-channel(
    channel-id => '123'
);
```

#### GET /channels/{channel.id}/messages

Get messages in a channel.

```raku
my $route = Dusk::Rest::Endpoint.get-channels-messages(
    channel-id => '123'
);
```

#### POST /channels/{channel.id}/messages

Create a new message.

```raku
my $route = Dusk::Rest::Endpoint.post-channels-messages(
    channel-id => '123',
    content => 'Hello, world!'
);
```

#### PATCH /channels/{channel.id}/messages/{message.id}

Edit a message.

```raku
my $route = Dusk::Rest::Endpoint.patch-channels-messages(
    channel-id => '123',
    message-id => '456',
    content => 'Edited message'
);
```

#### DELETE /channels/{channel.id}/messages/{message.id}

Delete a message.

```raku
my $route = Dusk::Rest::Endpoint.delete-channels-messages(
    channel-id => '123',
    message-id => '456'
);
```

### Guild Endpoints

#### GET /guilds/{guild.id}

Get a guild object.

```raku
my $route = Dusk::Rest::Endpoint.get-guild(
    guild-id => '123'
);
```

#### PATCH /guilds/{guild.id}

Modify a guild.

```raku
my $route = Dusk::Rest::Endpoint.patch-guilds(
    guild-id => '123',
    name => 'New Name'
);
```

#### GET /guilds/{guild.id}/members

Get members of a guild.

```raku
my $route = Dusk::Rest::Endpoint.get-guilds-members(
    guild-id => '123'
);
```

#### PATCH /guilds/{guild.id}/onboarding

Update guild onboarding settings.

```raku
my $route = Dusk::Rest::Endpoint.patch-guilds-onboarding(
    guild-id => '123',
    prompts => [...]
);
```

#### PATCH /guilds/{guild.id}/incident-actions

Send guild incident actions.

```raku
my $route = Dusk::Rest::Endpoint.patch-guilds-incident-actions(
    guild-id => '123',
    actions => [...]
);
```

### User Endpoints

#### GET /users/@me

Get the current user.

```raku
my $route = Dusk::Rest::Endpoint.get-users-me();
```

#### PATCH /users/@me

Modify the current user.

```raku
my $route = Dusk::Rest::Endpoint.patch-users-me(
    username => 'NewUsername'
);
```

### Webhook Endpoints

#### POST /webhooks/{webhook.id}/{webhook.token}

Execute a webhook.

```raku
my $route = Dusk::Rest::Endpoint.post-webhooks(
    webhook-id => '123',
    webhook-token => 'abc',
    content => 'Hello from webhook!'
);
```

---

## Gateway

### Dusk::Gateway::Connection

WebSocket connection to Discord Gateway.

```raku
use Dusk::Gateway::Connection;

my $gateway = Dusk::Gateway::Connection.new(
    token => 'BOT_TOKEN',
    intents => GUILD | MESSAGES
);

$gateway.connect;
```

### Dusk::Gateway::Dispatcher

Event dispatcher for Gateway events.

```raku
use Dusk::Gateway::Dispatcher;

my $dispatcher = Dusk::Gateway::Dispatcher.new;

# Register handlers
$dispatcher.on(MessageCreate, sub ($event) {
    say "New message: " ~ $event.message.content;
});

$dispatcher.on(Ready, sub ($event) {
    say "Connected as: " ~ $event.user.username;
});
```

### Dusk::Gateway::Intents

Gateway intent flags.

```raku
use Dusk::Gateway::Intents;

# Combine intents
my $intents = GUILD | MESSAGES | PRESENCE;

# Use with connection
my $gateway = Dusk::Gateway::Connection.new(
    token => 'BOT_TOKEN',
    intents => $intents
);
```

---

## Voice

### Dusk::Voice::Client

Voice client for audio transmission.

```raku
use Dusk::Voice::Client;

my $voice = Dusk::Voice::Client.new(
    token => 'BOT_TOKEN',
    guild-id => '123',
    user-id => '456'
);

$voice.connect;
$voice.speak('audio.opus');
```

---

## Models

### Dusk::Model::Channel

Represents a Discord channel.

```raku
my $channel = Dusk::Model::Channel.new(
    id => '123',
    name => 'general',
    type => ChannelType::GuildText,
);
```

### Dusk::Model::Message

Represents a Discord message.

```raku
my $message = Dusk::Model::Message.new(
    id => '123',
    content => 'Hello!',
    author => $user,
    channel-id => '456',
);
```

### Dusk::Model::User

Represents a Discord user.

```raku
my $user = Dusk::Model::User.new(
    id => '123',
    username => 'TestUser',
    discriminator => '1234',
);
```

### Dusk::Model::Guild

Represents a Discord guild.

```raku
my $guild = Dusk::Model::Guild.new(
    id => '123',
    name => 'Test Server',
    owner-id => '456',
);
```

---

## Enums

### ActivityType

Types of activities for rich presence.

```raku
use Dusk::Enum;
use ActivityType;

my $type = ActivityType::Game;        # 0
my $type = ActivityType::Streaming;   # 1
my $type = ActivityType::Listening;   # 2
```

### ChannelType

Types of Discord channels.

```raku
use Dusk::Enum;
use ChannelType;

my $type = ChannelType::GuildText;   # 0
my $type = ChannelType::DM;          # 1
my $type = ChannelType::GuildVoice;  # 2
```

### MessageFlags

Flags for messages.

```raku
use Dusk::Enum;
use MessageFlags;

my $flags = MessageFlags::Ephemeral;         # 64
my $flags = MessageFlags::Crossposted;        # 1
```

### Permission

Discord permission flags.

```raku
use Dusk::Enum;
use Permission;

my $perm = Permission::SendMessages;      # 2048
my $perm = Permission::Administrator;      # 8
my $perm = Permission::ManageMessages;     # 8192
```

### VerificationLevel

Guild verification levels.

```raku
use Dusk::Enum;
use VerificationLevel;

my $level = VerificationLevel::None;      # 0
my $level = VerificationLevel::High;      # 3
```

---

## Events

### MessageCreate

Fired when a message is created.

```raku
$dispatcher.on(MessageCreate, sub ($event) {
    my $msg = $event.message;
    say "Message from: " ~ $msg.author.username;
});
```

### GuildCreate

Fired when the bot joins a guild.

```raku
$dispatcher.on(GuildCreate, sub ($event) {
    say "Joined guild: " ~ $event.guild.name;
});
```

### VoiceStateUpdate

Fired when a user's voice state changes.

```raku
$dispatcher.on(VoiceStateUpdate, sub ($event) {
    say "Voice state changed for: " ~ $event.user-id;
});
```

### ChannelPinsUpdate

Fired when a message is pinned or unpinned.

```raku
$dispatcher.on(ChannelPinsUpdate, sub ($event) {
    say "Pins updated in: " ~ $event.channel-id;
});
```

### ThreadListSync

Fired when the thread list is synced.

```raku
$dispatcher.on(ThreadListSync, sub ($event) {
    say "Thread list synced for: " ~ $event.guild-id;
});
```

---

## Error Handling

### Dusk::Error

Base error class for Dusk exceptions.

```raku
use Dusk::Error;

try {
    # Some operation that might fail
    CATCH {
        when Dusk::Error {
            say "Dusk error: " ~ $_.message;
        }
    }
}
```

---

## Rate Limiting

### Dusk::Rest::RateLimiter

Automatic rate limiting for REST API requests.

```raku
use Dusk::Rest::RateLimiter;

my $limiter = Dusk::Rest::RateLimiter.new;

# Rate limiter is automatically used by REST::Client
my $client = Dusk::Rest::Client.new(
    token => 'BOT_TOKEN',
    rate-limiter => $limiter
);
```

---

## Examples

### Basic Echo Bot

```raku
use v6.d;
use Dusk::Gateway::Connection;
use Dusk::Gateway::Dispatcher;
use Dusk::Gateway::Intents;
use Dusk::Event::Events;

my $token = 'YOUR_BOT_TOKEN';

my $gateway = Dusk::Gateway::Connection.new(
    token => $token,
    intents => GUILD | MESSAGES
);

my $dispatcher = Dusk::Gateway::Dispatcher.new;

$dispatcher.on(MessageCreate, sub ($event) {
    if $event.message.content eq '!ping' {
        my $channel-id = $event.message.channel-id;
        my $route = Dusk::Rest::Endpoint.post-channels-messages(
            channel-id => $channel-id,
            content => 'Pong!'
        );
    }
});

$gateway.connect;
```

### Slash Command Handler

```raku
use v6.d;
use Dusk::Gateway::Dispatcher;
use Dusk::Event::Events;

my $dispatcher = Dusk::Gateway::Dispatcher.new;

$dispatcher.on(InteractionCreate, sub ($event) {
    if $event.interaction.type == APPLICATION_COMMAND {
        my $interaction-id = $event.interaction.id;
        my $token = $event.interaction.token;
        
        # Send response
        Dusk::Rest::Endpoint.post-interactions-callback(
            interaction-id => $interaction-id,
            interaction-token => $token,
            type => 4,
            data => { content => 'Command executed!' }
        );
    }
});
```

---

## Further Reading

- [README.md](../README.md)
- [CHANGELOG.md](../CHANGELOG.md)
- [Internal Architecture](./INTERNALS.md)

---

**Last Updated:** 2025-02-26  
**Version:** 0.3.0

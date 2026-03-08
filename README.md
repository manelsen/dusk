# Dusk

> Idiomatic Raku wrapper for the Discord API v10, providing support for REST, Gateway, and Voice.

[![License: MIT](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

## Installation

```
zef install Dusk
```

Or from source:

```
git clone https://github.com/manelsen/dusk.git
cd dusk
zef install .
```

## Quick Start

```raku
use Dusk::Rest::Client;
use Dusk::Rest::Endpoint;

my $client = Dusk::Rest::Client.new(token => %*ENV<DISCORD_BOT_TOKEN>);

# Get current bot user
my $route = Dusk::Rest::Endpoint.get-users-me();
my $me = await $client.request($route);
say "Logged in as: $me<username>#$me<discriminator>";

# Send a message
my $msg-route = Dusk::Rest::Endpoint.post-channels-messages(
    channel-id => '123456789',
    body => { content => 'Hello from Dusk!' }
);
my $msg = await $client.request($msg-route);
say "Sent message: $msg<id>";
```

## Features

- **REST API** — Comprehensive endpoint mapping to typed `Route` objects
- **Gateway Support** — WebSocket connection with typed events via `Dispatcher`
- **Voice Support** — Audio transmission, UDP connection, and encryption (`xchacha20_poly1305`)
- **Async by default** — all network operations and event handlers use `Promise` and `Supply`
- **Rate limit handling** — automatic retry on HTTP 429 with `Retry-After` (soon to be proactive)
- **Functional core / effectful edge** — pure Models and Routes, side effects isolated in Client
- **Modern Security** — Support for `xchacha20_poly1305` encryption for Voice and strict token protection

## Architecture

```
(Your Code) ──→ Dusk::Rest::Client (Edge) ──→ Discord API
                        │
                        ▼
                Dusk::Rest::Endpoint (Core)
                        │
                        ▼
                 Dusk::Model::* (Core)
```

| Layer | Module | Role |
|-------|--------|------|
| **Core (Pure)** | `Dusk::Model::User`, `Channel`, `Message`, `Guild` | Immutable value objects |
| **Core (Pure)** | `Dusk::Rest::Endpoint` | Route builder |
| **Core (Pure)** | `Dusk::Rest::Route` | HTTP method + path carrier |
| **Edge** | `Dusk::Rest::Client` | HTTP execution, auth, proactive rate limiting |

## Error Handling

```raku
use Dusk::Error;

try {
    my $res = await $client.request($route);
    CATCH {
        when Dusk::Error::Unauthorized { say "Invalid token!" }
        when Dusk::Error::Forbidden    { say "Missing permissions!" }
        when Dusk::Error::NotFound     { say "Resource not found: {.path}" }
        when Dusk::Error::RateLimit    { say "Rate limited, retry after {.retry-after}s" }
        when Dusk::Error::APIError     { say "API error: HTTP {.status}" }
    }
}
```

## Testing

```
# Unit + endpoint tests (no network)
prove6 -l t/

# Integration tests (requires DISCORD_BOT_TOKEN in .env)
prove6 -l t/05-integration.t
```

## Roadmap

| Version | Status | Focus |
|---------|--------|-------|
| `0.1.x` | ✅ | REST API basic wrapper |
| `0.2.x` | ✅ | Gateway WebSocket & Heartbeat |
| `0.3.0` | 🔄 | Voice Support (UDP/RTP) & Proactive Rate Limiting |
| `0.4.0` | ✅ | 100% Gateway Event Coverage & Exhaustive REST API mapping |
| `0.5.0` | 🔄 | Interaction Framework (Buttons, Select Menus, Modals) |
| `1.0.0` | ⏳ | Production Stable Release |

## License

MIT

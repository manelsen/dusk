# Dusk

> Idiomatic Raku wrapper for the Discord REST API v10.

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

- **219 REST endpoints** mapped to typed `Route` objects
- **Async by default** — all requests return `Promise`
- **Rate limit handling** — automatic retry on HTTP 429 with `Retry-After`
- **Typed exceptions** — `Dusk::Error::Unauthorized`, `NotFound`, `Forbidden`, `APIError`, `RateLimit`
- **Token safety** — token never exposed in `.gist` or `.Str` (RNF-02)
- **Functional core / effectful edge** — pure Models and Routes, side effects isolated in Client

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
| **Core (Pure)** | `Dusk::Rest::Endpoint` | Route builder (219 methods) |
| **Core (Pure)** | `Dusk::Rest::Route` | HTTP method + path carrier |
| **Edge** | `Dusk::Rest::Client` | HTTP execution, auth, rate limiting |

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
prove6 -l t/01-models.t t/02-endpoint.t t/03-client.t t/04-rest-flow.t t/06-rate-limit.t t/07-errors.t

# Integration tests (requires DISCORD_BOT_TOKEN in .env)
prove6 -l t/05-integration.t
```

## Roadmap

| Version | Content |
|---------|---------|
| `0.1.x` | REST API wrapper (current) |
| `0.2.0` | Asgard re-gate closure |
| `0.2.1` | Gateway WebSocket (events, heartbeat) |
| `0.2.2` | Slash Commands, Buttons, Modals |
| `0.2.3` | Cache, connection pooling, Voice stub |

## License

MIT

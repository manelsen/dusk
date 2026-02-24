# Implementation Log

## Gate 06 — Retroactive Mapping

| Ref | Requirement | Contract | Tests | Implementation |
|-----|------------|----------|-------|----------------|
| IMPL-01 | RF-01 | `Endpoint.*` → Route | t/02-endpoint.t (219 subtests) | `lib/Dusk/Rest/Endpoint.rakumod` — 219 métodos auto-gerados via `generate_endpoint_class.pl` |
| IMPL-02 | RF-01 | `Client.request` | t/03-client.t, t/04-rest-flow.t | `lib/Dusk/Rest/Client.rakumod` — Cro::HTTP::Client, headers de auth, mock dispatcher |
| IMPL-03 | RF-01 | `Route` data carrier | t/02-endpoint.t (via Route) | `lib/Dusk/Rest/Route.rakumod` — method, path, body |
| IMPL-04 | RF-01, RF-02 | `Model::Channel` | t/01-models.t, t/04-rest-flow.t | `lib/Dusk/Model/Channel.rakumod` — id, name, type, guild-id |
| IMPL-05 | RF-01 | `Model::User` | t/01-models.t | `lib/Dusk/Model/User.rakumod` — id, username, discriminator, avatar, bot, system |
| IMPL-06 | RF-01 | `Model::Message` | t/01-models.t | `lib/Dusk/Model/Message.rakumod` — id, channel-id, content, author (nested User) |
| IMPL-07 | RF-01 | `Model::Guild` | t/01-models.t | `lib/Dusk/Model/Guild.rakumod` — id, name, owner-id, verification-level |
| IMPL-08 | RNF-01 | `Client.request` retry | t/05-integration.t (indiretamente) | `lib/Dusk/Rest/Client.rakumod` L58-82 — HTTP 429 → Retry-After → sleep → retry (max 3) |
| IMPL-09 | RNF-02 | `Client.gist`, `.Str` | t/03-client.t | `lib/Dusk/Rest/Client.rakumod` L26-27 — mascaramento do token |
| IMPL-10 | RF-01 | `Client` live HTTP | t/05-integration.t | `lib/Dusk/Rest/Client.rakumod` L46-91 — Cro::HTTP::Client com TLS |
| IMPL-11 | RF-03 | Gateway Core (`Connection`, `Heartbeat`, `Dispatcher`) | t/08, t/09, t/11 | `lib/Dusk/Gateway/*` — Implementação WebSocket Asgard-compliant (v0.2.1) |
| IMPL-12 | RF-04 | Gateway Events (`Dusk::Event::*`) | t/12-events.t | `lib/Dusk/Event.rakumod`, `lib/Dusk/Event/Events.rakumod` — (v0.2.4) |

## Nota
Este log foi criado retroativamente durante a remediação v0.1.1 (2026-02-24). O projeto original não manteve log de implementação por commit, violando CUEP §6.

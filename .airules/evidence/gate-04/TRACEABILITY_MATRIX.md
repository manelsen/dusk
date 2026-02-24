# Traceability Matrix

| Requirement | Risk | Contract | Exec Class | Responsibility | Test IDs | Impl Files | Runtime Signal | Evidence |
|---|---|---|---|---|---|---|---|---|
| RF-01 | RS-01 | `Client.request` | `effectful` | Executar requisição HTTP autenticada | t/03-client, t/04-rest-flow, t/05-integration | `lib/Dusk/Rest/Client.rakumod` | HTTP status / Rate Limit Backoff | evidence/gate-08 |
| RF-01 | RS-02 | `Endpoint.*` | `pure` | Montar rota REST (método + path) | t/02-endpoint (219 subtests) | `lib/Dusk/Rest/Endpoint.rakumod` | N/A (em memória) | evidence/gate-06 |
| RF-02 | RS-01 | `Endpoint.post-channels-messages` | `pure` | Serializar payload de mensagem | t/02-endpoint | `lib/Dusk/Rest/Endpoint.rakumod` | N/A | evidence/gate-06 |
| RF-03 | — | `Gateway::Client.connect` | `effectful` | WebSocket + Event Dispatch | — | — | — | **WAIVER v0.1.x → v0.2.x** |
| RNF-01 | RS-03 | `Client.request` (retry loop) | `effectful` | Respeitar Rate Limit 429 | t/06-rate-limit (3 subtests) | `lib/Dusk/Rest/Client.rakumod` L44-56, L69-82 | HTTP 429 + Retry-After header | evidence/gate-09 |
| RNF-02 | RS-04 | `Client.gist`, `Client.Str` | `pure` | Prevenir vazamento de token | t/03-client | `lib/Dusk/Rest/Client.rakumod` L26-27 | — | evidence/gate-09 |
| RNF-03 | RS-05 | `Client.request` | `effectful` | Overhead < 25ms | (medido em v0.2.0) | `lib/Dusk/Rest/Client.rakumod` | Request prep time | evidence/gate-09 |

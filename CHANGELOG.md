# Changelog

All notable changes to this project will be documented in this file.

## [0.3.0] — Valhalla - 2026-02-24

### Added
- `Dusk::Voice::Gateway` — Voice WebSocket handshake (OP 0→2→3→4→5→6), heartbeat, OP 1 SELECT_PROTOCOL
- `Dusk::Voice::UDP` — 74-byte IP Discovery packet, public IP/port parsing, encrypted RTP frame dispatch
- `Dusk::Voice::Audio` — PCM→frame pipeline via `ffmpeg` (`Proc::Async`), emits 20ms `Buf` frames as a `Supply`
- `Dusk::Voice::Crypto` — `xsalsa20_poly1305` frame encryption via NativeCall → `libsodium`; correct 12-byte RTP header
- `Dusk::Voice::Client` — Full facade replacing stub: `connect()`, `play(Str)`, `stop()`, `disconnect()`
- `Dusk::Error`: 4 new typed exceptions: `LibsodiumNotFound`, `FfmpegNotFound`, `VoiceUDPDiscoveryFailed`, `VoiceSessionTimeout`
- Tests: `t/14-voice-gateway.t` (6 TCs), `t/15-voice-udp.t` (5 TCs), `t/16-voice-audio.t` (5 TCs, ffmpeg-guarded), `t/17-voice-crypto.t` (6 TCs)
- All tests developed Fail-First per Asgard Protocol Gate 05

### Changed
- `Dusk::Voice::Client` stub replaced with full implementation
- `META6.json` description updated to reflect Voice support

### Requirements
- `libsodium` (`apt install libsodium-dev` or `brew install libsodium`) for voice encryption
- `ffmpeg` (`apt install ffmpeg`) for audio encoding

## [0.1.2] - 2026-02-24

### Added
- `Dusk::Error` module with typed exceptions: `Unauthorized`, `Forbidden`, `NotFound`, `APIError`, `RateLimit`
- `t/06-rate-limit.t` — tests for 429 retry behavior (retry, exhaustion, timing)
- `t/07-errors.t` — tests for typed exceptions on 401, 403, 404, 500
- Unified rate limit retry loop for both mock and Cro HTTP paths

### Changed
- `Client.request()` now throws typed exceptions instead of generic `die`
- `META6.json` updated with `Dusk::Error` in provides map and `source-url`

## [0.1.1] - 2026-02-24

### Added
- `IMPLEMENTATION_LOG.md` (retroactive) in `evidence/gate-06/`
- Formal RF-03 waiver with justification and date in `SPECS.md`

### Changed
- `TRACEABILITY_MATRIX.md` rebuilt with all 7 requirement rows (RF-01/02/03, RNF-01/02/03)
- `FUNCTION_ROLE_MATRIX.md` updated with all 12 current functions
- `ARCHITECTURE.md` and `CONTRACTS.md` moved Gateway to "Planned v0.2.x"
- Gates 04, 07, 11, 12 regressed to `hold` in `gate_status.md`

## [0.1.0] - 2026-02-24

### Added
- 219 REST API v10 endpoint methods in `Dusk::Rest::Endpoint`
- `Dusk::Rest::Client` with `Cro::HTTP::Client` and mock dispatcher
- `Dusk::Model::User`, `Channel`, `Message`, `Guild` value objects
- `Dusk::Rest::Route` immutable data carrier
- Rate limiting with HTTP 429 retry (up to 3 attempts)
- Token leak prevention (`.gist`, `.Str` masking)
- 19 JSON fixtures (9 gateway, 10 REST)
- 229 tests across 5 test files
- Full CUEP evidence pack (Gates 00-12)

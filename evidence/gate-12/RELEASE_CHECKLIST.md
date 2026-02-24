# RELEASE_CHECKLIST
## Dusk v0.1.0

- [x] META6.json name, version, and provides map are correct
- [x] All dependencies (`Cro::HTTP::Client`, `JSON::Fast`) installable via zef
- [x] 226 unit/endpoint tests pass (`prove6 -l t/`)
- [x] 3 integration tests pass with live Discord token
- [x] No hardcoded secrets in source code
- [x] Rate limiting with retry-after header handling implemented
- [x] Token never exposed in `.gist` or `.Str` output (RNF-02)
- [x] Observability signals documented
- [x] Incident runbook written
- [x] Functional-core / effectful-edge boundary preserved

## Decision

**RELEASE** — `Dusk:ver<0.1.0>` is approved for distribution.

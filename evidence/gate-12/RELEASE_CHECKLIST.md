# Release Checklist — v0.2.0

## Pre-Release Verification
- [x] All tests pass (233/233)
- [x] Traceability matrix complete — no orphan requirements
- [x] RF-03 formally waived with justification and owner
- [x] Performance benchmark: Avg 3.90ms (budget < 25ms) ✅
- [x] Rate limit tests: 3 subtests passing ✅
- [x] Error handling tests: 4 subtests (401, 403, 404, 500) ✅
- [x] Token leak prevention verified ✅
- [x] README.md, CHANGELOG.md, examples/ present
- [x] Consumer troubleshooting guide in RUNBOOK.md
- [x] Coverage/mutation waivers documented
- [x] Quick Failure Heuristics checked — no stop-ship triggers

## Release Decision
- **Decision**: RELEASE
- **Version**: 0.2.0
- **Date**: 2026-02-24
- **Owner**: @manelsen

## Rollback Plan
- `git revert HEAD` to return to v0.1.3 state
- `zef uninstall Dusk && zef install Dusk@0.1.3`

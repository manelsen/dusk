# Dispatcher CUEP

Use este arquivo como ponto de entrada do protocolo.

## Regras de execucao

1. O arquivo normativo e `template_codex.md`.
2. A execucao operacional e feita pelos arquivos em `gates/`.
3. O estado oficial e `gate_status.md`.
4. Sem evidencia em `evidence/gate-XX/`, o gate nao pode ser considerado PASS.
5. Nao pular gates. Nao mesclar gates.

## Mapeamento rapido

- Gate 00: `gates/00-project-profile.md`
- Gate 01: `gates/01-requirements-quality.md`
- Gate 02: `gates/02-risk-threat-failure.md`
- Gate 03: `gates/03-architecture-contracts.md`
- Gate 03A: `gates/03a-purity-srp.md`
- Gate 04: `gates/04-test-strategy-adequacy.md`
- Gate 05: `gates/05-fail-first-tests.md`
- Gate 06: `gates/06-implementation.md`
- Gate 07: `gates/07-test-adequacy-hardening.md`
- Gate 08: `gates/08-integration-parity.md`
- Gate 09: `gates/09-security-performance-resilience.md`
- Gate 10: `gates/10-operability.md`
- Gate 11: `gates/11-supply-chain-release.md`
- Gate 12: `gates/12-review-signoff.md`

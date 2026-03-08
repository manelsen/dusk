# ASGARD PROTOCOL - COMPLETE CONCATENATED VERSION
## Agentic Split Gate Architecture for Resilient Delivery

Complete concatenation of all protocol components with clear separations.

---

# FILE: .airules/README.md

Esta pasta contem a versao operacional do protocolo Asgard - Agentic Split Gate Architecture for Resilient Delivery com foco em aderencia.

Modelo de decisao: perfil base por tipo de projeto + modificadores de risco/contexto.

## Estrutura

- `template_codex.md`: norma central (fonte de verdade).
- `dispatcher.md`: como executar o protocolo no dia a dia.
- `gate_status.md`: estado oficial dos gates.
- `gates/*.md`: playbook pratico por gate.
- `evidence/`: evidencias por gate (`evidence/gate-XX/`).

## Fluxo recomendado

1. Leia `dispatcher.md`.
2. Atualize `gate_status.md` para `in_progress` no gate atual.
3. Execute o playbook do gate correspondente em `gates/`.
4. Salve evidencias em `evidence/gate-XX/`.
5. Marque o gate como `pass` ou `hold` em `gate_status.md`.
6. So avance para o proximo gate se o atual estiver `pass`.
7. Para projetos com modificadores selecionados, sem evidencias de modificador o gate nao fecha.

---

# FILE: .airules/dispatcher.md

# Dispatcher CUEP

Use este arquivo como ponto de entrada do protocolo.

## Regras de execucao

1. O arquivo normativo e `template_codex.md`.
2. A execucao operacional e feita pelos arquivos em `gates/`.
3. O estado oficial e `gate_status.md`.
4. Sem evidencia em `evidence/gate-XX/`, o gate nao pode ser considerado PASS.
5. Nao pular gates. Nao mesclar gates.
6. A arvore de decisao e composta: perfil base + `RISK_MODIFIERS`.
7. Modificadores selecionados sao obrigatorios em estrategia, testes e evidencias.

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

---

# FILE: .airules/gate_status.md

# Gate Status

Atualize este arquivo durante a execucao.

| Gate | Nome | Status | Data | Responsavel | Evidencia |
|---|---|---|---|---|---|
| 00 | Project Profile | pending | - | - | evidence/gate-00/ |
| 01 | Requirements and Quality Attributes | pending | - | - | evidence/gate-01/ |
| 02 | Risk, Threat, and Failure Modeling | pending | - | - | evidence/gate-02/ |
| 03 | Architecture and Contracts | pending | - | - | evidence/gate-03/ |
| 03A | Purity Boundary and SRP | pending | - | - | evidence/gate-03a/ |
| 04 | Test Strategy and Adequacy Plan | pending | - | - | evidence/gate-04/ |
| 05 | Tests Before Code (Fail-First) | pending | - | - | evidence/gate-05/ |
| 06 | Implementation | pending | - | - | evidence/gate-06/ |
| 07 | Test Adequacy Hardening | pending | - | - | evidence/gate-07/ |
| 08 | Integration and Environment Parity | pending | - | - | evidence/gate-08/ |
| 09 | Security, Performance, and Resilience | pending | - | - | evidence/gate-09/ |
| 10 | Operability Readiness | pending | - | - | evidence/gate-10/ |
| 11 | Supply Chain and Release Readiness | pending | - | - | evidence/gate-11/ |
| 12 | Independent Review and Sign-Off | pending | - | - | evidence/gate-12/ |

---

# FILE: .airules/template_codex.md

# CODEX UNIVERSAL ENGINEERING PROTOCOL (CUEP) v2.0

## META

- Purpose: gate-based protocol for building production-grade software across domains.
- Scope: libraries, SDKs, API wrappers, services, CLIs, frontends, data pipelines, ML systems, embedded/edge software.
- Normative rule: gates are sequential. Gate N+1 cannot start before Gate N is marked PASS with evidence.
- Language: all artifacts and gate logs must use one chosen language consistently.

## SECTION 0 - PROJECT PROFILE (MANDATORY)

Create `PROJECT_PROFILE.md` and define:

1. `PROJECT_NAME`
2. `PROJECT_TYPE` (library | service | cli | frontend | data-pipeline | ml-system | embedded)
3. `RISK_CLASS` (R0 cosmetic, R1 ux degradation, R2 data loss, R3 financial/legal harm, R4 safety/critical)
4. `LANG_STACK`
5. `DEPLOY_TARGET`
6. `COVERAGE_MIN` (default: R0-R1=80, R2=90, R3-R4=95)
7. `MUTATION_MIN` (default: R0-R1=20, R2=40, R3-R4=60)
8. `REVIEW_MODE` (self | cross | formal)
9. `SECURITY_LEVEL` (baseline | hardened | critical)
10. `PERF_BUDGET` (latency/throughput/memory/startup, as applicable)
11. `RELIABILITY_BUDGET` (SLO/error budget, if runtime system)
12. `COMPLIANCE_FLAGS` (if any regulatory constraints exist)
13. `ARCH_STYLE` (`functional-core/effectful-edge` by default)
14. `PURITY_TARGET` (minimum percent of business/domain functions that must be pure)
15. `SURFACE_PROFILE` (derived from `PROJECT_TYPE`, unless explicitly overridden)
16. `SURFACE_COVERAGE_MIN` (minimum percent of in-scope surface items with passing tests)
17. `RESOURCE_COVERAGE_MIN` (minimum percent of test resources linked to at least one test)
18. `RISK_MODIFIERS` (list; examples: `hard_real_time`, `cyber_physical`, `regulated_health_data`, `decision_support`, `multi_tenant`, `automated_actuation`, `offline_first`, `safety_critical`)
19. `MODIFIER_POLICY` (`strict` by default; selected modifiers are mandatory checks)
20. `MODIFIER_COVERAGE_MIN` (minimum percent of selected modifiers with fully satisfied required checks)

Gate check:

- `PROJECT_PROFILE.md` exists.
- All fields are present and non-empty.
- `ARCH_STYLE` and `PURITY_TARGET` are explicitly defined.
- `SURFACE_PROFILE`, `SURFACE_COVERAGE_MIN`, and `RESOURCE_COVERAGE_MIN` are explicitly defined.
- `RISK_MODIFIERS`, `MODIFIER_POLICY`, and `MODIFIER_COVERAGE_MIN` are explicitly defined.

## SECTION 1 - REQUIREMENTS AND QUALITY ATTRIBUTES

Create `SPECS.md` with:

1. Functional requirements (`RF-*`) with acceptance criteria.
2. Non-functional requirements (`RNF-*`) for security, performance, reliability, operability, portability, maintainability.
3. Domain constraints and explicit out-of-scope list.

Create `QUALITY_BUDGETS.md` with measurable targets derived from RNFs.

Gate check:

- Each `RF-*` has acceptance criteria.
- Each critical `RNF-*` maps to a measurable budget.
- Out-of-scope is explicit.

## SECTION 1A - COMPOSITE DECISION TREE (DOMAIN-NEUTRAL)

Decision layer 1: define the base project surface unit from `PROJECT_TYPE`:

- `library` / `sdk` -> public API member (function/class/method/type contract)
- `service` -> route/event/async contract
- `cli` -> command/flag/output contract
- `frontend` -> user flow/view state transition contract
- `data-pipeline` -> stage/input-output schema contract
- `ml-system` -> training/inference pipeline contract
- `embedded` -> protocol command/state transition contract

Create `SURFACE_INVENTORY.md` with one row per in-scope surface item:

- `surface_id`
- `surface_type`
- `contract_ref`
- `risk_ref`
- `priority` (critical/high/medium/low)
- `in_scope` (yes/no)

Decision layer 2: apply `RISK_MODIFIERS` on top of the base profile.

Create `MODIFIER_REQUIREMENTS.md` with one section per selected modifier:

- modifier id
- mandatory artifacts
- mandatory test classes
- mandatory gate checks
- waiver policy (if any)

Create `MODIFIER_PROFILE_MATRIX.md`:

- modifier id
- requirement refs
- risk refs
- evidence refs
- status (`planned`, `implemented`, `verified`)

Gate check:

- 100% of in-scope externally observable behavior is represented in `SURFACE_INVENTORY.md`.
- Every critical surface item is marked and linked to at least one `RF-*`.
- No duplicated `surface_id`.
- Every selected modifier has a corresponding entry in `MODIFIER_REQUIREMENTS.md`.
- No selected modifier is missing planned checks in `MODIFIER_PROFILE_MATRIX.md`.

## SECTION 2 - RISK, THREAT, AND FAILURE MODELING

Create `RISK_REGISTER.md` with:

- `RS-*`, impact, probability, detectability, mitigation, owner.

Create `FAILURE_MODES.md` with:

- Expected failure modes, detection signal, fallback behavior, recovery plan.

If internet-facing or sensitive data:

- Create `THREAT_MODEL.md` (entry points, trust boundaries, abuse cases, controls).

Gate check:

- Every high-impact risk has a concrete mitigation and a verification method.
- Every failure mode has detection + recovery.

## SECTION 3 - ARCHITECTURE AND CONTRACTS

Create `ARCHITECTURE.md` with runtime boundaries and dependency graph.

Create `CONTRACTS.md` per boundary:

- signature/schema
- preconditions
- postconditions
- idempotency/retry semantics (if relevant)
- timeout and error taxonomy
- backward-compatibility constraints

Create `INVARIANTS.md`:

- global invariants that must always hold.

Gate check:

- Every `RF-*` maps to at least one contract.
- Every contract links to at least one invariant or explicit "no invariant" rationale.

## SECTION 3A - PURITY BOUNDARY AND SINGLE RESPONSIBILITY

Create `BOUNDARY_MAP.md` with:

- pure core modules (domain rules, transformations, validation, decisions).
- effectful edge modules (network, db, filesystem, clock, randomness, process/env, UI, external APIs).
- allowed dependency direction: edge -> core. Core -> edge is forbidden.

Create `FUNCTION_ROLE_MATRIX.md` with one row per function:

- function path/id
- execution class (`pure` | `effectful`)
- single responsibility statement (one sentence)
- allowed side effects (`none` for pure functions)
- mapped requirement (`RF-*`)

Normative rules:

1. Pure functions must be deterministic and side-effect free.
2. Pure functions must not directly access network, filesystem, clock, randomness, environment variables, global mutable state, or process APIs.
3. Effectful functions are adapters/coordinators at the boundary only.
4. Each function must have one primary responsibility and one reason to change.
5. Functions that mix business decision logic and effect orchestration in the same body are not allowed in release scope.

Gate check:

- `BOUNDARY_MAP.md` and `FUNCTION_ROLE_MATRIX.md` exist.
- 100% of scoped functions are classified as `pure` or `effectful`.
- No purity leak from core modules to effectful dependencies.
- Every function has a single responsibility statement.

## SECTION 4 - TEST STRATEGY AND ADEQUACY PLAN

Create `TEST_STRATEGY.md` containing:

1. Test layers: unit, integration, contract, e2e, chaos/fault-injection (as applicable).
2. For each `RF-*`: minimum assertion depth, not only execution success.
3. Mock policy:
- mocks allowed only at explicit seams.
- production path cannot be replaced by mock for release gating.
4. Adequacy metrics:
- line/branch coverage target
- mutation score target
- contract test pass criteria
- flakiness budget
5. Purity and SRP policy:
- pure functions require deterministic input-output tests and property tests where applicable.
- effectful functions require seam contract tests plus integration tests against real or high-fidelity environments.
- tests must validate the declared single responsibility for each function.
6. Surface and resource coverage policy:
- create `SURFACE_TRACEABILITY.md` mapping each `surface_id` to tests.
- create `RESOURCE_TRACEABILITY.md` mapping each test resource (fixture/snapshot/seed/example dataset) to tests.
- require explicit rationale for any intentionally unused resource.
7. Modifier-driven adequacy policy:
- create `MODIFIER_COVERAGE_MATRIX.md` mapping selected modifiers to planned test suites and evidence artifacts.
- ensure each selected modifier has at least one verification path in test strategy.

Create `TRACEABILITY_MATRIX.md` with columns:

- Requirement
- Risk
- Contract
- Execution class (`pure` | `effectful`)
- Responsibility statement id/reference
- Test IDs
- Implementation files
- Runtime signal/metric
- Evidence artifact

Gate check:

- Matrix exists and has no orphan requirement.
- Mock policy is explicit and testable.
- Purity and single-responsibility checks are explicit and testable.
- `SURFACE_TRACEABILITY.md` has no orphan in-scope surface item.
- `RESOURCE_TRACEABILITY.md` has no orphan resource without rationale.
- `MODIFIER_COVERAGE_MATRIX.md` has no selected modifier without planned verification.

## SECTION 5 - TESTS BEFORE CODE (FAIL-FIRST)

Write tests according to strategy.

Mandatory rule:

- At gate entry, production code for new requirement must not satisfy tests yet.
- Initial execution must fail in expected locations.
- Pure-core tests must fail for logic gaps even when all edge adapters are mocked/stubbed.
- Baseline fail report must reference failing `surface_id` entries for scoped changes.
- Baseline fail report must reference selected modifiers impacted by scoped changes.

Create `BASELINE_FAIL_REPORT.md`:

- command used
- failing tests list
- reason class per failure

Gate check:

- New/changed requirement tests exist.
- Baseline fail report exists and is consistent.

## SECTION 6 - IMPLEMENTATION WITH TRACEABLE COMMITS

Implement contract-by-contract.

Rules:

1. Do not weaken tests to fit implementation.
2. Any contract change requires spec + test update in same change set.
3. No placeholder code in release path.
4. Keep business/domain decisions in pure functions.
5. Keep side effects in boundary adapters/coordinators; do not mix with core decisions.

Create `IMPLEMENTATION_LOG.md` with mapping:

- commit/ref -> requirement -> contract -> tests.

Gate check:

- All targeted tests pass.
- `TRACEABILITY_MATRIX.md` implementation column fully populated for scoped requirements.
- `FUNCTION_ROLE_MATRIX.md` is updated for all changed functions.

## SECTION 7 - TEST ADEQUACY HARDENING (ANTI FALSE-GREEN)

Run and record:

1. Coverage report.
2. Mutation testing report.
3. Contract test replay against real interfaces or high-fidelity simulators.
4. Flaky test detection run (multiple seeds/repeats).
5. Purity leak checks (static policy checks to ensure core modules do not call effectful APIs).
6. SRP checks (detect and split multi-responsibility functions in release scope).
7. Surface coverage computation from `SURFACE_TRACEABILITY.md`.
8. Resource coverage computation from `RESOURCE_TRACEABILITY.md`.
9. Modifier coverage computation from `MODIFIER_COVERAGE_MATRIX.md`.

Create `TEST_ADEQUACY_REPORT.md` with:

- coverage percent
- mutation score
- weak tests identified and fixed
- residual gaps with risk acceptance

Create `COVERAGE_SCORECARD.md` with:

- line/branch coverage
- mutation score
- surface coverage
- resource coverage
- modifier coverage
- critical surface coverage

Gate check:

- Coverage >= `COVERAGE_MIN`.
- Mutation score >= `MUTATION_MIN`.
- No unresolved weak-test finding at R2+.
- No unresolved purity leak in core modules.
- No unresolved multi-responsibility function in release scope.
- Surface coverage >= `SURFACE_COVERAGE_MIN`.
- Resource coverage >= `RESOURCE_COVERAGE_MIN`.
- No critical in-scope surface item without passing tests.
- Modifier coverage >= `MODIFIER_COVERAGE_MIN`.
- No selected modifier remains in `planned` status at release scope.

## SECTION 8 - INTEGRATION AND ENVIRONMENT PARITY

Create representative runtime environment for project type:

- library/sdk: clean consumer project install + minimal real usage scenario.
- service: ephemeral deploy with external dependencies.
- frontend: production build + browser/runtime smoke.
- cli: package install + execution on clean shell.
- data/ml: end-to-end run with representative dataset slice.
- embedded: hardware-in-loop or validated simulator.

Create `INTEGRATION_PARITY_REPORT.md` with:

- environment definition
- executed scenarios
- deviations from production
- risk of deviations

Gate check:

- At least one real-path smoke test passes in parity environment.
- Deviations are documented and accepted by risk owner.

## SECTION 9 - SECURITY, PERFORMANCE, AND RESILIENCE

Run analyses according to `SECURITY_LEVEL` and project type:

1. dependency vulnerability scan and license check
2. static analysis
3. secret leakage scan
4. performance benchmark against `PERF_BUDGET`
5. resilience tests (timeouts, retries, backpressure, restart/recovery, partial dependency failure)
6. execute modifier-specific controls from `MODIFIER_REQUIREMENTS.md` and record results

Create `QUALITY_REPORT.md` and `SECURITY_REPORT.md`.

Gate check:

- No critical unresolved finding for R2+.
- Performance and resilience budgets are met or explicitly waived with owner/date.

## SECTION 10 - OPERABILITY READINESS

Create:

- `OBSERVABILITY.md` (logs, metrics, traces, alert signals)
- `RUNBOOK.md` (known incidents, diagnosis, mitigation, rollback)
- `SLO.md` (for runtime systems)

For libraries/SDKs:

- include consumer troubleshooting guide and compatibility matrix.

Gate check:

- At least one failure scenario is detectable via defined signals.
- Runbook contains tested recovery steps.

## SECTION 11 - SUPPLY CHAIN AND RELEASE READINESS

Create/verify:

1. package metadata complete and accurate.
2. reproducible build instructions.
3. install-from-scratch test in clean environment.
4. signed artifact checksums (or equivalent provenance mechanism).
5. changelog and migration notes.
6. boundary verification that release artifacts preserve `functional-core/effectful-edge` layering.

Create `RELEASE_CANDIDATE_REPORT.md` with release verdict.

Gate check:

- Clean install succeeds.
- Artifact metadata points to existing files/modules.
- Provenance/checksum evidence present.
- Boundary verification passes.

## SECTION 12 - INDEPENDENT REVIEW AND SIGN-OFF

Review rules:

- R0-R1: self or cross
- R2-R3: cross mandatory
- R4: formal human sign-off mandatory

Create `REVIEW_LOG.md`:

- findings by severity
- decisions and rationale
- follow-up items

Create `RELEASE_CHECKLIST.md` final decision:

- RELEASE or HOLD
- blocking reasons
- rollback plan

Gate check:

- Review mode matches policy.
- All blockers closed or explicitly accepted by authorized owner.

## UNIVERSAL NON-NEGOTIABLE RULES

1. No silent gate skipping.
2. No release with placeholder code in production path.
3. No release without machine-verifiable evidence pack.
4. No orphan requirement, orphan test, or orphan risk.
5. Any artifact edit after PASS requires reopening affected gate.
6. Test suites must assert behavior, not only absence of exceptions.
7. Core business logic must remain pure.
8. Side effects are allowed only in boundary adapters/coordinators.
9. Every function must declare and keep exactly one primary responsibility.
10. No release with untested in-scope surface item.
11. No release with orphan test resource lacking rationale.
12. Selected modifiers are mandatory; they cannot be silently downgraded or skipped.

## EVIDENCE PACK STANDARD

Each gate must produce a folder under `evidence/gate-XX/` containing:

- executed commands
- raw outputs/logs
- summarized conclusions
- artifact checksums
- reviewer identity/date (if gate requires review)

Release is invalid if evidence pack is missing for any required gate.

## DOMAIN PROFILES (MINIMUM EXTRA CHECKS)

### library/sdk profile

- API compatibility tests across supported versions.
- consumer install test in clean project.
- docs examples executed as tests.

### service profile

- startup, health, readiness, graceful shutdown.
- dependency outage handling and retry/backoff validation.
- data migration rollback rehearsal.

### cli profile

- non-interactive and interactive modes tested.
- exit codes and stderr contracts validated.
- cross-platform shell compatibility where promised.

### frontend profile

- production bundle smoke in target browsers.
- accessibility baseline checks.
- error boundaries and offline/degraded behavior tests.

### data-pipeline/ml profile

- schema drift detection.
- deterministic replay for representative sample.
- model/feature lineage and rollback procedure.

### embedded profile

- hardware/simulator parity statement.
- watchdog/fail-safe behavior evidence.
- resource ceiling compliance (memory/cpu/power).

## MODIFIER CATALOG (CROSS-DOMAIN)

Use this baseline catalog; projects may add modifiers.

### `hard_real_time`

- required artifacts: `TIMING_BUDGET.md`, `WCET_REPORT.md`
- required checks: deadline miss rate, jitter bounds, worst-case execution time evidence

### `cyber_physical`

- required artifacts: `FAILSAFE_BEHAVIOR.md`
- required checks: safe-state transition on sensor/actuator failure, brownout/startup safety behavior

### `regulated_health_data`

- required artifacts: `PRIVACY_MODEL.md`, `AUDIT_TRAIL_SPEC.md`, `DATA_RETENTION_POLICY.md`
- required checks: access control tests, pii leakage checks, immutable audit trail verification

### `decision_support`

- required artifacts: `DECISION_TRACEABILITY.md`
- required checks: reproducibility of outputs from same inputs and versioned data/model references

### `multi_tenant`

- required artifacts: `ACCESS_CONTROL_MATRIX.md`, `TENANT_ISOLATION_SPEC.md`
- required checks: cross-tenant isolation tests and negative authorization tests

### `automated_actuation`

- required artifacts: `ACTUATION_GUARDRAILS.md`
- required checks: guardrail tests, rollback/abort behavior, fail-closed conditions

### `offline_first`

- required artifacts: `SYNC_CONFLICT_POLICY.md`
- required checks: disconnected operation and conflict resolution replay tests

## QUICK FAILURE HEURISTICS (STOP SHIP)

Hold release immediately if any is true:

1. Tests pass but key path is mock/stub in production code.
2. Coverage high but mutation score very low.
3. Traceability matrix has blanks in scoped requirements.
4. Install-from-scratch fails.
5. Review found unresolved high severity issue.
6. A core module imports/calls effectful APIs.
7. A release-scope function violates single responsibility.
8. Any critical in-scope surface item has no passing tests.
9. Surface/resource coverage is below configured minimum.
10. Any selected modifier has missing artifacts, missing checks, or failed verification.

## MINIMAL ARTIFACT REGISTRY

- `PROJECT_PROFILE.md`
- `SPECS.md`
- `QUALITY_BUDGETS.md`
- `SURFACE_INVENTORY.md`
- `MODIFIER_REQUIREMENTS.md`
- `MODIFIER_PROFILE_MATRIX.md`
- `RISK_REGISTER.md`
- `FAILURE_MODES.md`
- `THREAT_MODEL.md` (when applicable)
- `ARCHITECTURE.md`
- `CONTRACTS.md`
- `INVARIANTS.md`
- `BOUNDARY_MAP.md`
- `FUNCTION_ROLE_MATRIX.md`
- `TEST_STRATEGY.md`
- `TRACEABILITY_MATRIX.md`
- `SURFACE_TRACEABILITY.md`
- `RESOURCE_TRACEABILITY.md`
- `MODIFIER_COVERAGE_MATRIX.md`
- `BASELINE_FAIL_REPORT.md`
- `IMPLEMENTATION_LOG.md`
- `TEST_ADEQUACY_REPORT.md`
- `COVERAGE_SCORECARD.md`
- `INTEGRATION_PARITY_REPORT.md`
- `QUALITY_REPORT.md`
- `SECURITY_REPORT.md`
- `OBSERVABILITY.md`
- `RUNBOOK.md`
- `SLO.md` (runtime systems)
- `RELEASE_CANDIDATE_REPORT.md`
- `REVIEW_LOG.md`
- `RELEASE_CHECKLIST.md`
- `evidence/gate-XX/*`

---

# FILE: .airules/gates/00-project-profile.md

# Gate 00 - Project Profile

## Objetivo
Definir variaveis obrigatorias do projeto antes de qualquer outro gate.

## Entradas
- Decisoes de produto e risco.

## Saidas
- `PROJECT_PROFILE.md`

## Checklist
1. Definir `PROJECT_NAME`, `PROJECT_TYPE`, `RISK_CLASS`.
2. Definir `LANG_STACK`, `DEPLOY_TARGET`.
3. Definir `COVERAGE_MIN`, `MUTATION_MIN`, `REVIEW_MODE`.
4. Definir `SECURITY_LEVEL`, `PERF_BUDGET`, `RELIABILITY_BUDGET`, `COMPLIANCE_FLAGS`.
5. Definir `ARCH_STYLE` e `PURITY_TARGET`.
6. Definir `SURFACE_PROFILE`, `SURFACE_COVERAGE_MIN`, `RESOURCE_COVERAGE_MIN`.
7. Selecionar `RISK_MODIFIERS` e definir `MODIFIER_POLICY`.
8. Definir `MODIFIER_COVERAGE_MIN`.

## Criterio de saida
- PASS apenas se todos os campos estiverem preenchidos e validados.

---

# FILE: .airules/gates/01-requirements-quality.md

# Gate 01 - Requirements and Quality Attributes

## Objetivo
Especificar requisitos funcionais e nao funcionais com criterio mensuravel.

## Saidas
- `SPECS.md`
- `QUALITY_BUDGETS.md`
- `SURFACE_INVENTORY.md`
- `MODIFIER_REQUIREMENTS.md`
- `MODIFIER_PROFILE_MATRIX.md`

## Checklist
1. Registrar `RF-*` com criterio de aceitacao.
2. Registrar `RNF-*` (seguranca, performance, confiabilidade, operacao etc).
3. Declarar escopo e fora de escopo.
4. Mapear RNFs para orcamentos mensuraveis.
5. Definir a unidade de superficie por `PROJECT_TYPE` (API, comando CLI, fluxo UI, etc).
6. Inventariar 100% da superficie em escopo em `SURFACE_INVENTORY.md`.
7. Aplicar `RISK_MODIFIERS` e documentar requisitos adicionais por modificador.
8. Preencher `MODIFIER_PROFILE_MATRIX.md` com status inicial `planned`.

## Criterio de saida
- Sem RF sem criterio.
- Sem RNF critico sem metrica.
- Sem item de superficie critico fora do inventario.
- Sem modificador selecionado sem requisitos planejados.

---

# FILE: .airules/gates/02-risk-threat-failure.md

# Gate 02 - Risk, Threat, and Failure Modeling

## Objetivo
Modelar risco, falhas e ameacas relevantes ao dominio.

## Saidas
- `RISK_REGISTER.md`
- `FAILURE_MODES.md`
- `THREAT_MODEL.md` (quando aplicavel)

## Checklist
1. Registrar riscos `RS-*` com impacto, probabilidade, detectabilidade, mitigacao e dono.
2. Definir modos de falha com deteccao, fallback e recuperacao.
3. Em sistemas expostos/sensiveis, produzir threat model.
4. Derivar riscos especificos de cada modificador selecionado (`RISK_MODIFIERS`).
5. Garantir que cada modificador tenha mecanismo de deteccao e recuperacao associado.

## Criterio de saida
- Todo risco de alto impacto com mitigacao verificavel.
- Nenhum modificador selecionado sem risco e mitigacao mapeados.

---

# FILE: .airules/gates/03-architecture-contracts.md

# Gate 03 - Architecture and Contracts

## Objetivo
Fixar arquitetura e contratos antes da implementacao.

## Saidas
- `ARCHITECTURE.md`
- `CONTRACTS.md`
- `INVARIANTS.md`

## Checklist
1. Definir limites e fluxos entre componentes.
2. Documentar contratos com pre e pos-condicoes e erros.
3. Mapear RF para contratos.
4. Declarar invariantes de sistema.

## Criterio de saida
- Todo RF coberto por contrato.
- Invariantes claros para caminhos criticos.

---

# FILE: .airules/gates/03a-purity-srp.md

# Gate 03A - Purity Boundary and SRP

## Objetivo
Separar core puro das bordas com efeito e impor responsabilidade unica por funcao.

## Saidas
- `BOUNDARY_MAP.md`
- `FUNCTION_ROLE_MATRIX.md`

## Checklist
1. Classificar modulos em `pure-core` e `effectful-edge`.
2. Garantir dependencia apenas `edge -> core`.
3. Classificar 100% das funcoes como `pure` ou `effectful`.
4. Registrar uma unica responsabilidade por funcao.
5. Validar ausencia de efeito colateral nas funcoes puras.

## Criterio de saida
- Sem purity leak no core.
- Sem funcao escopo-release com mais de uma responsabilidade primaria.

---

# FILE: .airules/gates/04-test-strategy-adequacy.md

# Gate 04 - Test Strategy and Adequacy Plan

## Objetivo
Definir estrategia de teste que evite falso verde.

## Saidas
- `TEST_STRATEGY.md`
- `TRACEABILITY_MATRIX.md`
- `SURFACE_TRACEABILITY.md`
- `RESOURCE_TRACEABILITY.md`
- `MODIFIER_COVERAGE_MATRIX.md`

## Checklist
1. Definir camadas de teste (unit, integration, contract, e2e, fault).
2. Definir politica de mocks em seams explicitos.
3. Definir metas de cobertura, mutacao e flakiness.
4. Definir estrategia para pure functions e effectful adapters.
5. Preencher matriz de rastreabilidade.
6. Mapear superficie (`surface_id`) para testes em `SURFACE_TRACEABILITY.md`.
7. Mapear fixtures/recursos de teste para testes em `RESOURCE_TRACEABILITY.md`.
8. Mapear cada modificador para suites/evidencias de verificacao em `MODIFIER_COVERAGE_MATRIX.md`.

## Criterio de saida
- Sem requisito orfao.
- Regras de adequacao de teste verificaveis.
- Sem item de superficie em escopo sem plano de teste.
- Sem modificador selecionado sem plano de verificacao.

---

# FILE: .airules/gates/05-fail-first-tests.md

# Gate 05 - Tests Before Code (Fail-First)

## Objetivo
Escrever testes antes do codigo e comprovar falha inicial esperada.

## Saidas
- testes em `tests/`
- `BASELINE_FAIL_REPORT.md`

## Checklist
1. Cobrir cenarios felizes, erro e fronteira.
2. Rodar suite inicial e registrar falhas esperadas.
3. Garantir que testes de core puro falham por lacuna logica real.
4. Referenciar `surface_id` impactados no baseline fail report.
5. Referenciar modificadores impactados no baseline fail report.

## Criterio de saida
- Testes novos existem e falham no baseline pelos motivos corretos.

---

# FILE: .airules/gates/06-implementation.md

# Gate 06 - Implementation

## Objetivo
Implementar contratos sem enfraquecer testes.

## Saidas
- codigo de producao
- `IMPLEMENTATION_LOG.md`
- `FUNCTION_ROLE_MATRIX.md` atualizado

## Checklist
1. Implementar por contrato.
2. Manter logica de negocio em funcoes puras.
3. Manter efeitos apenas em adapters/coordenadores de borda.
4. Nao alterar teste para esconder bug.

## Criterio de saida
- Testes do escopo passam.
- Rastreabilidade implementacao <-> requisito completa.

---

# FILE: .airules/gates/07-test-adequacy-hardening.md

# Gate 07 - Test Adequacy Hardening

## Objetivo
Validar qualidade do teste alem de cobertura de linha.

## Saidas
- `TEST_ADEQUACY_REPORT.md`
- `COVERAGE_SCORECARD.md`

## Checklist
1. Gerar relatorio de cobertura.
2. Rodar mutation testing.
3. Rodar replay de contract tests em interfaces reais ou simulador de alta fidelidade.
4. Rodar deteccao de flaky tests.
5. Rodar checks de purity leak e violacao de SRP.
6. Calcular cobertura de superficie via `SURFACE_TRACEABILITY.md`.
7. Calcular cobertura de recursos via `RESOURCE_TRACEABILITY.md`.
8. Calcular cobertura de modificadores via `MODIFIER_COVERAGE_MATRIX.md`.

## Criterio de saida
- Cobertura e mutacao >= metas.
- Sem achados criticos abertos.
- Cobertura de superficie/recursos/modificadores >= metas do perfil.
- Sem item de superficie critico sem teste aprovado.

---

# FILE: .airules/gates/08-integration-parity.md

# Gate 08 - Integration and Environment Parity

## Objetivo
Provar que o caminho real funciona em ambiente representativo.

## Saidas
- `INTEGRATION_PARITY_REPORT.md`

## Checklist
1. Definir ambiente de paridade por tipo de projeto.
2. Rodar smoke de caminho real.
3. Registrar desvios versus producao e risco associado.
4. Para `embedded`, incluir evidencias HIL/simulador e comportamento fail-safe.
5. Para sistemas regulados (ex. `regulated_health_data`), incluir trilha de auditoria em cenarios de paridade.

## Criterio de saida
- Pelo menos um fluxo real passa em ambiente de paridade.
- Nenhum modificador selecionado fica sem evidencia de paridade.

---

# FILE: .airules/gates/09-security-performance-resilience.md

# Gate 09 - Security, Performance, and Resilience

## Objetivo
Validar seguranca, desempenho e resiliencia contra os budgets.

## Saidas
- `SECURITY_REPORT.md`
- `QUALITY_REPORT.md`

## Checklist
1. Scan de dependencias/licencas e segredos.
2. Static analysis/lint.
3. Benchmark contra `PERF_BUDGET`.
4. Testes de resiliencia (timeout, retry, degrado, recovery).
5. Executar controles especificos dos modificadores selecionados.
6. Registrar resultados por modificador em `SECURITY_REPORT.md`/`QUALITY_REPORT.md`.

## Criterio de saida
- Sem achado critico aberto em R2+.
- Budgets atendidos ou waiver formal.
- Sem modificador selecionado com controle obrigatorio pendente ou falho.

---

# FILE: .airules/gates/10-operability.md

# Gate 10 - Operability Readiness

## Objetivo
Garantir que o sistema e operavel e recuperavel.

## Saidas
- `OBSERVABILITY.md`
- `RUNBOOK.md`
- `SLO.md` (quando aplicavel)

## Checklist
1. Definir sinais operacionais (logs, metricas, traces).
2. Definir runbooks de incidentes e rollback.
3. Validar detectabilidade de falha critica.
4. Se houver `regulated_health_data` ou equivalente, validar trilha de auditoria imutavel.
5. Se houver `multi_tenant`, validar observabilidade por tenant sem vazamento de dados.

## Criterio de saida
- Falhas relevantes sao detectaveis e tem procedimento de resposta.
- Requisitos operacionais dos modificadores selecionados estao comprovados.

---

# FILE: .airules/gates/11-supply-chain-release.md

# Gate 11 - Supply Chain and Release Readiness

## Objetivo
Confirmar prontidao real de release e cadeia de suprimentos.

## Saidas
- `RELEASE_CANDIDATE_REPORT.md`

## Checklist
1. Validar metadata de pacote e referencias de artefato.
2. Rodar install-from-scratch em ambiente limpo.
3. Gerar checksums/provenance.
4. Verificar preservacao da camada `functional-core/effectful-edge`.
5. Verificar presenca dos artefatos obrigatorios por modificador selecionado.
6. Bloquear release se qualquer modificador estiver incompleto.

## Criterio de saida
- Instalacao limpa funciona e metadados apontam para artefatos reais.
- Nenhum modificador selecionado tem lacuna de artifact/check.

---

# FILE: .airules/gates/12-review-signoff.md

# Gate 12 - Independent Review and Sign-Off

## Objetivo
Formalizar revisao e decisao de release.

## Saidas
- `REVIEW_LOG.md`
- `RELEASE_CHECKLIST.md`

## Checklist
1. Executar review conforme `REVIEW_MODE` e `RISK_CLASS`.
2. Registrar achados por severidade e decisoes.
3. Fechar bloqueios ou registrar aceitacao formal com responsavel e data.
4. Emitir decisao final `RELEASE` ou `HOLD`.
5. Confirmar que nao ha bloqueio aberto ligado a `RISK_MODIFIERS` selecionados.

## Criterio de saida
- Sem bloqueio aberto nao aceito formalmente.

---

# FILE: .airules/examples/README.md

# Examples

Arquivos desta pasta sao apenas exemplos de partida para `PROJECT_PROFILE.md`.

- `PROJECT_PROFILE.example-arduino-traffic-light.md`
- `PROJECT_PROFILE.example-hospital-audit-dashboard.md`

Nao use valores literalmente sem calibrar para o contexto real do projeto.

---

# FILE: .airules/examples/PROJECT_PROFILE.example-arduino-traffic-light.md

# EXEMPLO - PROJECT_PROFILE (Arduino Traffic Light)

> Exemplo didatico. Ajuste para o seu contexto real antes de usar em producao.

1. `PROJECT_NAME`: arduino-traffic-light-demo
2. `PROJECT_TYPE`: embedded
3. `RISK_CLASS`: R4
4. `LANG_STACK`: C++17 + Arduino framework
5. `DEPLOY_TARGET`: ESP32/AVR microcontroller
6. `COVERAGE_MIN`: 95
7. `MUTATION_MIN`: 70
8. `REVIEW_MODE`: formal
9. `SECURITY_LEVEL`: hardened
10. `PERF_BUDGET`: control-loop tick <= 10 ms; jitter <= 2 ms
11. `RELIABILITY_BUDGET`: fail-safe transition <= 100 ms on fault
12. `COMPLIANCE_FLAGS`: local traffic control norms (placeholder)
13. `ARCH_STYLE`: functional-core/effectful-edge
14. `PURITY_TARGET`: 90
15. `SURFACE_PROFILE`: protocol command/state transition contract
16. `SURFACE_COVERAGE_MIN`: 100
17. `RESOURCE_COVERAGE_MIN`: 100
18. `RISK_MODIFIERS`: [hard_real_time, cyber_physical, safety_critical, automated_actuation, offline_first]
19. `MODIFIER_POLICY`: strict
20. `MODIFIER_COVERAGE_MIN`: 100

---

# FILE: .airules/examples/PROJECT_PROFILE.example-hospital-audit-dashboard.md

# EXEMPLO - PROJECT_PROFILE (Hospital Audit Dashboard)

> Exemplo didatico. Ajuste para o seu contexto real antes de usar em producao.

1. `PROJECT_NAME`: hospital-audit-dashboard-demo
2. `PROJECT_TYPE`: frontend
3. `RISK_CLASS`: R3
4. `LANG_STACK`: TypeScript (React + Node.js)
5. `DEPLOY_TARGET`: web (kubernetes + managed database)
6. `COVERAGE_MIN`: 95
7. `MUTATION_MIN`: 60
8. `REVIEW_MODE`: formal
9. `SECURITY_LEVEL`: critical
10. `PERF_BUDGET`: p95 page load <= 2s; p95 API query <= 500 ms
11. `RELIABILITY_BUDGET`: SLO 99.9%; RPO <= 15 min; RTO <= 60 min
12. `COMPLIANCE_FLAGS`: HIPAA/LGPD (placeholder)
13. `ARCH_STYLE`: functional-core/effectful-edge
14. `PURITY_TARGET`: 80
15. `SURFACE_PROFILE`: user-flow/view-state + route/event contract
16. `SURFACE_COVERAGE_MIN`: 95
17. `RESOURCE_COVERAGE_MIN`: 100
18. `RISK_MODIFIERS`: [regulated_health_data, decision_support, multi_tenant]
19. `MODIFIER_POLICY`: strict
20. `MODIFIER_COVERAGE_MIN`: 100

---

# END OF ASGARD PROTOCOL CONCATENATION

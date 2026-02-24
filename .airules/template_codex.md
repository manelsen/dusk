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

Gate check:

- `PROJECT_PROFILE.md` exists.
- All fields are present and non-empty.
- `ARCH_STYLE` and `PURITY_TARGET` are explicitly defined.

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

## SECTION 5 - TESTS BEFORE CODE (FAIL-FIRST)

Write tests according to strategy.

Mandatory rule:

- At gate entry, production code for new requirement must not satisfy tests yet.
- Initial execution must fail in expected locations.
- Pure-core tests must fail for logic gaps even when all edge adapters are mocked/stubbed.

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

Create `TEST_ADEQUACY_REPORT.md` with:

- coverage percent
- mutation score
- weak tests identified and fixed
- residual gaps with risk acceptance

Gate check:

- Coverage >= `COVERAGE_MIN`.
- Mutation score >= `MUTATION_MIN`.
- No unresolved weak-test finding at R2+.
- No unresolved purity leak in core modules.
- No unresolved multi-responsibility function in release scope.

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

## QUICK FAILURE HEURISTICS (STOP SHIP)

Hold release immediately if any is true:

1. Tests pass but key path is mock/stub in production code.
2. Coverage high but mutation score very low.
3. Traceability matrix has blanks in scoped requirements.
4. Install-from-scratch fails.
5. Review found unresolved high severity issue.
6. A core module imports/calls effectful APIs.
7. A release-scope function violates single responsibility.

## MINIMAL ARTIFACT REGISTRY

- `PROJECT_PROFILE.md`
- `SPECS.md`
- `QUALITY_BUDGETS.md`
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
- `BASELINE_FAIL_REPORT.md`
- `IMPLEMENTATION_LOG.md`
- `TEST_ADEQUACY_REPORT.md`
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

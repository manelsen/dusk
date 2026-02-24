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

## Criterio de saida
- PASS apenas se todos os campos estiverem preenchidos e validados.

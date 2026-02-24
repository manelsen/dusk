# Gate 07 - Test Adequacy Hardening

## Objetivo
Validar qualidade do teste alem de cobertura de linha.

## Saidas
- `TEST_ADEQUACY_REPORT.md`

## Checklist
1. Gerar relatorio de cobertura.
2. Rodar mutation testing.
3. Rodar replay de contract tests em interfaces reais ou simulador de alta fidelidade.
4. Rodar deteccao de flaky tests.
5. Rodar checks de purity leak e violacao de SRP.

## Criterio de saida
- Cobertura e mutacao >= metas.
- Sem achados criticos abertos.

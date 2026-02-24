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

## Criterio de saida
- Sem achado critico aberto em R2+.
- Budgets atendidos ou waiver formal.

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

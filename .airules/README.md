# .airules

Esta pasta contem a versao operacional do protocolo CUEP com foco em aderencia.

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

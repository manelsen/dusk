# Quality Budgets

- **Rate Limiting (RNF-01)**: 100% de respeito aos cabeçalhos `X-RateLimit-Reset` e `X-RateLimit-Remaining`. O cliente deve entrar em backoff/sleep transparente se o rate limit for atingido antes de tentar novamente (ou retornar um explícito erro se configurado para fail-fast).
- **Segurança (RNF-02)**: 0 ocorrências de `Token` literal em representações de string (`.gist`, `.perl`, ou `.Str` de objetos de configuração) para evitar vazamento em logs.
- **Performance (RNF-03)**: O tempo gasto na biblioteca para preparar uma requisição HTTP e desserializar a resposta JSON (< 100KB) deve ser inferior a 25ms de overhead de CPU no ambiente alvo.

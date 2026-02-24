# Failure Modes

| Modo de Falha | Sinal de Detecção | Comportamento de Fallback (Impacto Local) | Plano de Recuperação / Tratativa |
|---|---|---|---|
| **Downtime da API (5xx)** | Códigos HTTP 500, 502, 503, 504. | Lança uma exceção tipada `Dusk::APIError` encapsulando o `HTTPResponse`. | Se configurado pelo usuário, retry exponencial (desligado por padrão para evitar amplificação). |
| **Timeout de Rede** | Exceção do cliente HTTP Raku subjacente. | Capturar a exceção de rede e lançar uma `Dusk::NetworkError` unificada. | Retornar controle ao código consumidor para decisão de retry corporativo. |
| **Autenticação Inválida** | Código HTTP 401 Unauthorized. | Lança imediatamente `Dusk::AuthError`. Nenhuma tentativa subsequente deve ser feita pela mesma operação. | Corrigir token (intervenção manual do operador do bot). |
| **Erros de Validação (4xx)** | Código HTTP 400 Bad Request. | Lança `Dusk::ClientError` com a mensagem detalhada da resposta JSON do Discord. | Analisar payload de envio (intervenção do desenvolvedor). |

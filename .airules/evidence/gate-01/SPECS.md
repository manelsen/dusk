# Specifications (SPECS)

## Functional Requirements (RF)

- **`RF-01` [REST API Client]**: O pacote deve fornecer um cliente HTTP para interagir com a API REST do Discord (v10).
  - *Critério de aceitação*: O cliente consegue autenticar usando um token de bot e fazer requisições HTTP (GET, POST, PUT, PATCH, DELETE) para os endpoints base da API.
- **`RF-02` [Channel Messaging]**: O pacote deve permitir o envio de mensagens de texto para canais de texto do Discord.
  - *Critério de aceitação*: A função/metodo de envio de mensagem recebe um `channel_id` e o `content`, retornando o objeto da mensagem criada em caso de sucesso.
- **`RF-03` [Gateway Connection]**: O pacote deve conseguir estabelecer uma conexão WebSocket com o Discord Gateway.
  - *Critério de aceitação*: O cliente consegue conectar, enviar o payload de Identify e receber o evento `READY`.

## Non-Functional Requirements (RNF)

- **`RNF-01` [Rate Limiting Resiliency]**: O cliente deve embutir tratar respostas `429 Too Many Requests` e respeitar os cabeçalhos de rate limit da API.
- **`RNF-02` [Security]**: O token de autenticação fornecido não deve vazar em mensagens de log, exceções genéricas ou stdout.
- **`RNF-03` [Performance/Overhead]**: O tempo de overhead interno da biblioteca não deve estripar a utilidade em bots responsivos.

## Escopo e Fora de Escopo

- **No Escopo**:
  - Encapsulamento de chamadas REST (Users, Channels, Guilds básicos).
  - Conexão e manutenção de heartbeat com o Gateway (WebSocket).
  - Deserialização de eventos JSON para objetos Raku.
- **Fora de Escopo**:
  - Sharding automático e Voice Streaming de baixo nível (pois requerem fluxos complexos fora do REST estrito e Gateway base, que poderão ser separados estruturalmente depois). Embora todas as requisições REST da Discord API v10 sejam cobertas, as partes de processamento de áudio ao vivo ficam para componentes futuros.

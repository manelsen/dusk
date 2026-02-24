# Specifications (SPECS)

## Functional Requirements (RF)

- **`RF-01` [REST API Client]**: O pacote deve fornecer um cliente HTTP para interagir com a API REST do Discord (v10).
  - *Critério de aceitação*: O cliente consegue autenticar usando um token de bot e fazer requisições HTTP (GET, POST, PUT, PATCH, DELETE) para os endpoints base da API.
- **`RF-02` [Channel Messaging]**: O pacote deve permitir o envio de mensagens de texto para canais de texto do Discord.
  - *Critério de aceitação*: A função/metodo de envio de mensagem recebe um `channel_id` e o `content`, retornando o objeto da mensagem criada em caso de sucesso.
- **`RF-03` [Gateway Connection]**: ~~O pacote deve conseguir estabelecer uma conexão WebSocket com o Discord Gateway.~~
  - *Critério de aceitação*: ~~O cliente consegue conectar, enviar o payload de Identify e receber o evento `READY`.~~
  - **⚠️ WAIVER (2026-02-24)**: Requisito formalmente de-scoped de v0.1.x. Justificativa: o Gateway WebSocket exige um ciclo de design e implementação autônomo (heartbeat, reconnect, event dispatch, intents) incompatível com o escopo REST-only do MVP. Será tratado como RF-03 no ciclo CUEP do v0.2.x. Responsável: @manelsen.

## Non-Functional Requirements (RNF)

- **`RNF-01` [Rate Limiting Resiliency]**: O cliente deve embutir tratar respostas `429 Too Many Requests` e respeitar os cabeçalhos de rate limit da API.
- **`RNF-02` [Security]**: O token de autenticação fornecido não deve vazar em mensagens de log, exceções genéricas ou stdout.
- **`RNF-03` [Performance/Overhead]**: O tempo de overhead interno da biblioteca não deve estripar a utilidade em bots responsivos.

## Escopo e Fora de Escopo

- **No Escopo (v0.1.x)**:
  - Encapsulamento de chamadas REST (Users, Channels, Guilds básicos).
  - Deserialização de respostas JSON REST para objetos Raku.
  - Rate limiting com retry automático.
- **Fora de Escopo (v0.1.x → planejado para v0.2.x)**:
  - Conexão e manutenção de heartbeat com o Gateway (WebSocket). → RF-03 waiver.
  - Sharding automático e Voice Streaming de baixo nível.
  - Interaction builders e UI Components.

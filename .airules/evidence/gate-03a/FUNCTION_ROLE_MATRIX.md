# Function Role Matrix

| Function Path/ID | Execution Class | Single Responsibility Statement | Allowed Side Effects | Mapped Requirement |
|---|---|---|---|---|
| `Dusk::Rest::Endpoint.create-message` | `pure` | Formatar a URL e o corpo JSON para a rota de criação de mensagem. | `none` | RF-02 |
| `Dusk::Rest::Endpoint.get-channel` | `pure` | Formatar a URL para busca de um channel. | `none` | RF-01 |
| `Dusk::Rest::Client.request` | `effectful` | Enviar a requisição formatada via HTTP, aguardando resposta da rede e gerindo backoff de rate limit. | `network`, `clock` | RF-01, RF-02 |
| `Dusk::Model::Message.new` | `pure` | Validar e armazenar dados recebidos correspondentes a uma Mensagem do Discord. | `none` | RF-02 |

# Function Role Matrix

| Function Path | Exec Class | Single Responsibility | Side Effects | Mapped Req |
|---|---|---|---|---|
| `Dusk::Model::User.new` | `pure` | Deserializar JSON de User para objeto tipado | `none` | RF-01 |
| `Dusk::Model::Message.new` | `pure` | Deserializar JSON de Message com nested User | `none` | RF-01 |
| `Dusk::Model::Channel.new` | `pure` | Deserializar JSON de Channel para objeto tipado | `none` | RF-01 |
| `Dusk::Model::Guild.new` | `pure` | Deserializar JSON de Guild para objeto tipado | `none` | RF-01 |
| `Dusk::Rest::Route.new` | `pure` | Encapsular método HTTP + path + body opcional | `none` | RF-01 |
| `Dusk::Rest::Route.has-body` | `pure` | Verificar presença de body no payload | `none` | RF-01 |
| `Dusk::Rest::Endpoint.*` (219 métodos) | `pure` | Construir Route para endpoint Discord específico | `none` | RF-01, RF-02 |
| `Dusk::Rest::Client.new` | `effectful` | Instanciar cliente com token e API version | `state init` | RF-01 |
| `Dusk::Rest::Client.request` | `effectful` | Executar requisição HTTP e parsear resposta | `network I/O, sleep (rate limit)` | RF-01, RNF-01 |
| `Dusk::Rest::Client.gist` | `pure` | Representação segura sem token | `none` | RNF-02 |
| `Dusk::Rest::Client.Str` | `pure` | Representação segura sem token | `none` | RNF-02 |
| `Dusk::Rest::Client.set-mock-dispatcher` | `effectful` | Injetar mock para testes | `state mutation` | — (teste) |

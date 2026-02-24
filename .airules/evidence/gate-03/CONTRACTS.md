# Contracts

## `Dusk::Rest::Client.request(route: Dusk::Rest::Route)`
- **Mapeamento de Requisito**: `RF-01`, `RF-02`
- **Assinatura**: Recebe um objeto `Route` puro, devolve um `Promise` que resolve num `Dusk::Model` ou Hash de dados.
- **Pré-condições**: 
  - O cliente deve ter sido instanciado com um Token não nulo.
  - O `Route` deve conter uma URL e verbo HTTP válidos.
- **Pós-condições**:
  - Em caso de HTTP 2xx, o corpo JSON foi parseado e os dados retornados no formato nativo.
  - Em caso de Rate Limit (HTTP 429), se configurado para `retry`, o Promise bloqueia/aguarda o tempo de reset e repete; senão, falha com exceção `RateLimitError`.
  - Em caso de erro do servidor (HTTP 5xx), lança `APIError`.
- **Idempotência e Retry**:
  - Requisições `GET` são seguras e podem ser opcionalmente retentadas sem side-effects no servidor.
  - Requisições `POST/PATCH/DELETE` assumem comportamento não idempotente por padrão e não são retentadas em caso de erro de rede (evitar mensagens duplicadas), a menos que explicitamente ordenado pelo construtor da rota.

## `Dusk::Gateway::Client.connect()` — ⚠️ PLANEJADO v0.2.x
- **Mapeamento de Requisito**: `RF-03` (waiver em v0.1.x, ver SPECS.md)
- **Pré-condições**: Conexão de rede ativa.
- **Pós-condições**: O loop de eventos é iniciado e o Consumer começa a receber objetos `Dusk::Event::*` purificados. Opcionalmente reconecta automaticamente caso o websocket caia e falhe de forma transiente.
- **Status**: Não implementado. Planejado para ciclo CUEP v0.2.x.

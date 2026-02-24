# Traceability Matrix

| Requirement | Risk | Contract | Execution class | Responsibility | Test IDs | Impl Files | Runtime Signal | Evidence |
|---|---|---|---|---|---|---|---|---|
| RF-01 | RS-01 | `Client.request` | `effectful` | Executar rede | T-01, T-02 | `lib/Dusk/Rest/Client.rakumod` | Sucesso HTTP / Rate Limit Backoff | A ser preenchido (G05-06) |
| RF-01 | RS-02 | `Endpoint.build` | `pure` | Montar rota REST | T-03 | `lib/Dusk/Rest/Endpoint.rakumod` | N/A (Em Memória) | A ser preenchido |
| RF-02 | RS-01 | `Endpoint.create_msg` | `pure` | Serializar Payload da Msg | T-04 | `lib/Dusk/Rest/Endpoint.rakumod` | N/A (Em Memória) | A ser preenchido |

# Baseline Fail-First Report (v2 - Full API Coverage)

## Comando Utilizado
`/home/micelio/.raku/bin/prove6 -l t/`

## Resumo da Geração e Falha
Com base na exigência de **cobertura total dos endpoints da API v10 do Discord**, foram mapeadas **219 rotas REST**. 
A suíte de testes `t/02-endpoint.t` foi recriada para afirmar as 219 rotas através de chamadas estritas aos métodos (ex: `delete-applications-commands()`).

**Resultado da execução**: The Fail-First policy holds true.
As 219 asserções sobre os endpoints falharam com erro formal de compilação/invocação em tempo de execução:

```
No such method 'delete-applications-commands' for invocant of type 'Dusk::Rest::Endpoint'
```

- **`t/01-models.t`**: FAILED. (Classes puras de modelos faltantes ou parciais para as fixtures expandidas)
- **`t/02-endpoint.t`**: FAILED. 219 testes falharam por inexistência de métodos geradores de rota.
- **`t/03-client.t`**: FAILED/OK. Mocks de inicialização passam, falhas esperadas se base de dependência cair.
- **`t/04-rest-flow.t`**: FAILED. Injeção de dependência na Edge Falhou pelo não-mapeamento do fluxo com os endpoints novos.

**Conclusão**: O Gate 05 foi iterado para cobrir todas as 219 rotas de forma TDD pura. Os testes existem e falham corretamente acusando déficit de implementação. O ambiente está seguro para prosseguir para o Gate 06.
Consulte o arquivo `ENDPOINTS_COVERAGE.md` na raiz do projeto para visualizar o mapa exato.

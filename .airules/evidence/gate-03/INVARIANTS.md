# Invariants

1. **Isolamento de Token**: O objeto cliente HTTP rest (`Dusk::Rest::Client`) nunca modifica, expõe ou loga seu token de autorização injetado no construtor.
2. **Pureza do Core**: Nenhum método dentro do namespace `Dusk::Model::*` ou `Dusk::Rest::Route::*` pode instanciar conexões de rede, abrir arquivos estruturais do disco ou depender do relógio do sistema para lógica de ramificação (desempenho exceção métricas). Toda injeção de estado acontece via parâmetros.
3. **Conversão Previsível**: A falha na desserialização de um corpo JSON da API sempre resulta numa exceção estruturada `Dusk::ParseError` capturável, e nunca numa exceção genérica da engine Raku (como `X::TypeCheck`).

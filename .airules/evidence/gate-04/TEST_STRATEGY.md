# Test Strategy

## Camadas de Teste
1. **Testes Unitários (Core Puro)**: Focados em `Dusk::Rest::Endpoint` e modelos em `Dusk::Model::*`. Validam determinismo, construindo saídas conhecidas a partir de entradas locais. Sem interações de I/O reais.
2. **Testes de Mocks (Edge)**: O `Dusk::Rest::Client` será testado usando um agente `FakeUserAgent` intercetando chamadas do Cro ou LWP para assegurar que os headers (ex. tokens) estão sendo corretamente adicionados sem tocar na rede.
3. **Testes End-to-End (Smoke)**: [Opcional/Condicional em CI restrito] Teste live com Token isolado de sandbox para validar mudança na Cloud do Discord.

## Regras de Mock
- **Proibido no Core**: Nenhuma classe de Core pode depender de mocks, elas são inerentemente puras.
- **Isolamento de Edge**: Mocks apenas para substituir a chamada da subrotina nativa de rede do Raku. O caminho principal jamais deve depender de mock para cobertura vazia.

## Métricas de Adequação
- **Coverage Alvo**: >= 80% (Requisito de Gate 00).
- **Flakiness**: 0 tolerance. Se houver variação no teste unitário, o código deve ser reescrito puro.

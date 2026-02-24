# Boundary Map

## Pure Core (Módulos Puros)
- **`Dusk::Model::*`**: Classes/Roles de representação de dados (estruturas de mensagem, channel, etc). Nenhuma lógica de negócio com side-effects.
- **`Dusk::Rest::Endpoint`**: Construtor e formatador de requisições. Recebe os dados brutos e formata a URI resultante e o payload JSON.

## Effectful Edge (Bordas com Efeito)
- **`Dusk::Rest::Client`**: Cliente HTTP que aplica `Dusk::Rest::Endpoint` à rede.

## Direção de Dependência Permitida
`Dusk::Rest::Client` (Edge) depende de `Dusk::Rest::Endpoint` e `Dusk::Model` (Core).
**A direção oposta é estritamente proibida.** Nenhuma classe do Core pode importar instâncias ou chamar métodos do Edge que executem I/O.

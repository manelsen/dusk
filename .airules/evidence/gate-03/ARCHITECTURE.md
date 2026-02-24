# Architecture

## Estilo Arquitetural
**Functional Core / Effectful Edge**

## Componentes Principais

### Core (Puro)
- **`Dusk::Model::*`**: Objetos (classes/roles) de domínio imutáveis que representam entidades do Discord (ex: `Message`, `User`, `Channel`).
- **`Dusk::Rest::Route`**: Construtor puro de URLs e payloads. Recebe parâmetros de entrada e retorna a estrutura da requisição HTTP (verbo, URL relativa, corpo codificado). Nenhuma I/O ocorre aqui.

### Edge (Com Efeitos)
- **`Dusk::Rest::Client`**: Cliente HTTP. Recebe definições geradas em `Dusk::Rest::Route` e as executa contra a API real do Discord. Trata cabeçalhos, TLS e converte as respostas JSON novamente em dados puros para o Core. Mantém estado de Rate Limit temporário.
- **`Dusk::Gateway::Client`**: Gerenciador da conexão WebSocket (Event loop). Recebe e despacha eventos. (Marcado como expansão futura no escopo MVP, mas presente no design).

## Diagrama de Dependência
```
(User Code) ---> Dusk::Rest::Client (Edge) ---> Cro::HTTP::Client / Rede
                         |
                         V
                 Dusk::Rest::Route (Core) 
                         |
                         V
                  Dusk::Model (Core)
```

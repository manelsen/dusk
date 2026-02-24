# Threat Model

Este é um Threat Model simplificado, considerando que a biblioteca roda como um cliente confiável conectando-se a uma API de terceiros (modelo Cliente-Servidor).

## Fronteiras de Confiança
1. **Ambiente Local (Confiável)**: O script Raku executando o bot, contendo memória, variáveis de ambiente e arquivos locais.
2. **Rede Externa (Não-Confiável)**: O meio de transporte entre o bot e os servidores do Discord.
3. **Servidores do Discord (Confiável-Restrito)**: A API oficial. Pode enviar conteúdos maliciosos originários de usuários, exigindo sanitização se renderizados, mas estruturalmente o JSON é confiável.

## Casos de Abuso e Ameaças
| Ameaça | Vetor | Controle de Segurança |
|---|---|---|
| **Interceptação de Tráfego (MITM)** | Leitura de pacotes na rede vazando tokens ou dados sensíveis. | O cliente **deve forçar TLS** (HTTPS nativamente ou `wss://` para websockets) em todas as requisições. URLs com `http://` puro devem ser rejeitadas silenciosamente na construção do client. |
| **Exploração de Payload JSON** | Resposta do Discord (oriunda de usuário manipulador) cria negação de serviço ao ser parseada. | Usar biblioteca de parse JSON robusta e evitar interpolação insegura ou uso de `EVAL` durante parsing de respostas. |

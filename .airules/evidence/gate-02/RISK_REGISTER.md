# Risk Register

| ID | Descrição | Impacto | Probabilidade | Detectabilidade | Mitigação | Dono |
|---|---|---|---|---|---|---|
| **RS-01** | Quebra de contrato por mudanças na API REST do Discord | Alto | Média | Alta | Fixar a versão da API (v10) na URL base e manter testes de contrato atualizados. | Mantenedor |
| **RS-02** | Bloqueio de conta/bot por violação de Rate Limit acidental | Alto | Baixa | Alta | Implementar backoff automático e parsing rigoroso dos headers `X-RateLimit-*`. O cliente deve aguardar ativamente o `Reset` antes da próxima requisição. | Mantenedor |
| **RS-03** | Vazamento do Bot Token em logs ou stacktraces | Crítico | Baixa | Alta | Sanitizar representações de string (`.gist`, `.perl`) da classe de configuração e capturar exceções HTTP subjacentes para mascarar cabeçalhos de auth. | Mantenedor |

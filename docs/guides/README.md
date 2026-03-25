# Guias Técnicos - Patagang Ecommerce

Índice de documentação técnica e guias de operação para o projeto Patagang.

---

## 📚 Guias Disponíveis

### Story 8.5 - Cart Drawer Recovery
**Status:** ✅ Completo
**Versão:** v1.5.93 (Restaurado para v1.5.72)

#### Documentos
- **[8.5-CART-RECOVERY-FINAL-REPORT.md](./8.5-CART-RECOVERY-FINAL-REPORT.md)**
  - Relatório completo da recuperação da sacola
  - Análise de root cause dos problemas
  - Lições aprendidas e recomendações futuras
  - Leitura obrigatória antes de refatorar

---

## 🔍 Navegação Rápida

| Assunto | Arquivo | Descrição |
|---------|---------|-----------|
| Story 8.5 Recovery | [8.5-CART-RECOVERY-FINAL-REPORT.md](./8.5-CART-RECOVERY-FINAL-REPORT.md) | Análise completa, root causes, lições aprendidas |

---

## 📋 Próximos Passos

### Phase 1: Refatoração de CSS (SEGURO)
- Otimizar `static/css/style-async.scss.tpl`
- Sem mudanças em HTML/JS
- Teste em produção a cada mudança

### Phase 2: Refatoração de HTML (SEGURO)
- Melhorar estrutura `snipplets/cart-modal.tpl`
- Sem mudanças em JS
- Teste em produção a cada mudança

### Phase 3: Refatoração de JavaScript (COM CUIDADO)
- Revisar `static/js/cart-drawer.js.tpl`
- Implementar testes unitários PRIMEIRO
- Validar em staging ANTES de produção

### Phase 4: Modularização (APENAS SE NECESSÁRIO)
- Dividir em múltiplos arquivos com segurança
- Testes completos
- Validação em staging
- Deploy progressivo

---

## ⚠️ Lições Críticas

### ❌ O Que NÃO Fazer
1. Não modularize sem testes automatizados
2. Não ignore erros de sintaxe Twig
3. Não remova includes críticos sem verificação
4. Não misture duas arquiteturas simultaneamente

### ✅ O Que Fazer
1. Mantenha commits atômicos
2. Valide em produção imediatamente
3. Rollback completo se algo quebrar
4. Documente antes de refatorar

---

## 📞 Contato

**Mantido por:** Orion (AIOX Master)
**Última atualização:** 25 de Março de 2026
**Status:** ✅ Ativo

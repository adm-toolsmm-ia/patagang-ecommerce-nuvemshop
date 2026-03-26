# Validation Issues Found — Backlog para Stories Futuras

**Date:** 2026-03-24
**Sprint:** Epic 8 — Validação em Produção
**Status:** ⏳ **BACKLOG** (Planejado para próximas stories)

---

## 📋 Visão Geral

Documento que consolida **issues encontradas durante validação em produção** (Gabriel testando v1.5.73 em https://patagang.com.br/) para planejamento de stories futuras de ajustes e refinamento.

**Objetivo:** Capturar feedback de UX real do usuário (Gabriel como CTO validando em produção) para melhorias iterativas.

---

## 🔴 Issue #1: Componentes Extras Visíveis ao Adicionar Produto

**Severidade:** 🟡 **MEDIUM** (UX confusing, não bloqueia funcionalidade)
**Localização:** Página de Produto (PDP) - Product Information Card
**Encontrado em:** v1.5.73 validation
**Reportado por:** Gabriel Cristofolini (CTO)

---

### Descrição do Problema

Ao clicar no botão "Adicionar" do card com informações de produto, aparecem botões extras que **não deveriam estar visíveis**:

```
Botões que aparecem:
- "Comprar"
- "Adicionando" (status/loading state)

Comportamento esperado:
- Apenas 1 botão principal "Adicionar"
- Sem componentes extras visíveis

Comportamento atual:
- Clicar em "Adicionar"
- Aparecem múltiplos botões (confuso)
- Parece haver mais componentes que o necessário
```

---

### Impacto na UX

**Problem Statement:**
- ❌ Confunde o usuário (múltiplos botões simultâneos)
- ❌ Interface fica "bagunçada" visualmente
- ❌ Não é claro qual botão clicar
- ❌ Possível duplicação de código/componentes

**Expected State:**
- ✅ 1 botão claro "Adicionar"
- ✅ Ao clicar: status loading inline (sem novo botão)
- ✅ Após sucesso: confirmação discreta

---

### Root Cause Analysis (Especulação para Investigation)

**Possíveis causas:**
1. Múltiplos handlers no botão "Adicionar"
2. Componentes sobrepostos com z-index conflitante
3. CSS não ocultando elementos `.hidden` ou `[style="display:none"]`
4. JavaScript renderizando botões extras sem remover anteriores
5. Duplicação de snipplets no template

**Investigação necessária:**
- Ler `product-form.tpl` (se existe)
- Verificar `add-to-cart.js` ou similar
- Auditar CSS de product card buttons
- Verificar se há múltiplas versões do componente

---

### Reproduction Steps

```
1. Acesse: https://patagang.com.br/[qualquer-produto]
2. Scroll até "Card com Informações do Produto"
3. Localize botão "Adicionar"
4. Clique em "Adicionar"
5. Observe: Aparecem botões extras ("Comprar", "Adicionando")
6. Expected: Apenas 1 botão com status inline
```

---

### Checklist para Story Futura

- [ ] Investigar estrutura de product information card
- [ ] Ler templates de produto (product-form.tpl, add-to-cart, etc.)
- [ ] Auditar JavaScript de adicionar ao carrinho
- [ ] Validar CSS de visibilidade (display: none, visibility: hidden)
- [ ] Verificar se há componentes duplicados
- [ ] Refatorar para usar 1 button + inline status
- [ ] Testar em produção após fix
- [ ] Documentar padrão para botões de "adicionar"

---

## 📊 Padrão a Documentar

### Anti-Pattern (Atual - não ideal):
```
Button "Adicionar"
  → OnClick
  → Render "Comprar" button
  → Render "Adicionando" status button
  → User confused (multiple buttons visible)
```

### Best Pattern (Recomendado):
```
Button "Adicionar"
  → OnClick
  → Disable button
  → Add loading state (spinner inline)
  → Remove disabled state when done
  → User clear (1 button with status)
```

---

## 🔗 Referências

**Relacionado a:**
- Story 8.4 (Sacola + Cupom) - Mesma validação em produção
- Possível refactoring de componentes de adicionar

**Documentação Existente:**
- `.claude/rules/nuvemshop-ftp-constraints.md` (checkout form constraints)
- `docs/stories/8.4-*.md` (padrão de UI feedback)

---

## 📌 Próximos Passos

### Imediato
- ⏳ Aguardar aprovação Gabriel de v1.5.73 (sacola + cupom)
- ⏳ Proceder com Brownfield Discovery
- ⏳ Documento permanece em BACKLOG

### Story Futura (Epic 8.6 ou similar)
```
Story: 8.X - Refactor Product Add-to-Cart Button

Description:
- Consolidar múltiplos componentes de botão
- Implementar padrão único de "Adicionar"
- Usar loading state inline (sem novo button)
- Validar em produção

AC:
- [ ] 1 button principal "Adicionar"
- [ ] Loading state inline quando clicado
- [ ] Sem botões extras visíveis
- [ ] Responsivo (mobile/tablet/desktop)
- [ ] Testado em produção

Time estimate: 2-3 days
```

---

## 📞 Atribuição

**Reporter:** Gabriel Cristofolini (CTO)
**Found During:** v1.5.73 Production Validation
**Date Found:** 2026-03-24
**Priority:** Medium (UX improvement, not blocking)

---

**Status:** ⏳ BACKLOG (Aguardando refinement em próxima sprint)
**Document Created:** 2026-03-24 04:00 UTC


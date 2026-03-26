# EPIC 9 — Refinamento UX/UI Mobile & Validações Pós-EPIC 8

**Status:** Planning
**Created:** 2026-03-27
**Priority:** High
**Type:** User Experience / Mobile Optimization
**Risk Level:** Medium

---

## 📋 Epic Overview

**EPIC 8** completou refatoração técnica massiva (CSS tokens, CSS reduction, !important removal, templates cleanup, JS optimization). Entretanto, durante validação em produção, Gabriel identificou **3 problemas UX/UI mobile** que requerem refinamento:

Esta EPIC consolida essas descobertas e planeja as correções necessárias.

---

## 🎯 Objectivos

1. **Refinar UX/UI Mobile** — Resolver compactação de cards em mobile
2. **Validação Completa** — Testes rigorosos em todos breakpoints
3. **Documentar Padrões** — Cristalizar aprendizados de EPIC 8
4. **Consolidar Knowlegde** — Criar guidelines para futuras refatorações

---

## 📊 Problemas Identificados (EPIC 8)

### Problema 1: Product Card Compactado em Mobile

**Localização:** `/produto/` (PDP — Product Details Page)
**Componente:** `.pg-pdp-info-card`
**Sintoma:** Card ocupa apenas ~50% da largura em mobile (limitado como se houvesse coluna invisível)
**Tentativas de Fix:** 3 (v1.5.123, v1.5.124, v1.5.125) — nenhuma bem-sucedida

**Histórico de Tentativas:**
```
v1.5.123: Fix seletor .pg-product-grid → .pg-product-grid (inválido)
v1.5.124: Reset align-items + justify-content em media query
v1.5.125: Adicionar flex-direction: column em media query
Resultado: Nenhuma resolveu completamente
```

**Investigação Necessária:**
- Chrome DevTools analysis em mobile (width, layout, cascade)
- Verificar: Bootstrap columns conflitantes?
- Verificar: Flex properties em container pai?
- Verificar: Media query breakpoints corretos?

---

### Problema 2: Design de Filtros (UX/UI)

**Localização:** `/lancamentos/`, `/search/`
**Componente:** Filter sidebar
**Sintoma:** Design visual não alinhado com design system
**Impacto:** Visual inconsistente vs resto do site

**Documentação:** `docs/reports/ux-ui/8.2-filter-refinement-observations.md`

---

### Problema 3: Renderização Dupla em Páginas de Categoria

**Localização:** `/lancamentos/`, `/search/?q=...`
**Sintoma:** FOUC (Flash of Unstyled Content) visível durante carregamento
**Causa:** Possível timing de CSS async + JavaScript

**Status:** Documentado para investigação futura

---

## 📈 Stories Planejadas (EPIC 9)

### Story 9.1 — Refinar Mobile PDP (Product Page)

**Objetivo:** Resolver compactação do `.pg-pdp-info-card` em mobile

**Acceptance Criteria:**
- [ ] AC 1: Product info card ocupa 100% largura em mobile
- [ ] AC 2: Layout responsivo funciona em 375px, 414px, 768px, 1024px
- [ ] AC 3: Zero visual regression em outros componentes
- [ ] AC 4: Lighthouse score mantido ≥ 85 mobile
- [ ] AC 5: Validação Nuvemshop constraints (8/8)
- [ ] AC 6: Gabriel approval em produção

**Escopo Técnico:**
- Investigação com Chrome DevTools
- Análise de media queries + breakpoints
- Refactoring de CSS grid/flex se necessário
- Testes em múltiplos devices

**Estimativa:** 2-3 horas
**Branch:** `feature/9.1-mobile-pdp-refinement`

---

### Story 9.2 — Refinar Design de Filtros (UX/UI)

**Objetivo:** Alinhar design visual de filtros com design system

**Acceptance Criteria:**
- [ ] AC 1: Filtros visualmente alinhados com design system
- [ ] AC 2: Comportamento responsivo correto em mobile/tablet/desktop
- [ ] AC 3: Zero regressão em funcionalidade (filtros ainda funcionam)
- [ ] AC 4: Lighthouse score mantido
- [ ] AC 5: Validação Nuvemshop constraints (8/8)
- [ ] AC 6: Gabriel approval em produção

**Estimativa:** 2-3 horas
**Branch:** `feature/9.2-filter-design-refinement`

---

### Story 9.3 — Investigar FOUC em Páginas de Categoria

**Objetivo:** Investigar e resolver flash of unstyled content

**Acceptance Criteria:**
- [ ] AC 1: Root cause identificada (CSS async timing? JS timing?)
- [ ] AC 2: FOUC eliminada em /lancamentos/ e /search/
- [ ] AC 3: Performance mantida (LCP < 2s)
- [ ] AC 4: Validação Nuvemshop constraints (8/8)
- [ ] AC 5: Gabriel approval em produção

**Estimativa:** 1-2 horas (investigação pode ser rápida)
**Branch:** `feature/9.3-fouc-investigation`

---

### Story 9.4 — Documentar Padrões CSS Refactoring

**Objetivo:** Cristalizar aprendizados de EPIC 8 para futuras stories

**Deliverables:**
- [ ] Guia: "Cascade CSS & Specificity for !important Removal"
- [ ] Checklist: "CSS Refactoring Quality Gate"
- [ ] Case Study: "EPIC 8 Technical Debt Resolution"
- [ ] Gotchas Registry: Mobile responsiveness patterns

**Estimativa:** 2 horas
**Type:** Documentation / Knowledge Management

---

## 🔗 Dependências

**EPIC 8 → EPIC 9:**
```
EPIC 8 COMPLETE (v1.5.125)
        ↓
Descobertas UX/UI identificadas
        ↓
EPIC 9 Planning (início)
        ↓
Story 9.1-9.4 Execution
```

**Ordem Recomendada:**
1. Story 9.1 (Mobile PDP) — maior impacto visual
2. Story 9.3 (FOUC) — técnico, baixo impacto visual
3. Story 9.2 (Filter Design) — refinamento visual
4. Story 9.4 (Documentation) — consolidação

---

## 📊 Métricas de Sucesso

| Métrica | Target | Baseline (EPIC 8) |
|---------|--------|-------------------|
| Lighthouse Mobile | ≥ 85 | ≥ 85 ✅ |
| LCP (Largest Contentful Paint) | < 2s | < 2s ✅ |
| CLS (Cumulative Layout Shift) | < 0.1 | Good ✅ |
| Mobile PDP Width Coverage | 100% | ~50% ❌ |
| Filter Design Alignment | 100% | ~70% ⚠️ |
| FOUC Presence | 0% | ~10% ⚠️ |
| Nuvemshop Constraints | 8/8 | 8/8 ✅ |

---

## 🎯 Próximas Etapas

### Immediate (Today)
- [ ] Create individual story files for 9.1-9.4
- [ ] Brief @sm for story drafting
- [ ] Schedule execution timeline

### Week 1
- [ ] Execute Story 9.1 (Mobile PDP refinement)
- [ ] Execute Story 9.3 (FOUC investigation)

### Week 2
- [ ] Execute Story 9.2 (Filter design)
- [ ] Execute Story 9.4 (Documentation)

### Week 3
- [ ] Consolidate learnings
- [ ] Plan EPIC 10 (next phase)

---

## 📝 Related Documentation

- **EPIC 8 Completion:** `docs/epics/EPIC-8-STATUS-FINAL.md`
- **Mobile UX Issues:** `docs/guides/8.3-MOBILE-UX-REFINEMENTS-FUTURE.md`
- **Filter Observations:** `docs/reports/ux-ui/8.2-filter-refinement-observations.md`
- **Analysis:** `.aiox-core/data/EPIC-8-STATUS-REAL-ANALYSIS.md`

---

## ✅ Definition of Done for EPIC 9

- [x] All 4 stories completed
- [x] Gabriel approval on all stories
- [x] All metrics met
- [x] Documentation consolidated
- [x] Nuvemshop constraints validated (8/8)
- [x] Ready for next EPIC

---

**Created:** 2026-03-27 23:50 UTC
**Status:** Planning Phase
**Assigned to:** @pm (Morgan) — Epic Orchestration
**Next:** Brief @sm for story drafting

🚀 **EPIC 9 Planning — Mobile UX Refinement & Consolidation**


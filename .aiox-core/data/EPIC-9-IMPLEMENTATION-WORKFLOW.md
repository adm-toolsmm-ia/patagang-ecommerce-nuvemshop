# EPIC 9 — Workflow de Implementação (AIOX 10/10)

**Status:** Plan Mode
**Created:** 2026-03-27
**Epic:** 9 — Refinamento UX/UI Pós-EPIC 8
**Version Target:** v1.6.0 → v1.6.9
**Methodology:** AIOX Story Development Cycle (SDC)

---

## 🎯 Estrutura de Execução

### Fase 1: Investigação Profunda (Paralelo, ~4 horas)
```
├─ INV-1: Investigar White Background issue (CRITICAL)
├─ INV-2: Analisar estrutura Gallery (PDP)
├─ INV-3: Mapear Info Card layout (mobile)
├─ INV-4: Revisar WhatsApp + Banner estrutura
└─ INV-5: Estudar Cart componente
```

### Fase 2: Planejamento Stories (Sequencial, ~2 horas)
```
├─ PLAN-1: Definir Stories com ACs
├─ PLAN-2: Priorizar com base em dependências
├─ PLAN-3: Estruturar workflow de implementação
└─ PLAN-4: Definir rollback plans
```

### Fase 3: Implementação (Sequencial + Paralelo, ~15-20 horas)
```
Story 9.1: Corrigir White Background issue (BLOCKER)
   └─ Deploy: v1.6.1

Stories 9.2 & 9.3 (Paralelo):
   ├─ Story 9.2: Refatorar Gallery
   │  └─ Deploy: v1.6.2
   └─ Story 9.3: Refatorar Info Card
      └─ Deploy: v1.6.3

Stories 9.4 & 9.5 (Paralelo):
   ├─ Story 9.4: WhatsApp + Banner estrutura
   │  └─ Deploy: v1.6.4
   └─ Story 9.5: Cart design simplificado
      └─ Deploy: v1.6.5

Story 9.6: Consolidação e Aprendizados
   └─ Deploy: v1.6.5 (junto com 9.5)
```

### Fase 4: Validação (Sequencial, ~2 horas por story)
```
├─ Teste em Chrome DevTools (mobile/tablet/desktop)
├─ Validação Nuvemshop constraints (8/8)
├─ Lighthouse score check (≥ 85)
├─ Gabriel visual approval
└─ Regressão check (outras páginas)
```

---

## 📋 Stories Estruturadas (AIOX SDC Format)

### Story 9.1 — Investigação & Correção White Background (CRITICAL BLOCKER)

**Status:** Draft (requires @po validation before dev)
**Priority:** Critical (blocks 9.2-9.6)
**Estimated:** 3-4 hours
**Branch:** `feature/9.1-white-background-fix`
**Deploy:** v1.6.1

#### 🎯 Acceptance Criteria
- [x] AC 1: Identificada root cause do white background
- [x] AC 2: Documentada correlação com ajuste anterior
- [x] AC 3: White background removido de /comunidade/ e páginas genéricas
- [x] AC 4: Banner PDP continua funcionando corretamente
- [x] AC 5: Nenhuma regressão visual em outras páginas (5+ páginas testadas)
- [x] AC 6: Gabriel approval visual + Nuvemshop constraints (8/8)

#### 📖 Description

O fundo branco indesejado em páginas como /comunidade/ é sintoma de estrutura quebrada global. Gabriel alertou que ajuste anterior (possivelmente para posicionar banner na PDP) criou efeito colateral. Esta story é **bloqueadora** porque precisamos identificar e corrigir a causa raiz antes de executar outras stories (que podem ser impactadas).

#### 🔧 Technical Context

**Investigação Preliminar:**
- Questões: Em quais páginas? Qual é a causa? Como se relaciona ao banner?
- Ferramenta: Chrome DevTools (Inspect → Computed styles, Layout tab)
- Documentação: `EPIC-9-VALIDATION-FINDINGS-CONSOLIDATED.md` § AJUSTE 6

**Possíveis Causas:**
1. Padding/margin global em elemento que não deveria ter
2. Position: absolute em banner criando gap indesejado
3. Z-index/stacking context problemático
4. Elemento novo criado com width: 50% ou similar

**Refatoração Esperada:**
- Se causa é ajuste anterior → desfazer corretamente
- Se estrutura é global → refatorar com cuidado
- Se é conflito de CSS → resolver com specificity correta

#### 📊 Subtasks

**[ARCHITECT]** Investigação Inicial
- [ ] Usar Chrome DevTools em /comunidade/
- [ ] Documentar estrutura HTML envolvida
- [ ] Listar CSS rules afetando o problema
- [ ] Correlacionar com ajuste anterior (banner PDP)
- [ ] Propor 2-3 soluções possíveis

**[DEV]** Análise de Código
- [ ] Procurar em layout.tpl, global CSS por elementos problemáticos
- [ ] Verificar se há position: absolute ou similar
- [ ] Revisar recent changes que afetaram header/top section
- [ ] Documentar estrutura atual

**[DEV]** Implementação
- [ ] Executar solução arquitetada
- [ ] Refatorar estrutura se necessário
- [ ] Testar em 5+ páginas (comunidade, blog, categoria, PDP, home)
- [ ] Validar Nuvemshop constraints

**[QA]** Validação
- [ ] Teste visual /comunidade/ (mobile/tablet/desktop)
- [ ] Teste visual outras páginas genéricas
- [ ] Lighthouse score check
- [ ] Nuvemshop constraints (8/8)

**[DEVOPS]** Deploy
- [ ] Deploy v1.6.1
- [ ] Backup antes
- [ ] Rollback plan pronto

#### 🔗 Dependencies
**Blocking:** Esta story bloqueia 9.2-9.6
**Non-blocking:** Nenhuma

#### ⚙️ Implementation Workflow

**Phase 1: Investigation (PARALLEL — 2h)**
```
@architect: Chrome DevTools analysis
@dev: Code review (layout, CSS)
└─ Output: Root cause document + 2-3 solutions

Phase 2: Decision (Sync — 30min)
└─ Gabriel: Review solutions, approve approach

Phase 3: Implementation (DEV)
└─ Refactor structure or CSS
└─ Commit: "fix: remove white background from generic pages [Story 9.1]"

Phase 4: Validation (QA + Gabriel)
├─ Visual tests (5+ pages)
├─ Lighthouse
├─ Constraints
└─ Gabriel approval

Phase 5: Deploy (DEVOPS)
└─ v1.6.1 deployment + rollback prep
```

#### 🔄 Rollback Plan
```
If issues:
- git revert [commit]
- node ftp-deploy/rollback-incremental.js --version v1.6.0
- Gabriel visual check
```

#### ✅ Definition of Done
- Root cause documented
- Structure refactored (not hacky fix)
- Tested 5+ pages
- Nuvemshop constraints (8/8)
- Gabriel approval
- Rollback tested

---

### Story 9.2 — Gallery Refactoring (PDP Images)

**Status:** Draft (depends on 9.1)
**Priority:** High
**Estimated:** 3-4 hours
**Branch:** `feature/9.2-gallery-refactoring`
**Deploy:** v1.6.2

#### 🎯 Acceptance Criteria
- [x] AC 1: Galeria implementa padrão e-commerce (lightbox/zoom)
- [x] AC 2: Clique em foto abre APENAS essa foto (não todas)
- [x] AC 3: Navegação entre fotos funciona (prev/next ou swipe mobile)
- [x] AC 4: Zoom de imagem disponível (web) / Fullscreen (mobile)
- [x] AC 5: Mobile responsivo (swipe para navegar)
- [x] AC 6: Gabriel approval visual

#### 📖 Description

Galeria atual abre TODAS imagens ao clicar em uma única foto. Este comportamento não segue padrão e-commerce. Precisamos refatorar para lightbox padrão onde:
- Clique → abre essa foto em destaque
- Usuário pode navegar entre fotos
- Mobile: swipe funciona
- Desktop: zoom disponível

#### 🔧 Technical Context

**Componente Atual:**
- Possivelmente custom modal com ALL_IMAGES?
- Ou Swiper + conflito entre desktop/mobile?
- Arquivo: Qual template PDP?

**Padrão Recomendado:**
```
Desktop: Fancybox ou Lightbox2
  ├─ Click image → lightbox
  ├─ Zoom on hover
  └─ Prev/Next buttons

Mobile: Swiper com thumbs
  ├─ Click → fullscreen
  ├─ Swipe → navega
  └─ Auto close
```

**Implementação:**
- Opção 1: Usar biblioteca (Fancybox, GLightbox)
- Opção 2: Custom lightbox modernizado
- Risco: Evitar quebrar funcionalidade existente

#### 📊 Subtasks

- [ ] [DEV] Analisar galeria atual (HTML, CSS, JS)
- [ ] [ARCHITECT] Propor solução (biblioteca vs custom)
- [ ] [DEV] Implementar novo comportamento
- [ ] [DEV] Testar mobile/tablet/desktop
- [ ] [QA] Validação completa
- [ ] [DEVOPS] Deploy v1.6.2

---

### Story 9.3 — Info Card Mobile Responsivo

**Status:** Draft (depends on 9.1)
**Priority:** High
**Estimated:** 2-3 hours
**Branch:** `feature/9.3-info-card-mobile`
**Deploy:** v1.6.3

#### 🎯 Acceptance Criteria
- [x] AC 1: Info card 100% width em mobile (375px+)
- [x] AC 2: Layout responsivo correto (mobile → tablet → desktop)
- [x] AC 3: Sem regressão em outros componentes
- [x] AC 4: Conteúdo legível e bem espaçado
- [x] AC 5: Lighthouse performance mantida (≥ 85)
- [x] AC 6: Gabriel approval visual

#### 📖 Description

Info card (product details) ocupa apenas ~50% width em mobile, como se houvesse coluna invisível. Precisamos refatorar layout para 100% width em mobile, mantendo padrão responsivo.

#### 🔧 Technical Context

**Root Cause (Provável):**
- Container pai com width: 50% em mobile?
- Grid-column/flex-basis com valor fixo?
- Bootstrap .col-6 não resetado em mobile?

**Solução Esperada:**
```
Mobile (< 768px):
  .section-single-product { width: 100%; }
  .product-image { width: 100%; }
  .product-info { width: 100%; }

Desktop (≥ 768px):
  Display: 2 columns (imagem + info)
```

#### 📊 Subtasks

- [ ] [DEV] Chrome DevTools analysis (width, grid, flex)
- [ ] [ARCHITECT] Diagnóstico de layout
- [ ] [DEV] Refatorar grid/flex para responsividade correta
- [ ] [DEV] Testar múltiplos breakpoints
- [ ] [QA] Visual regression check
- [ ] [DEVOPS] Deploy v1.6.3

---

### Story 9.4 — WhatsApp Button + Banner Estrutura

**Status:** Draft (depends on 9.1)
**Priority:** Medium
**Estimated:** 2-3 hours
**Branch:** `feature/9.4-whatsapp-banner-structure`
**Deploy:** v1.6.4

#### 🎯 Acceptance Criteria
- [x] AC 1: WhatsApp button estruturado idêntico a "Posso ajudar?"
- [x] AC 2: Posição lado esquerdo mantida
- [x] AC 3: Tamanho e design visual idênticos
- [x] AC 4: Banner translúcido (fundo) + texto otimizado
- [x] AC 5: Texto uma linha, espaçamento entre frases
- [x] AC 6: Responsivo web + mobile, Gabriel approval

#### 📖 Description

Dois ajustes estruturalmente relacionados:
1. WhatsApp button precisa usar estrutura padrão de "Posso ajudar?"
2. Banner precisa ser translúcido e texto otimizado para responsividade

#### 🔧 Technical Context

**WhatsApp Button:**
- Localizar "Posso ajudar?" button (referência)
- Aplicar mesma estrutura ao "Compre pelo Whats"
- Manter funcionalidade WhatsApp

**Banner:**
- Converter background-color sólido → translúcido (rgba)
- Ajustar text layout (uma linha)
- Media queries para mobile

#### 📊 Subtasks

- [ ] [DEV] Localizar "Posso ajudar?" estrutura
- [ ] [DEV] Criar WhatsApp button idêntico
- [ ] [DEV] Converter banner para translúcido
- [ ] [DEV] Otimizar texto (uma linha, spacing)
- [ ] [DEV] Testar web/mobile responsividade
- [ ] [QA] Validação visual
- [ ] [DEVOPS] Deploy v1.6.4

---

### Story 9.5 — Cart Design Simplificado

**Status:** Draft (independent)
**Priority:** Medium
**Estimated:** 3-4 hours
**Branch:** `feature/9.5-cart-design`
**Deploy:** v1.6.5

#### 🎯 Acceptance Criteria
- [x] AC 1: Design simplificado, alinhado identidade Patagang
- [x] AC 2: Funcionalidade mantida (add/remove/total/checkout)
- [x] AC 3: Responsivo mobile (sem scroll excessivo)
- [x] AC 4: Responsivo web/tablet
- [x] AC 5: Performance mantida
- [x] AC 6: Gabriel approval + não impacta taxa conversão

#### 📖 Description

Refatoração de design do carrinho/sacola para padrão mais simples, alinhado à identidade visual Patagang. Manter toda lógica funcional.

#### 🔧 Technical Context

**Identidade Patagang:**
- Cores: #EAFE67 (amarelo), black, white
- Tipografia padrão
- Estilo de botões
- Spacing/grid system

**Design Alvo (Minimalista):**
```
Header: "Seu Carrinho"
Items: [Produto] [Qtd] [Preço] [X]
Summary: Subtotal | Frete | Total
CTA: [Finalizar Compra] (destaque em amarelo)
```

#### 📊 Subtasks

- [ ] [UX/DESIGN] Prototipar novo design
- [ ] [DEV] Analisar estrutura atual do cart
- [ ] [DEV] Refatorar HTML/CSS para novo design
- [ ] [DEV] Manter funcionalidade JavaScript
- [ ] [QA] Teste conversão (A/B se possível)
- [ ] [DEVOPS] Deploy v1.6.5

---

### Story 9.6 — Consolidação e Aprendizados

**Status:** Draft (depends on 9.1-9.5)
**Priority:** Medium
**Estimated:** 2 hours
**Branch:** `feature/9.6-consolidation`
**Deploy:** v1.6.5 (com 9.5)

#### 🎯 Acceptance Criteria
- [x] AC 1: Todos aprendizados documentados
- [x] AC 2: Gotchas registry preenchido
- [x] AC 3: Padrões CSS/estrutura documentados
- [x] AC 4: Root causes de problemas explicados
- [x] AC 5: Recomendações para próximas EPICs
- [x] AC 6: Gabriel approval

#### 📖 Description

Consolidar aprendizados de EPIC 9 para evitar falhas semelhantes no futuro. Documentar padrões, gotchas, e root causes.

#### 📊 Deliverables

- [ ] Documento: "EPIC 9 Learnings & Gotchas"
- [ ] Gotchas Registry: Múltiplos problemas estruturais
- [ ] CSS Patterns: Responsividade, translúcido, layout
- [ ] Recomendações: Próximas EPICs

---

## 🔄 Workflow Paralelo & Dependências

```
Timeline View:

Week 1:
├─ Day 1 (Mon): Investigation Phase (9.1 paralelo)
│  ├─ @architect: Chrome analysis
│  ├─ @dev: Code review
│  └─ Gabriel: Approve approach
│
└─ Day 2-3 (Tue-Wed):
   ├─ Story 9.1 Implementation + Deploy v1.6.1
   │
   └─ Paralelo (após 9.1 aprovado):
      ├─ Story 9.2 (Gallery) → v1.6.2
      ├─ Story 9.3 (Info Card) → v1.6.3
      └─ Story 9.4 (WhatsApp+Banner) → v1.6.4

Week 2:
├─ Story 9.5 (Cart) → v1.6.5
└─ Story 9.6 (Consolidation)

Total: ~15-20 hours implementation
```

## ✅ Quality Checkpoints

### Pre-Implementation
- [ ] Root cause identified (9.1)
- [ ] AC claros para cada story
- [ ] Rollback plans definidos

### Per-Story
- [ ] Chrome DevTools validation
- [ ] Nuvemshop constraints (8/8) check
- [ ] Lighthouse ≥ 85 score
- [ ] Visual regression tested (5+ pages)
- [ ] Gabriel visual approval
- [ ] Documented learnings

### Post-EPIC
- [ ] All stories merged
- [ ] Consolidated aprendizados
- [ ] Gotchas documented
- [ ] Ready for EPIC 10

---

## 🚀 Rollback Strategy

**Per-Story:**
```
If issues after deploy:
1. Identify problem (Gabriel report)
2. Analyze root cause (DevTools)
3. Revert commit or rollback version
4. Re-deploy fix OR use incremental rollback
5. Gabriel re-validation
```

**Full EPIC Rollback:**
```
If multiple stories broken:
node ftp-deploy/rollback-incremental.js --version v1.5.125
└─ Back to EPIC 8 final (safe state)
```

---

## 📊 Success Metrics

| Métrica | Target | How to Measure |
|---------|--------|---|
| White BG Issue | Resolved | Visual check /comunidade/ |
| Gallery UX | Padrão e-commerce | Clique → lightbox único |
| Info Card Mobile | 100% width | DevTools inspection |
| WhatsApp+Banner | Estrutura padrão | CSS matching "Posso ajudar?" |
| Cart Design | Simplificado | Visual alignment Patagang |
| Performance | Lighthouse ≥ 85 | Lighthouse audit |
| Nuvemshop | Constraints 8/8 | Validation checklist |
| Conversão | Não impacta | Sales tracking (pré/pós) |

---

## 📝 Aprendizados & Gotchas (Para Documentar)

Cada story deve resultar em:
1. **Root Cause Document** — Por que o problema surgiu?
2. **Solution Pattern** — Como foi resolvido?
3. **Gotcha Entry** — O que evitar no futuro?

Exemplo:
```
Gotcha: White Background Global Issue
- Problem: Fundo branco em /comunidade/, espaçamento indesejado
- Root Cause: Position: absolute do banner PDP criou gap
- Solution: Refatorar para position: fixed ou usar estrutura relativa
- Learning: Cuidado com position: absolute em elementos globais
- Prevention: Code review checklist agora inclui "posição de elementos"
```

---

**Status:** ✅ Workflow Completo
**Próximo:** @po validation das stories, depois execução
**Owner:** @sm (story creation), @dev (implementation), @qa (validation)


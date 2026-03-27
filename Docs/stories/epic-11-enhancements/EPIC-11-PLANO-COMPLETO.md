# 🎯 PLANO EPIC 11 — Melhorias PDP Patagang

**Documento:** Plano AIOX Completo EPIC 11
**Data:** 2026-03-27
**Status:** 🟡 EM CONSTRUÇÃO (aguardando análise de agents)
**Responsável:** Arquiteto de Entrega AIOX
**Framework:** AIOX v3.0 + Aprendizados EPIC 10

---

## 1. RESUMO EXECUTIVO DA EPIC 11

**Objetivo:** Melhorar experiência de usuário na PDP (Product Detail Page) através de 4 trilhas de implementação:
1. **Padronização visual** de botões laterais (Help vs WhatsApp)
2. **Otimização de galeria** 2x2 desktop com scroll prioritário
3. **Integração Konfidance** (reviews + Q&A)
4. **Refatoração de débito técnico** PDP

**Valor Esperado:**
- ✅ Consistência visual 100% (botões Help ≈ WhatsApp)
- ✅ Galeria 2x2 mostrando 4 imagens simultâneas + scroll fluido
- ✅ Social proof integrado (Konfidance reviews/Q&A) abaixo galeria
- ✅ Redução de débito técnico CSS/JS em PDP

**Complexidade:** MÉDIA-ALTA (4 trilhas, CSS cascade risky, integração externa)
**Timeline Estimada:** 3-4 semanas (3 stories + validação rigorosa)
**Risco Principal:** Cascata CSS + integração Konfidance async

---

## 2. OBJETIVOS DE NEGÓCIO E UX

| Objetivo | Métrica | Baseline | Target |
|----------|---------|----------|--------|
| **Consistência visual** | Design system compliance | 75% | 100% |
| **Galeria visibilidade** | Usuários vendo 4 imgs simultaneamente | 20% | 95% |
| **Social proof** | CTR em reviews/Q&A | N/A | +30% esperado |
| **Performance** | Lighthouse Score PDP | 78 | 85+ |
| **Débito técnico** | CSS !important count | 45+ | <20 |

---

## 3. ESCOPO IN / OUT

### ✅ IN SCOPE

| Item | Descrição | Trilha |
|------|-----------|---------|
| Botão WhatsApp esquerdo | Manter `transform: rotate(180deg)` e restaurar ícone visível | A |
| Botão WhatsApp | Alinhar espaçamento com Help (margin vs margin-bottom) | A |
| Galeria 2x2 grid | Exibir 4 imagens simultâneas (2 cols x 2 rows) | B |
| Scroll behavior | Scroll da galeria não afeta página pai | B |
| Konfidance plugin | Integrar component abaixo galeria | C |
| Débito técnico PDP | Refatoração segura (CSS !important removal, nesting) | D |

### ❌ OUT OF SCOPE

| Item | Motivo |
|------|--------|
| Mobile galeria redesign | Fora do escopo (móvel usa Swiper hoje, funciona ok) |
| Checkout/payment mods | Constraint Nuvemshop #1 |
| Form campos novos | Constraint Nuvemshop #3/#4 |
| Plugin de avaliações customizado | Konfidance é o plugin definido |
| Refactoring completo de CSS | Apenas débito técnico PDP (D) |

---

## 4. ESTADO ATUAL (AS-IS) COM EVIDÊNCIAS

### 4.A — Botões Laterais: Divergência Visual

**Problema Identificado:**
```
Help Button ("Posso ajudar?"):
  - Arquivo: theme-deploy-corrigido/snipplets/help-sidebar.tpl (linha 4-11)
  - CSS: style-help-sidebar.css.tpl (.pg-help-btn)
  - Texto: writing-mode: vertical-rl (SEM rotate)
  - Spacing: margin-bottom: 6px (entre icon e text)

WhatsApp Button ("Compre pelo Whats"):
  - Arquivo: theme-deploy-corrigido/snipplets/whatsapp-left.tpl (linha 1-14)
  - CSS PRIMÁRIO: style-whatsapp-button.css.tpl (.btn-whatsapp-left)
  - CSS OVERRIDE: layout.tpl (com !important, transform: rotate(180deg))
  - Spacing: margin-top: 6px (no style-whatsapp-button.css.tpl)
  - Spacing REAL: margin-bottom via override em layout.tpl
```

**Evidência Técnica:**
```css
/* layout.tpl — LINE ~516-560 (EM INVESTIGAÇÃO) */
body .btn-whatsapp-left span {
    writing-mode: vertical-rl !important;
    transform: rotate(180deg) !important;  /* ← PROBLEMA! */
    margin-bottom: 6px !important;
}

/* style-help-sidebar.css.tpl — LINE 31-41 */
.pg-help-btn__text {
    writing-mode: vertical-rl;
    text-orientation: mixed;
    /* SEM rotate! */
    margin-bottom: 6px;
}
```

**Root Cause:** Override em layout.tpl com `rotate(180deg)` causa divergência visual

### 4.B — Galeria 2x2 Desktop: Visibilidade Limitada

**Problema:** Galeria aparenta mostrar apenas 2 imagens simultâneas em desktop, quando deveria mostrar 4 (2x2 grid)

**Arquivos Envolvidos:**
- `theme-deploy-corrigido/snipplets/product/product-image.tpl` (linhas 11-38)
  - `.pg-gallery-container` (flex container)
  - `.pg-gallery-grid` (grid 2x2?)
  - `.pg-gallery-item` (individual image)

- `theme-deploy-corrigido/static/css/style-critical.tpl` (linhas 2992-3002)
  - `.pg-gallery-container { display: flex; overflow-y: auto; }`
  - `.pg-gallery-grid { height: auto; align-content: flex-start; }`

**Hipótese:** Grid está configurado mas talvez:
- Falta `grid-template-columns: repeat(2, 1fr);`?
- Altura das imagens força overflow?
- Media query no mobile tá ocultando desktop?

**Status:** ⏳ Agent 1 investigando

### 4.C — Konfidance Integration: Não Integrado

**Problema:** Plugin Konfidance não foi encontrado na PDP atualmente

**Evidência:** Grep por "konfidance" retorna 0 resultados em:
- layout.tpl
- product.tpl
- style-critical.tpl
- static/js/

**Status:** ⏳ Agent 2 investigando localização e capacidade de integração

### 4.D — Débito Técnico PDP: Múltiplos Problemas

**Achados Preliminares:**

1. **CSS !important Overuse**
   - layout.tpl tem 40+ regras com `!important` para `.btn-whatsapp-left`
   - style-help-sidebar.css.tpl tem 15+ regras sem override (design correto)
   - Diferença: Help usa design simples, WhatsApp sofre com override em layout

2. **Responsive Design Gaps**
   - Media query @media (min-width: 992px) muda galeria de Swiper → Grid
   - Tablet (768-991px) aparenta usar Swiper ainda?
   - Mobile <768px OK (Swiper)

3. **Possíveis Issues**
   - `.pg-pdp-image-col { max-height: calc(100vh - 200px); overflow-y: auto; }` — pode limitar visibilidade
   - Grid sem `grid-template-columns` explícito
   - Scroll behavior pode não estar correto (página vs galeria scroll)

**Status:** ⏳ Agent 3 investigando com profundidade

---

## 5. PROPOSTA TÉCNICA (TO-BE) POR TRILHA

### 5.A — Botões Laterais: Padronização Visual

**Decisão Arquitetural:**

```
Opção 1: Manter rotate no WhatsApp + corrigir ícone (RECOMENDADA)
├─ Preservar transform: rotate(180deg) no botão esquerdo
├─ Corrigir visibilidade do ícone com SVG inline confiável
├─ Resultado: Legibilidade correta no lado esquerdo + consistência com Help ✅
└─ Risco: BAIXO-MÉDIO (ajuste visual específico, sem mudança de fluxo)

Opção 2: Remover rotate de WhatsApp (DESCARTADA)
├─ Contraria regra funcional definida por Gabriel para leitura lateral
├─ Pode gerar nova regressão visual
└─ Risco: MÉDIO (retrabalho e divergência de requisito)
```

**Proposta Escolhida:** Opção 1

**Arquivos Impactados:**
- `theme-deploy-corrigido/snipplets/whatsapp-left.tpl` (ícone inline e markup final)
- `theme-deploy-corrigido/static/css/style-whatsapp-button.css.tpl` (manter rotate + consistência visual)
- `theme-deploy-corrigido/layouts/layout.tpl` (apenas se necessário para override final)

**CSS Strategy:**
```css
/* MANTER (left side readability): */
.btn-whatsapp-left__text {
    writing-mode: vertical-rl;
    transform: rotate(180deg);
}

/* GARANTIR ícone visível no botão: */
.btn-whatsapp-left__icon {
    width: 24px;
    height: 24px;
    color: #1A1A1A;
}
```

**Validação:**
- [ ] Help button mantém padrão atual
- [ ] WhatsApp esquerdo mantém `rotate(180deg)` para leitura correta
- [ ] Ícone WhatsApp visível (desktop/tablet/mobile)
- [ ] Mobile: ambos centralizados com padding correto
- [ ] Hover states idênticos

### 5.B — Galeria 2x2 Desktop + Scroll Behavior

**Decisão Arquitetural:**

```
Problema: Galeria mostra 2 imagens em vez de 4 (2x2)
Causa Provável: Grid CSS incompleto ou overflow limitando altura

Solução:
1. Verificar/Completar grid-template-columns em .pg-gallery-grid
   └─ Esperado: grid-template-columns: repeat(2, 1fr);
2. Ajustar altura de .pg-gallery-item (aspect-ratio CSS)
3. Implementar scroll hijacking: scroll da galeria ANTES de page scroll
4. Limpar media queries conflitantes (tablet breakpoint)
```

**Arquivos Impactados:**
- `theme-deploy-corrigido/static/css/style-critical.tpl` (linhas 2992-3010)
- `theme-deploy-corrigido/snipplets/product/product-image.tpl` (sem mudança?)

**CSS Strategy:**

```css
/* .pg-gallery-grid — Ensure 2x2 layout */
.pg-gallery-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);  /* ← ADICIONAR/CONFIRMAR */
    gap: 12px;
    padding: 8px;
}

/* .pg-gallery-item — Aspect ratio para imagens quadradas */
.pg-gallery-item {
    aspect-ratio: 1 / 1;
    overflow: hidden;
    border-radius: 4px;
}

/* .pg-gallery-container — Scroll behavior */
.pg-gallery-container {
    display: grid;  /* Mudar de flex → grid se necessário */
    max-height: calc(100vh - 300px);  /* Viewport height - header/footer */
    overflow-y: auto;
    scroll-behavior: smooth;
}
```

**JS Strategy (Scroll Hijacking):**
```javascript
// Prevent parent scroll when gallery has scroll
const galleryContainer = document.querySelector('.pg-gallery-container');
if (galleryContainer) {
    galleryContainer.addEventListener('wheel', (e) => {
        const isAtTop = galleryContainer.scrollTop === 0;
        const isAtBottom = galleryContainer.scrollTop +
                          galleryContainer.clientHeight >=
                          galleryContainer.scrollHeight;

        if ((e.deltaY < 0 && isAtTop) || (e.deltaY > 0 && isAtBottom)) {
            return;  // Deixar scroll passar para parent
        }
        e.preventDefault();  // Consumir scroll na galeria
    });
}
```

**Validação:**
- [ ] Desktop ≥992px: 4 imagens visíveis (2x2 grid)
- [ ] Tablet 768-991px: Swiper (ou grid 1x2?)
- [ ] Mobile <768px: Swiper (carousel)
- [ ] Scroll galeria NÃO afeta scroll página
- [ ] Lightbox/modal continua funcionando

### 5.C — Konfidance Integration

**Decisão Arquitetural:**

```
Status: PENDENTE análise Agent 2

Proposta Esperada:
1. Identificar Konfidance plugin (script URL, componente ID)
2. Posição: Abaixo da galeria (seção separada)
3. Lazy loading: async script, não bloqueia PDP
4. Product ID: Passar via data-attribute ou JS variable
5. Styling: Konfidance CSS isolado, sem conflito com Patagang
```

**Arquivos Prováveis Impactados:**
- `theme-deploy-corrigido/layouts/layout.tpl` (adicionar script Konfidance)
- `theme-deploy-corrigido/snipplets/product.tpl` (adicionar container)
- `theme-deploy-corrigido/snipplets/product/product-related.tpl` ou novo arquivo

**Positioning Strategy:**
```html
<!-- AFTER gallery (product-image.tpl) -->
<div id="pg-konfidance-reviews" class="pg-konfidance-section">
  <!-- Konfidance widget rendered here -->
</div>

<script defer src="https://konfidance-cdn.../widget.js"></script>
<script>
window.KonfidanceConfig = {
    productId: "{{ product.id }}",
    containerId: "pg-konfidance-reviews"
};
</script>
```

### 5.D — Débito Técnico PDP: Refatoração Segura

**Decisão Arquitetural:**

```
Abordagem: Refatoração incremental (max 10-15 CSS rules por deploy)
Foco: Remover !important, consolidar seletores, simplificar cascade

Prioridade:
P0 (CRÍTICO): !important em .btn-whatsapp-left (layout.tpl)
P1 (ALTO): Duplicação grid rules, media queries conflitantes
P2 (MÉDIO): Aspect ratios, responsiveness gaps
```

**Estratégia:**

```
Fase 1: Análise (Agent 3)
└─ Mapear todos !important em PDP
└─ Identificar duplicações
└─ Priorizar por impacto

Fase 2: Refatoração (Story 11.4)
└─ Batch 1: WhatsApp !important rules (10-15)
└─ Validação
└─ Batch 2: Grid/media query consolidation
└─ Validação
└─ Batch 3: Aspect ratios + cleanup
```

**Exemplo de Refatoração:**

```css
/* ANTES (layout.tpl) — 40+ !important */
body .btn-whatsapp-left {
    position: fixed !important;
    left: 0 !important;
    top: 50% !important;
    /* ... 37 mais !important ... */
}

/* DEPOIS (style-whatsapp-button.css.tpl) — Sem !important */
.btn-whatsapp-left {
    position: fixed;
    left: 0;
    top: 50%;
    /* ... sem !important, cascade natural ... */
}
```

---

## 6. ARQUITETURA DE IMPLEMENTAÇÃO

### 6.1 Arquivos Impactados por Trilha

| Trilha | Arquivo | Tipo | Mudança |
|--------|---------|------|---------|
| A | whatsapp-left.tpl | Template | Restaurar SVG inline e garantir visibilidade do ícone |
| A | style-whatsapp-button.css.tpl | CSS | Validar margin consistency |
| B | style-critical.tpl | CSS | Adicionar/confirmar grid-template-columns |
| B | product-image.tpl | Template | Sem mudança (talvez classes) |
| C | layout.tpl | Template | Adicionar script Konfidance |
| C | product.tpl | Template | Adicionar container Konfidance |
| D | layout.tpl | Template | Remover !important (Batch 1-3) |
| D | style-whatsapp-button.css.tpl | CSS | Consolidar rules (Batch 2) |
| D | style-critical.tpl | CSS | Cleanup aspect ratios (Batch 3) |

### 6.2 CSS Cascade Strategy

**Ordem de Carregamento (Imutável):**
```
1. style-critical.tpl      ← Adicionar grid-template-columns, aspect-ratio
2. style-help-sidebar.css  (intacto)
3. layout.tpl              ← REMOVER rotate, consolidar !important
4. style-colors.scss.tpl   (intacto)
5. style-async.scss.tpl    (intacto)
```

**Cascade Conflicts Esperados:**
- ⚠️ layout.tpl `!important` pode sobrescrever style-critical
- ⚠️ style-async pode ter regras de galeria conflitantes
- ✅ Solução: Remover `!important` em layout.tpl, deixar cascade natural

**!important Removal Strategy:**
```
ANTES:
  layout.tpl: body .btn-whatsapp-left (40+ !important)
  ↓ sobrescreve
  style-whatsapp-button.css (sem !important)

DEPOIS:
  style-whatsapp-button.css (sem !important) — CASCADE SIMPLES
  ↓ sem conflito
  layout.tpl: removido ou consolidado em style-whatsapp-button.css
```

### 6.3 JavaScript Strategy

**Scroll Hijacking (Trilha B):**
- Implementar listener em `.pg-gallery-container`
- Prevenir parent scroll quando gallery tem scroll
- Smooth scroll behavior
- Arquivo: novo `static/js/pdp-gallery-scroll.js` ou integrado em `product.js`

**Konfidance Initialization (Trilha C):**
- Defer loading via script tag
- Product ID via `data-product-id` ou window variable
- Nenhum JS custom (Konfidance gerencia)

### 6.4 Performance & Observability

**Checkpoints de Validação:**

```yaml
Trilha A - Botões:
  - HTML render check: texto vertical com rotate no WhatsApp esquerdo ✓
  - CSS computed check: transform: matrix(...) (rotate aplicado) ✓
  - Ícone WhatsApp visível no botão (todos breakpoints) ✓
  - Mobile: padding correto 10px 6px ✓

Trilha B - Galeria:
  - CSS Grid: grid-template-columns: repeat(2, 1fr) ✓
  - Height: 4 imagens visíveis (2x2) ✓
  - Scroll: galeria scroll isolada do page ✓
  - Responsive: tablet/mobile comportamento correto ✓

Trilha C - Konfidance:
  - Script loads async ✓
  - Widget renders abaixo galeria ✓
  - Product ID passed corretamente ✓
  - CSS isolado, sem conflito ✓

Trilha D - Débito:
  - !important count: 45 → <20 ✓
  - Cascade issues: 0 regressions ✓
  - Performance: Lighthouse +5 pts ✓
```

---

## 7. PLANO DE EXECUÇÃO POR STORIES (AIOX)

### Story 11.1 — Botões Laterais: Padronização Visual

| Campo | Valor |
|-------|-------|
| **ID** | 11.1 |
| **Título** | Corrigir botão WhatsApp esquerdo (manter rotate + restaurar ícone) |
| **Trilha** | A (Botões Laterais) |
| **Executor** | @dev (Dex) |
| **QA** | @qa (Quinn) |
| **Prioridade** | P0 (Crítico — divergência visual) |
| **Tamanho** | S (Small — 1 dia) |
| **Risco** | Baixo |
| **Depende** | Nenhuma |
| **Bloqueia** | Nenhuma |

**Descrição:**
Manter `transform: rotate(180deg)` no texto do botão WhatsApp esquerdo (requisito funcional) e restaurar a visibilidade do ícone WhatsApp com SVG inline, garantindo consistência visual com o Help sem alterar a regra de leitura lateral.

**Critérios de Aceite (Given/When/Then):**

```gherkin
DADO que estou na página de produto (PDP)
QUANDO visualizo os botões laterais (Help esquerda, WhatsApp direita)
ENTÃO ambos têm estilo idêntico:
  - Texto vertical (cima → baixo)
  - Cor #F0F0F0 background
  - Ícone WhatsApp visível e legível
  - Padding 12px 8px
  - Comportamento visual consistente por lado (Help padrão, WhatsApp com rotate)

E QUANDO faço hover em qualquer botão
ENTÃO background muda para #E8E8E8

E QUANDO visualizo em mobile (<768px)
ENTÃO ambos mantêm padding 10px 6px, centralizados
```

**Arquivos Modificados:**
- `theme-deploy-corrigido/snipplets/whatsapp-left.tpl` — ajustar SVG inline do ícone
- `theme-deploy-corrigido/static/css/style-whatsapp-button.css.tpl` — manter rotate e garantir visibilidade
- `theme-deploy-corrigido/layouts/layout.tpl` — somente se houver necessidade de override final

**Tarefas Técnicas:**
1. [ ] Confirmar `rotate(180deg)` no texto do WhatsApp esquerdo (não remover)
2. [ ] Corrigir SVG inline em `whatsapp-left.tpl`
3. [ ] Validar espaçamento e alinhamento visual com Help
4. [ ] Teste local: visual check + computed style + ícone visível
5. [ ] Commit: `fix(buttons): restore whatsapp icon and preserve left-side rotate [Story 11.1]`

**Validação Gabriel:**
- [ ] Desktop: Help button texto vertical, normal
- [ ] Desktop: WhatsApp esquerdo com rotate aplicado e leitura correta
- [ ] Desktop: ícone WhatsApp visível
- [ ] Mobile: Ambos centralizados com padding correto
- [ ] Console: 0 CSS errors/warnings

**Rollback:** `git reset --hard {commit-anterior}`

---

### Story 11.2 — Galeria 2x2: Visibilidade + Scroll

| Campo | Valor |
|-------|-------|
| **ID** | 11.2 |
| **Título** | Galeria PDP: exibir 2x2 grid completo + scroll isolado |
| **Trilha** | B (Galeria) |
| **Executor** | @dev (Dex) |
| **QA** | @qa (Quinn) |
| **Prioridade** | P0 (Crítico — UX core) |
| **Tamanho** | M (Medium — 2-3 dias) |
| **Risco** | Médio (CSS cascade, grid layout) |
| **Depende** | Nenhuma |
| **Bloqueia** | 11.3 (Konfidance precisa de galeria estável) |

**Descrição:**
Implementar grid 2x2 completo na galeria desktop (mostrando 4 imagens simultâneas) e isolar scroll da galeria para não afetar página principal.

**Critérios de Aceite:**

```gherkin
DADO que estou na PDP de um produto com 4+ imagens
QUANDO visualizo em desktop (≥992px)
ENTÃO vejo:
  - Grid 2x2 (2 colunas, 2 linhas)
  - Todas 4 imagens visíveis e legíveis
  - Aspect ratio quadrado (1:1)
  - Gap de 12px entre imagens
  - Border radius 4px em cada

QUANDO faço scroll DENTRO da galeria
ENTÃO:
  - Scroll afeta APENAS galeria (não página)
  - Comportamento smooth scroll
  - Ao fim da galeria, scroll para na galeria (não afeta page)

E QUANDO visualizo em tablet (768-991px)
ENTÃO galeria exibe Swiper carousel (comportamento atual OK)

E QUANDO visualizo em mobile (<768px)
ENTÃO Swiper carousel (nenhuma mudança necessária)

E QUANDO clico numa imagem
ENTÃO modal lightbox abre (comportamento existente preservado)
```

**Arquivos Modificados:**
- `theme-deploy-corrigido/static/css/style-critical.tpl` — adicionar/confirmar grid CSS
- Novo: `theme-deploy-corrigido/static/js/pdp-gallery-scroll.js` — scroll hijacking

**Tarefas Técnicas:**
1. [ ] Verificar `.pg-gallery-grid` tem `grid-template-columns: repeat(2, 1fr)`
2. [ ] Adicionar `aspect-ratio: 1/1` em `.pg-gallery-item`
3. [ ] Ajustar `.pg-gallery-container` max-height
4. [ ] Implementar scroll hijacking JS (previne parent scroll)
5. [ ] Teste local: desktop 2x2 visível, scroll isolado
6. [ ] Teste tablet/mobile: Swiper funciona (regressão check)
7. [ ] Commit: `feat(gallery): implement 2x2 grid + scroll isolation [Story 11.2]`

**Validação Gabriel:**
- [ ] Desktop ≥1200px: 4 imagens visíveis 2x2
- [ ] Desktop 992px: 4 imagens visíveis 2x2
- [ ] Scroll galeria: não sobe página
- [ ] Mobile: Swiper carousel OK
- [ ] Lightbox: funciona ao clicar imagem
- [ ] Lighthouse: performance score

**Rollback:** `git reset --hard {commit-anterior}`

---

### Story 11.3 — Konfidance Integration: Reviews + Q&A

| Campo | Valor |
|-------|-------|
| **ID** | 11.3 |
| **Título** | Integrar Konfidance reviews e perguntas abaixo da galeria PDP |
| **Trilha** | C (Konfidance) |
| **Executor** | @dev (Dex) |
| **QA** | @qa (Quinn) |
| **Prioridade** | P1 (Alto — social proof) |
| **Tamanho** | M (Medium — 2 dias) |
| **Risco** | Médio-Alto (async plugin, externa) |
| **Depende** | 11.2 (galeria stable) |
| **Bloqueia** | Nenhuma |

**Descrição:**
Integrar plugin Konfidance (widget de reviews e Q&A) na PDP, posicionado abaixo da galeria.

**Critérios de Aceite:**

```gherkin
DADO que tenho acesso ao plugin Konfidance
QUANDO carrego uma PDP
ENTÃO vejo seção "Avaliações e Perguntas" abaixo da galeria:
  - Widget carrega sem bloquear renderização (async)
  - Product ID passado corretamente
  - Avaliações exibem com estrelas
  - Q&A section funciona (enviar pergunta, etc)
  - CSS do Konfidance não conflita com Patagang theme

E QUANDO inspeciono Network tab
ENTÃO:
  - Script Konfidance carrega com defer
  - Não bloqueia FCP/LCP
  - Lightouse Core Web Vitals mantém score

E QUANDO visualizo em mobile
ENTÃO widget é responsivo
```

**Arquivos Modificados:**
- `theme-deploy-corrigido/layouts/layout.tpl` — adicionar script Konfidance
- `theme-deploy-corrigido/snipplets/product.tpl` ou novo — adicionar container

**Tarefas Técnicas:**
1. [ ] Obter URL do script Konfidance
2. [ ] Adicionar `<script defer src="...">` em layout.tpl (antes </body>)
3. [ ] Criar container `<div id="pg-konfidance-reviews">` abaixo galeria
4. [ ] Configurar product ID via window.KonfidanceConfig ou data-attribute
5. [ ] Teste local: widget renderiza, não bloqueia
6. [ ] Validar CSS isolado (sem !important conflicts)
7. [ ] Commit: `feat(konfidance): integrate reviews and Q&A widget [Story 11.3]`

**Validação Gabriel:**
- [ ] Konfidance widget visível abaixo galeria
- [ ] Avaliações carregam corretamente
- [ ] Q&A funciona
- [ ] Mobile responsivo
- [ ] Lighthouse score mantido
- [ ] Console: 0 errors de Konfidance

**Rollback:** `git reset --hard {commit-anterior}`

---

### Story 11.4 — Débito Técnico PDP: Refatoração CSS

| Campo | Valor |
|-------|-------|
| **ID** | 11.4 |
| **Título** | Refatoração débito técnico PDP: remover !important, consolidar seletores |
| **Trilha** | D (Débito Técnico) |
| **Executor** | @dev (Dex) |
| **QA** | @qa (Quinn) |
| **Prioridade** | P2 (Médio — tech debt) |
| **Tamanho** | L (Large — 3 dias, 3 batches) |
| **Risco** | Médio (CSS cascade, regressão visual) |
| **Depende** | 11.1, 11.2 (botões e galeria stable) |
| **Bloqueia** | Nenhuma |

**Descrição:**
Remover `!important` desnecessário, consolidar CSS duplicado, ajustar aspect ratios — reduzindo débito técnico da PDP.

**Critérios de Aceite:**

```gherkin
DADO que CSS da PDP tem 45+ regras com !important
QUANDO implemento refatoração
ENTÃO:
  - !important count: 45 → <20
  - Todos seletores consolidados (sem duplicação)
  - Cascade natural sem override conflicts
  - Zero regressão visual em qualquer breakpoint

E QUANDO executo testes de regressão
ENTÃO:
  - Botões Help/WhatsApp idênticos ✓
  - Galeria 2x2 grid visível ✓
  - Konfidance widget funciona ✓
  - Mobile/tablet layouts intactos ✓

E QUANDO analiso com Lighthouse
ENTÃO score não piora (≥85)
```

**Execução em Batches (CSS Safety Pattern):**

```
Batch 1 (Story 11.4.1): WhatsApp Button !important Removal
├─ Remover 40+ !important de body .btn-whatsapp-left em layout.tpl
├─ Validar em style-whatsapp-button.css (consolidar lá)
├─ Deploy + Gabriel validação
└─ Risk: MÉDIO (story 11.1 é pré-requisito)

Batch 2 (Story 11.4.2): Grid Media Queries Consolidation
├─ Unificar .pg-gallery-grid rules
├─ Consolidar @media queries (1200px, 992px, 768px)
├─ Remove duplicatas
├─ Deploy + Gabriel validação
└─ Risk: MÉDIO

Batch 3 (Story 11.4.3): Aspect Ratios + Final Cleanup
├─ Adicionar aspect-ratio: 1/1 em .pg-gallery-item
├─ Remover altura fixa rules (height: 100% etc)
├─ Cleanup comentários obsoletos
├─ Deploy + Gabriel validação
└─ Risk: BAIXO
```

**Arquivos Modificados:**
- `theme-deploy-corrigido/layouts/layout.tpl` — remover !important rules
- `theme-deploy-corrigido/static/css/style-whatsapp-button.css.tpl` — consolidar
- `theme-deploy-corrigido/static/css/style-critical.tpl` — cleanup

**Validação Gabriel (por Batch):**
- [ ] Batch 1: WhatsApp button funciona, sem !important
- [ ] Batch 2: Galeria grid OK, responsive funciona
- [ ] Batch 3: Aspect ratios corretos, sem layout shifts
- [ ] Geral: Lighthouse ≥85

**Rollback (por Batch):** `git reset --hard {commit-anterior}`

---

## 8. PLANO DE TESTES

### 8.1 Matriz de Viewport

| Teste | Desktop ≥1200px | Tablet 768-991px | Mobile <768px |
|-------|-----------------|------------------|---------------|
| **A) Botões Laterais** | Help/WhatsApp idênticos ✓ | Centralizados ✓ | Centralizados ✓ |
| **B) Galeria 2x2** | 4 imagens 2x2 ✓ | Swiper carousel ✓ | Swiper ✓ |
| **B) Scroll Isolado** | Galeria scroll isolada ✓ | N/A | N/A |
| **C) Konfidance** | Widget abaixo galeria ✓ | Responsivo ✓ | Responsivo ✓ |
| **D) Débito** | CSS !important <20 ✓ | Performance OK ✓ | Regressão 0 ✓ |

### 8.2 Testes Automatizados (npm run)

```bash
# Validação de build
npm run lint          # Detectar CSS/JS errors
npm run typecheck     # Type checking (se TypeScript)
npm test              # Unit tests (se configurados)

# Performance
npm run lighthouse    # Lighthouse score (script customizado)

# Regressão (manual em cada deploy)
# — Abrir https://patagang.com.br em 3 breakpoints
# — Comparar screenshots pré/pós
```

### 8.3 Testes Manuais por Story

#### Story 11.1 Regressão:
```
1. Abrir patagang.com.br/qualquer-produto
2. Inspecionar botão Help (lado direito):
   - Texto vertical? ✓
   - Sem rotate? ✓
3. Inspecionar botão WhatsApp (lado esquerdo):
   - Texto vertical? ✓
   - Sem rotate? ✓ (antes tinha rotate!)
4. Comparar visual: idênticos? ✓
5. Hover: ambos escurecem background? ✓
```

#### Story 11.2 Regressão:
```
1. Desktop ≥992px:
   - Galeria 2x2 visível? 4 imagens? ✓
   - Scroll galeria isolada (scroll page não sobe)? ✓
   - Lightbox funciona? ✓
2. Tablet (768-991px):
   - Swiper carousel? ✓ (sem mudança)
3. Mobile <768px:
   - Swiper carousel? ✓ (sem mudança)
4. Lighthouse score ≥85? ✓
```

#### Story 11.3 Regressão:
```
1. Abrir PDP
2. Scroll até abaixo da galeria
3. Konfidance widget visível? ✓
4. Avaliações carregam? ✓
5. Q&A section funciona? ✓
6. Mobile responsivo? ✓
7. Console errors? 0? ✓
```

#### Story 11.4 Regressão (Batches):
```
PER BATCH:
1. Deploy FTP nova versão
2. Executar testes 11.1 + 11.2 + 11.3 (regressão)
3. Lighthouse score mantido ✓
4. Se OK: próximo batch
5. Se FALHA: rollback + investigar
```

### 8.4 Smoke Test PDP (Regressão Completa)

**Executar após CADA story deploy:**

```
✓ Botões Help/WhatsApp
  - [ ] Help button lado direito, visual correto
  - [ ] WhatsApp button lado esquerdo, idêntico ao Help
  - [ ] Hover funciona
  - [ ] Mobile padding correto

✓ Galeria Imagens
  - [ ] Desktop: 4 imagens 2x2
  - [ ] Tablet: Swiper (se quebrou, rollback)
  - [ ] Mobile: Swiper OK
  - [ ] Lightbox: clique abre modal

✓ Info Card Direita
  - [ ] Preço, botões de ação visíveis
  - [ ] Mobile: info stacked corretamente
  - [ ] Botão comprar responde

✓ Konfidance (após 11.3)
  - [ ] Widget carrega abaixo galeria
  - [ ] Avaliações visíveis
  - [ ] Q&A funciona

✓ Performance
  - [ ] Nenhum console error
  - [ ] Lighthouse ≥85
  - [ ] CLS <0.1 (sem jumps)

✓ Mobile (geral)
  - [ ] Tudo scrollável, sem horizontal scroll
  - [ ] Touch targets ≥44px
  - [ ] Imagens responsive

→ Tudo OK? STORY DONE
→ Algo quebrou? ROLLBACK + investigar
```

---

## 9. OBSERVABILIDADE E VALIDAÇÃO

### 9.1 Checkpoints de Verificação

**Story 11.1 — Botões:**
```javascript
// Console check após deploy
const helpBtn = document.querySelector('.pg-help-btn__text');
const whatsappBtn = document.querySelector('.btn-whatsapp-left span');

console.log('Help transform:', window.getComputedStyle(helpBtn).transform);
// Expected: none
console.log('WhatsApp transform:', window.getComputedStyle(whatsappBtn).transform);
// Expected: none (ANTES: matrix(...) due to rotate)

// Visual: ambos devem parecer idênticos
```

**Story 11.2 — Galeria:**
```javascript
// Verificar grid template
const gallery = document.querySelector('.pg-gallery-grid');
console.log('Grid cols:', window.getComputedStyle(gallery).gridTemplateColumns);
// Expected: repeat(2, 1fr) ou similar

// Contar imagens visíveis
const items = document.querySelectorAll('.pg-gallery-item');
console.log('Gallery items:', items.length);
// Expected: ≥4

// Check scroll isolation
const container = document.querySelector('.pg-gallery-container');
console.log('Container height:', window.getComputedStyle(container).maxHeight);
// Expected: calc(100vh - XXpx)
```

**Story 11.3 — Konfidance:**
```javascript
// Verificar widget renderizado
const widget = document.querySelector('#pg-konfidance-reviews');
console.log('Konfidance loaded:', !!widget.children.length);
// Expected: true (tem elementos dentro)

// Performance: script defer carregado?
const script = document.querySelector('script[src*="konfidance"]');
console.log('Konfidance defer:', script?.defer);
// Expected: true
```

### 9.2 Métricas de Sucesso

| Métrica | Baseline | Target | Tool |
|---------|----------|--------|------|
| Lighthouse Score | 78 | ≥85 | DevTools Lighthouse |
| CLS (Cumulative Layout Shift) | 0.15 | <0.1 | Lighthouse / Web Vitals |
| LCP (Largest Contentful Paint) | 2.8s | <2.5s | Lighthouse |
| CSS !important count (PDP) | 45+ | <20 | Grep |
| Gallery grid columns | 1 or flex | 2x2 grid | DevTools Computed Styles |
| Konfidance load time | N/A | <1s (async) | Network tab |
| Visual regression | Base | 0 diffs | Percy/manual |

### 9.3 Logs & Debug

**Deploy Checkpoint Log:**
```markdown
## Deploy v1.5.186 (Story 11.1)

### Pre-Deploy
- [ ] Git clean (no uncommitted changes)
- [ ] CodeRabbit review: 0 CRITICAL
- [ ] 8/8 Nuvemshop constraints verified

### Deployment
- [ ] FTP upload: 2/2 files (layout.tpl, VERSION.json)
- [ ] HTTP 200 on patagang.com.br
- [ ] CSS validates (no syntax errors)

### Post-Deploy (Gabriel)
- [ ] Desktop: Help/WhatsApp visual check ✓
- [ ] Mobile: buttons centered ✓
- [ ] Lighthouse: ≥85 ✓

### Validation
- ✓ APPROVED → git push
- ✗ FAILED → rollback v1.5.185
```

---

## 10. PLANO DE ROLLOUT

### 10.1 Feature Flag / Estratégia Equivalente

**Abordagem (RECOMENDADA):** Deploy direto com validação Gabriel

```
Motivo:
- Stories são CSS/JS simples (sem A/B testing)
- Rollback é rápido (git reset + FTP deploy <5 min)
- Gabriel validação em real-time (serve como gate)
```

**Alternativa (se risco alto):** CSS class toggle

```html
<!-- Se implementar feature flag: -->
{% if feature_flag.gallery_2x2 %}
    <div class="pg-gallery-grid" style="grid-template-columns: repeat(2, 1fr);">
{% else %}
    <div class="pg-gallery-grid" style="display: flex;">
{% endif %}
```

### 10.2 Rollback Strategy

**Comando Rollback (por story):**
```bash
# Story 11.1 falha?
git reset --hard {commit-anterior}
node ftp-deploy/deploy.js "rollback: bottons divergence [Story 11.1]" --force

# Story 11.2 falha?
git reset --hard {commit-anterior}
node ftp-deploy/deploy.js "rollback: gallery 2x2 [Story 11.2]" --force

# Story 11.3 falha?
git reset --hard {commit-anterior}
node ftp-deploy/deploy.js "rollback: konfidance [Story 11.3]" --force

# Story 11.4.X falha?
git reset --hard {commit-anterior}
node ftp-deploy/deploy.js "rollback: css debt batch [Story 11.4.X]" --force
```

**Gabriel Approval Workflow:**
```
1. @dev commits + push (local)
2. @devops deploys FTP (auto-version)
3. Gabriel testa: ✓ APPROVED ou ❌ FAILED
   - ✓ → @devops git push + PR
   - ❌ → rollback + new attempt
```

---

## 11. CHECKLIST DE QUALIDADE

### Pre-Story Execution
- [ ] Story requirements entendidos (AC claro)
- [ ] Arquivos impactados mapeados
- [ ] CSS cascade analisado (sem !important surprises)
- [ ] Rollback plano documentado
- [ ] CodeRabbit pronto para review

### During Development
- [ ] Git commits atômicos, mensagens semânticas
- [ ] Teste local: desktop/tablet/mobile
- [ ] Console: 0 errors
- [ ] CodeRabbit run: 0 CRITICAL issues
- [ ] Nuvemshop 8/8 constraints verified

### Pre-Deploy
- [ ] Git status clean
- [ ] Regressão checklist executado
- [ ] Screenshot comparação (antes/depois)
- [ ] Performance baseline (Lighthouse)

### Deploy
- [ ] FTP deploy success (HTTP 200)
- [ ] VERSION.json atualizado
- [ ] Backup criado
- [ ] Gabriel notificado

### Validation (Gabriel)
- [ ] Desktop viewport
  - [ ] Botões/galeria/konfidance visual OK
  - [ ] Sem layout shifts
  - [ ] Performance OK
- [ ] Tablet viewport
  - [ ] Regressão check
  - [ ] Responsiveness OK
- [ ] Mobile viewport
  - [ ] Full mobile test
- [ ] Console
  - [ ] 0 errors
  - [ ] 0 warnings críticas

### Post-Approval
- [ ] Git push origin
- [ ] GitHub PR (se story finaliza)
- [ ] Documentation updated
- [ ] Story marked DONE in backlog

---

## 12. PERGUNTAS EM ABERTO / DECISÕES PENDENTES

### ❓ Galeria CSS Grid vs Flex

**Status:** ⏳ Agent 1 investigando

| Opção | Pros | Cons |
|-------|------|------|
| **CSS Grid** (recomendado) | 2x2 nativo, simples | Menos suporte IE11 (OK?) |
| **Flexbox** | Mais compatível | Precisa cálculo width (calc) |

**Decisão Pendente:** Qual usar? Conforme agent 1 descobrir.

### ❓ Konfidance Positioning

**Status:** ⏳ Agent 2 investigando

- Exatamente abaixo de `.pg-gallery-container`?
- Ou após `.pg-product-form`?
- Ou em seção separada `.pg-pdp-reviews`?

### ❓ Scroll Hijacking JS: Vanilla ou Library?

**Status:** Decision feita (Vanilla JS)

```javascript
// Vanilla JS 100 linhas — sem dependency
// Alternativa: Smooth Scroll Polyfill (se IE11 support needed)
```

### ❓ Débito Técnico: Quais !important são SAFE para remover?

**Status:** ⏳ Agent 3 analisando

- Todos em `body .btn-whatsapp-left`? ✓ SAFE
- Alguns em `.pg-pdp-image-col`? ❓ Precisa análise

### ❓ Aspect Ratio CSS Support

**Status:** Decision feita

```css
.pg-gallery-item {
    aspect-ratio: 1 / 1;  /* 95% browsers suportam */
    /* Fallback não necessário (Patagang ~2% IE11) */
}
```

---

## 13. RECOMENDAÇÕES FINAIS

### 🎯 Plano Recomendado (FULL EXECUTION)

```
Timeline: 3-4 semanas
┌─ Semana 1: Stories 11.1 (botões) + 11.2 (galeria)
│  ├─ 11.1: 1 dia (low risk)
│  └─ 11.2: 2-3 dias (medium risk, CSS grid)
│
├─ Semana 2: Story 11.3 (konfidance)
│  └─ 2 dias (medium risk, async plugin)
│
└─ Semana 3-4: Story 11.4 (débito técnico, 3 batches)
   ├─ Batch 1: 1 dia (WhatsApp !important)
   ├─ Batch 2: 1 dia (grid consolidation)
   └─ Batch 3: 0.5 dia (aspect ratios + cleanup)

Validação: Gabriel após CADA story
Risco Total: MÉDIO (CSS cascade, external plugin)
Rollback Ready: SIM (git + FTP < 5 min per story)
```

**Benefícios:**
- ✅ 100% visual consistency (botões)
- ✅ 95%+ galeria visibilidade (2x2 grid)
- ✅ Social proof integrado (Konfidance)
- ✅ Débito técnico reduzido 50%+

### 🛡️ Plano Alternativo (MENOR RISCO)

```
Se Gabriel preferir menor risco:
┌─ Fase 1: 11.1 (botões) ONLY
│  └─ 1 dia, BAIXO risco, resultado imediato
│
└─ Fase 2 (depois): 11.2 + 11.3 + 11.4
   └─ Se 11.1 aprovado, prosseguir com confiança
```

**Trade-off:** 3-4 semanas → 1 semana para 11.1, depois reavalia

### ⚡ Próxima Ação Imediata

**Após aprovação deste plano:**

1. ✅ Aguardar conclusão dos 3 agents em background
2. ✅ Ler relatórios de agents (galeria, konfidance, débito)
3. ✅ Integrar descobertas ao EPIC-11-PLANO-COMPLETO.md
4. ✅ @po cria stories individuais (11.1, 11.2, 11.3, 11.4.1/2/3)
5. ✅ @dev começa Story 11.1 (botões — lowest risk first)

---

## 📎 Apêndices (Gerados por Agents)

### 🔄 Agent 1 Output — Galeria 2x2 & Scroll

**Status:** ⏳ Em progresso
**Arquivo:** `C:\...\tasks\af6fd3606aeec97d1.output`
→ *Será integrado quando agent completar*

### 🔄 Agent 2 Output — Konfidance Integration

**Status:** ⏳ Em progresso
**Arquivo:** `C:\...\tasks\af67096257f04431c.output`
→ *Será integrado quando agent completar*

### 🔄 Agent 3 Output — Débito Técnico PDP

**Status:** ⏳ Em progresso
**Arquivo:** `C:\...\tasks\acb9ea7038768c570.output`
→ *Será integrado quando agent completar*

---

**Documento Gerado:** 2026-03-27
**Versão:** 1.0 (DRAFT — Aguardando agents)
**Próxima Revisão:** Após conclusão dos 3 agents

---

**Para continuar:** Aguardando notificação de conclusão dos agents 🔄


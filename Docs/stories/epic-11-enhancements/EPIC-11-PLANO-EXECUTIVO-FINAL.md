# 🎯 PLANO EXECUTIVO EPIC 11 — FINAL

**Status:** ✅ PRONTO PARA EXECUÇÃO
**Data:** 2026-03-27
**Responsável:** Arquiteto de Entrega AIOX
**Análise Consolidada:** 3 Agents + Manual Investigation

---

## RESUMO EXECUTIVO (2 MIN READ)

**4 Trilhas de Implementação na PDP:**

| Trilha | Objetivo | Risco | Timeline | Status |
|--------|----------|-------|----------|--------|
| **A** | Padronizar botões Help ≈ WhatsApp | 🟢 Baixo | 1 dia | ✅ Ready |
| **B** | Galeria 2x2: visibilidade + scroll | 🟡 Médio | 2-3 dias | 🟡 Em execução |
| **C** | Konfidance: reviews + Q&A | 🟡 Médio | 2 dias | ✅ Ready (plugin existe) |
| **D** | Débito técnico: refator CSS/JS | 🔴 Alto | 3+ dias | ⚠️ 22-35h débito |

**Risco Total:** MÉDIO-ALTO (CSS cascade, event listeners duplicados)
**Timeline Total:** 3-4 semanas (stories sequenciais + validação Gabriel)
**Rollback Ready:** SIM (git + FTP <5 min per story)

---

## PARTE I: TRILHA A — BOTÕES LATERAIS (SIMPLES ✅)

### Problema Identificado (revalidado em produção)

```
Help Button ("Posso ajudar?"):
  ✅ Texto: vertical-rl (sem rotate adicional)
  ✅ Spacing: margin-bottom 6px
  ✅ Estilo: background #F0F0F0

WhatsApp Button ("Compre pelo Whats"):
  ✅ Texto: vertical-rl + rotate(180deg) (requisito funcional no lado esquerdo)
  ❌ Ícone sem visibilidade na versão atual da loja
  ⚠️ Necessita validação de consistência visual com Help sem remover rotate
```

### Solução

**Manter `transform: rotate(180deg)` no WhatsApp esquerdo + restaurar ícone inline no botão:**
- Não remover rotate da 11.1 (regra funcional confirmada)
- Garantir ícone WhatsApp visível em desktop/tablet/mobile
- Ajustar somente o necessário para consistência visual com Help

**Story 11.1 Execution:**
```yaml
Prioridade: P0
Tamanho: S (1 dia)
Risco: BAIXO-MÉDIO
Arquivos:
  - snipplets/whatsapp-left.tpl
  - static/css/style-whatsapp-button.css.tpl
  - (se necessário) layouts/layout.tpl para override final

Tarefa:
  - Preservar rotate no texto do WhatsApp esquerdo
  - Corrigir visibilidade do ícone com SVG inline confiável
Validação:
  - Visual check Help vs WhatsApp
  - Ícone visível em todos breakpoints da PDP
Rollback: git reset --hard {anterior}
```

**Status de execução 11.1 (2026-03-27):**
- Branch: `feat/epic-11`
- Commit funcional/docs: `96cf417`
- Deploy FTP concluído com sucesso: versão `v1.5.189`
- Backup: `backups/deployment-1.5.189/2026-03-27T05-06-49`
- Validação Gabriel: ✅ aprovada (liberado push/PR da branch)

---

## PARTE II: TRILHA B — GALERIA 2x2 (MÉDIO ⚠️)

### Estado Atual (AS-IS)

**Grid 2x2 JÁ ESTÁ IMPLEMENTADO!**
```css
.pg-gallery-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);  /* ← JÁ EXISTE */
    gap: 14px;
}
```

✅ **Funcionando:** Grid, scroll isolado, lazy loading

### Problemas Identificados (Agent 1 Report)

#### 🔴 CRÍTICO: Conflito Media Queries

**Arquivo:** layout.tpl vs style-critical.tpl

```css
/* layout.tpl linha 247-252 — MOBILE */
@media (max-width: 768px) {
    .pg-gallery-container {
        overflow: visible;  /* Mostrar galeria */
    }
}

/* style-critical.tpl linha 3005-3012 — SOBRESCREVE */
@media (max-width: 991px) {
    .pg-gallery-container {
        display: none !important;           /* ← CONFLITO! */
        visibility: hidden !important;
    }
}
```

**Consequência:** Media query conflitante entre 991-992px breakpoint

#### 🟡 MÉDIO: Falta `grid-auto-rows`

```css
/* Antes: */
.pg-gallery-grid {
    grid-template-columns: repeat(2, 1fr);
    /* Falta: grid-auto-rows */
}

/* Resultado: Linhas com alturas diferentes (não uniformes) */

/* Depois: */
.pg-gallery-grid {
    grid-template-columns: repeat(2, 1fr);
    grid-auto-rows: 300px;  /* Linhas uniformes */
    gap: 14px;
}
```

#### 🟡 MÉDIO: Images sem aspect-ratio CSS

```css
/* Falta em product-image.tpl: */
.pg-gallery-item {
    aspect-ratio: 1 / 1;  /* Evita CLS quando lazy-loads */
}

.pg-gallery-img {
    width: 100%;
    height: 100%;
    object-fit: cover;  /* Preenche sem distorcer */
}
```

#### 🟡 BAIXO: Items sem styling

```html
<!-- Falta: -->
<div class="pg-gallery-item">
    <!-- Sem hover effects, borders, zoom icon -->
</div>
```

### Solução (Story 11.2)

**Fixes a Implementar:**

1. **Remover conflito media query**
   - Manter: `@media (min-width: 992px)` — mostra grid
   - Remover: `@media (max-width: 991px) { display: none }` — sobrescreve

2. **Adicionar grid-auto-rows**
   ```css
   .pg-gallery-grid {
       grid-auto-rows: 300px;  /* Linhas uniformes */
   }
   ```

3. **Adicionar aspect-ratio**
   ```css
   .pg-gallery-item {
       aspect-ratio: 1 / 1;
   }
   ```

4. **Scroll hijacking JS** (opcional)
   ```javascript
   // Prevent page scroll quando galeria está scrollando
   const gallery = document.querySelector('.pg-gallery-container');
   gallery?.addEventListener('wheel', (e) => {
       // Lógica: consumir scroll na galeria primeiro
   });
   ```

**Story 11.2 Execution:**
```yaml
Prioridade: P0 (UX core)
Tamanho: M (2-3 dias)
Risco: MÉDIO (CSS cascade, regressão visual)
Arquivos:
  - style-critical.tpl: adicionar grid-auto-rows, aspect-ratio
  - layout.tpl: remover media query conflitante
  - product-image.tpl: adicionar width/height em imgs (CLS fix)
  - NOVO: pdp-gallery-scroll.js (se implementar hijacking)

Validação: 4 imagens 2x2 visíveis, scroll isolado, sem FOUC
Rollback: git reset --hard {anterior}
```

---

## PARTE III: TRILHA C — KONFIDANCE REVIEWS (SIMPLES ✅)

### Estado Atual (AS-IS)

✅ **Plugin JÁ EXISTE** no Patagang!
- Infraestrutura: Suporte total NuvemShop
- Container: `<div id="reviewsapp">` existe
- Status: Foi removido antes, mas pode ser reintegrado facilmente

### Solução (Story 11.3)

**Posicionamento:** Abaixo product-form (conforme design)

```html
<!-- product.tpl — após product-form.tpl -->
<section class="pg-pdp-reviews-section">
    <div class="container">
        <h2>Avaliações e Perguntas</h2>
        <div id="reviewsapp"></div>
    </div>
</section>
```

**CSS Protection** (layout.tpl):
```css
{% if template == 'product' %}
    body #reviewsapp {
        position: relative !important;
        z-index: 10 !important;
        display: block !important;
    }

    .pg-pdp-reviews-section {
        background: #ffffff;
        margin-top: 2rem;
        padding: 2rem 0;
        border-top: 1px solid rgba(0,0,0,0.05);
    }
{% endif %}
```

**Story 11.3 Execution:**
```yaml
Prioridade: P1 (social proof)
Tamanho: M (2 dias)
Risco: MÉDIO (async plugin, externa)
Arquivos:
  - product.tpl: adicionar container #reviewsapp
  - layout.tpl: adicionar CSS protection
  - VERIF: Plugin ativado no Admin NuvemShop?

Validação: Widget renders, sem z-index conflict, responsive
Rollback: git reset --hard {anterior}

Dependência: Plugin Konfidance ativado em Configurações > Avaliações
```

---

## PARTE IV: TRILHA D — DÉBITO TÉCNICO (COMPLEXO 🔴)

### Diagnóstico Completo (Agent 3 Report)

**Débito Total:** 22-35 horas

#### 🔴 P0 - CRÍTICOS

1. **Excesso !important em PDP** (4-6h)
   - 28+ regras com `!important` desnecessário
   - Localização: style-critical.tpl linhas 3479-3520
   - Impacto: Cascata quebrada

2. **Event Listeners Duplicados** (3-4h)
   - store.js + product-page-custom.js escutam variantes
   - Causa: Race condition, reflow em cadeia
   - Risco regressão: CRÍTICO

3. **Images sem width/height** (1-2h)
   - Desktop: completamente sem atributos
   - Impacto: CLS crítico (0.25+)

#### 🟡 P1 - ALTOS

| Issue | Esforço | Risco | Impacto |
|-------|---------|-------|---------|
| Media query 991-992px | 1-2h | MÉDIO | ALTO |
| Modal gallery memory leak | 2-3h | MÉDIO | ALTO |
| Duplicação CSS | 3-5h | MÉDIO | ALTO |
| Gallery aspect-ratio missing | 30min | BAIXO | ALTO |
| Flex/grid nesting complexo | 4-6h | CRÍTICO | ALTO |
| ARIA labels incompletos | 1-2h | BAIXO | ALTO |
| style-critical.tpl tamanho | 4-6h | MÉDIO | MÉDIO |

#### 🟢 P2 - MÉDIOS/BAIXOS

| Issue | Esforço | Impacto |
|-------|---------|---------|
| Inline styles hardcoded | 2-3h | MÉDIO |
| Color swatches acessibilidade | 1h | MÉDIO |
| Keyboard nav gallery | 1-2h | MÉDIO |
| Console.log cleanup | 30min | BAIXO |

### Recomendação: Execução em Batches (Story 11.4)

**Abordagem:** Refatoração incremental (max 10-15 regras por batch)

```yaml
Story 11.4.1 — Batch 1: WhatsApp !important Removal
├─ Remover 40+ !important de body .btn-whatsapp-left em layout.tpl
├─ Consolidar em style-whatsapp-button.css.tpl
├─ Risco: MÉDIO (mas Story 11.1 é pré-requisito)
├─ Tamanho: 4 horas
└─ Deploy + Gabriel validação

Story 11.4.2 — Batch 2: Grid Media Queries Consolidation
├─ Unificar .pg-gallery-grid rules
├─ Consolidar @media queries
├─ Esforço: 3-4 horas
└─ Deploy + Gabriel validação

Story 11.4.3 — Batch 3: Event Listeners Consolidation
├─ Unificar store.js + product-page-custom.js
├─ Remover duplicação, add debounce
├─ Risco regressão: CRÍTICO
├─ Esforço: 4-5 horas
└─ Deploy + Gabriel validação
```

---

## PARTE V: PLANO DE EXECUÇÃO

### Timeline Recomendada

```
SEMANA 1:
├─ Story 11.1 (Botões) — 1 dia
│  └─ Deploy v1.5.186: Remove rotate
│  └─ Gabriel validação
│
└─ Story 11.2 (Galeria) — 2-3 dias
   ├─ Deploy v1.5.187: Media query fix
   ├─ Deploy v1.5.188: Grid auto-rows + aspect-ratio
   ├─ Deploy v1.5.189: Scroll hijacking (opcional)
   └─ Gabriel validação

SEMANA 2:
└─ Story 11.3 (Konfidance) — 2 dias
   ├─ Deploy v1.5.190: Container + CSS
   └─ Gabriel validação

SEMANA 3-4:
└─ Story 11.4 (Débito) — 3 batches
   ├─ Deploy v1.5.191: Batch 1 (!important removal)
   ├─ Deploy v1.5.192: Batch 2 (grid consolidation)
   ├─ Deploy v1.5.193: Batch 3 (event listeners)
   └─ Gabriel validação (cada batch)
```

### Order of Execution (AIOX Standard)

```
1. @po: *validate-story-draft para cada story
2. @dev: *develop-story (mode: interactive/yolo)
3. @qa: *qa-gate (7 checks)
4. @devops: FTP deploy + git push (APÓS Gabriel aprova)
5. Gabriel: Validação em PRODUÇÃO (https://patagang.com.br)
```

---

## PARTE VI: CHECKLIST DE QUALIDADE

### Pre-Story
- [ ] Story AC entendido
- [ ] Arquivos impactados mapeados
- [ ] CSS cascade analisado
- [ ] Rollback procedure documentado

### During Development
- [ ] Git commits atômicos (mensagens semânticas)
- [ ] Teste local: desktop/tablet/mobile
- [ ] Console: 0 errors
- [ ] CodeRabbit: 0 CRITICAL
- [ ] Nuvemshop 8/8 constraints verified

### Pre-Deploy
- [ ] Git clean (no uncommitted)
- [ ] Regressão checklist (full PDP test)
- [ ] Screenshot comparação
- [ ] Lighthouse baseline

### Deploy
- [ ] FTP success (HTTP 200)
- [ ] VERSION.json updated
- [ ] Backup created

### Validation (Gabriel)
- [ ] Desktop viewport: visual + performance
- [ ] Tablet viewport: regressão check
- [ ] Mobile viewport: full test
- [ ] Console: 0 errors
- [ ] Lighthouse score

---

## PARTE VII: PERGUNTAS FINAIS & DECISÕES

### ❓ Perguntas em Aberto

1. **Galeria Scroll Hijacking:** Implementar JS hijacking ou deixar padrão?
   - **Padrão:** Scroll natural da página (simples)
   - **Hijacking:** Scroll galeria prioritário (complexo)

2. **Débito Técnico Scope:** Fazer tudo ou apenas P0?
   - **Full:** 22-35h, 3 semanas extra
   - **P0 Only:** 8-10h, paralelo com trilhas A-C

3. **Konfidance ativado?** Verificar se plugin está ativo no Admin?
   - Necessário fazer antes de Story 11.3

### 🎯 Recomendação FINAL

**Plano Recomendado (FULL EXECUTION):**
```
Timeline: 3-4 semanas
Stories: 11.1 + 11.2 + 11.3 + 11.4 (3 batches)
Risco Total: MÉDIO
Rollback Ready: SIM

Benefícios:
✅ 100% visual consistency (botões)
✅ 95% galeria visibilidade (2x2 grid fixo)
✅ Social proof integrado (Konfidance)
✅ Débito técnico reduzido 50%+
```

**Plano Alternativo (MENOR RISCO):**
```
Timeline: 1 semana (11.1 only)
Se sucesso → prosseguir com 11.2-11.4
Benefício imediato: Botões consistentes
Risco: BAIXO
```

---

## PRÓXIMAS AÇÕES IMEDIATAS

1. ✅ **Gabriel aprova este plano?**
2. ⏳ **Verificar:** Plugin Konfidance ativado no Admin?
3. ⏳ **@po:** Criar stories individuais (11.1, 11.2, 11.3, 11.4.x)
4. ⏳ **@dev:** Começar Story 11.1 (botões — lowest risk first)

---

**Documento Final v1.0**
**Status:** ✅ PRONTO PARA EXECUÇÃO
**Aprovação Necessária:** Gabriel Cristofolini (CTO)


# Plano de Correção PDP Layout — Seção Trust-Strip
**Data:** 2026-03-20
**Status:** 📋 Planejamento AIOX Corrigido
**Objetivo:** Restaurar seção trust-strip + corrigir layout da página de produto
**Padrão:** AIOX Story Development Cycle (SDC)

---

## 🎯 Resumo Executivo

| Métrica | Valor |
|---------|-------|
| **Problema Real** | Falta seção `product-trust-strip` (4 fases) |
| **Root Cause** | HTML nunca foi implementado em `product.tpl` |
| **Impacto** | Espaço vazio + header invadindo conteúdo |
| **Severidade** | 🔴 CRÍTICA (visual quebrado) |
| **Estimativa** | 1-2 horas |
| **Risco** | BAIXO (é implementação, não alteração) |
| **Constraint Violation** | ✅ NENHUMA (não afeta checkout/footer) |

---

## 🔍 Root Cause Analysis (RCA)

### Achados Técnicos:

**Arquivo 1: `theme-deploy-corrigido/templates/product.tpl`**
```
Status: ❌ FALTANDO elemento principal
Localização: Deveria estar ANTES de .section-single-product
Conteúdo esperado: <div class="pg-trust-strip">...</div> com 4 items
Versão atual: NÃO EXISTE (verificado em todo arquivo)
```

**Arquivo 2: `theme-deploy-corrigido/static/css/style-critical.tpl`**
```
Status: ✅ CSS COMPLETO (órfão - sem usar)
Linhas: 4892-4974 (81 linhas de CSS para trust-strip)
Conteúdo: Classes .pg-trust-strip, .pg-trust-strip__content, .pg-trust-strip__item
Problema: CSS define layout flexbox + grid mobile, mas elemento não existe
```

### Por Que Aconteceu:

Hipótese 1: **Elemento nunca foi implementado** (desenvolvimento incompleto)
Hipótese 2: **Elemento foi removido em alteração anterior** (regressão)

Resultado: CSS órfão + espaço visual vazio + layout desalinhado

---

## 📋 Plano de Ação (2 Stories)

### **STORY 1: Implementar Seção Trust-Strip**
**Sprint:** P0 (prioritário)
**Responsável:** @dev
**Duração:** 45-60 min

**Acceptance Criteria:**
- [ ] Seção `product-trust-strip` restaurada/implementada em `product.tpl`
- [ ] HTML contém 4 itens (`pg-trust-strip__item`) com conteúdo:
  - Item 1: "3% do pedido doado"
  - Item 2: "Frete grátis acima de R$250"
  - Item 3: "Seguro comprador 100%"
  - Item 4: "30 dias para troca" (ou equivalente)
- [ ] Seção posicionada **ANTES** de `.section-single-product` (não dentro de col)
- [ ] CSS já exists (não precisa implementar) — apenas usar
- [ ] Nenhuma violação de Nuvemshop constraints

**Technical Details:**

```tpl
{# Adicionar em product.tpl ANTES de <div class="row section-single-product"> #}

{# ===== TRUST STRIP (4 itens de confiança) ===== #}
<div class="pg-trust-strip">
    <div class="pg-trust-strip__content">
        <span class="pg-trust-strip__item">
            🎁 3% do pedido doado para educação
        </span>
        <span class="pg-trust-strip__item">
            🚚 Frete grátis acima de R$250
        </span>
        <span class="pg-trust-strip__item">
            🛡️ Seguro comprador 100%
        </span>
        <span class="pg-trust-strip__item">
            ↩️ 30 dias para troca
        </span>
    </div>
</div>

{# ===== FIM TRUST STRIP ===== #}
```

**Files to Modify:**
- `theme-deploy-corrigido/templates/product.tpl`

**Testing:**
```
1. Abrir página PDP
2. Verificar: Seção "3% do pedido doado..." aparece?
3. Verificar: Está ENTRE header e imagem do produto?
4. Verificar: Layout desktop (4 items side-by-side)?
5. Verificar: Layout mobile (grid 2x2)?
6. Verificar: Não quebrou layout (espaço vazio foi?)
```

**Exit Criteria:** ✅ Trust-strip visível e posicionada corretamente

---

### **STORY 2: Corrigir CSS Orphaned & Layout**
**Sprint:** P1
**Responsável:** @dev
**Duração:** 30-45 min

**Acceptance Criteria:**
- [ ] CSS de `.pg-trust-strip` está **SENDO USADO** (não mais órfão)
- [ ] Espaçamento correto entre sections
- [ ] Header não invade seção do produto
- [ ] Layout responsivo mobile funciona (grid 2x2)
- [ ] Sem espaço vazio à direita da página

**Technical Details:**

O CSS já existe e está bem estruturado em `style-critical.tpl` (linhas 4892-4974):

```css
.pg-trust-strip {
    display: block;
    width: 100%;
    margin-top: 140px;      /* Compensação header */
    margin-bottom: 0px;
    padding: 8px 40px;
    background: transparent;
    z-index: 900;
    border-top: 1px solid #000;
    border-bottom: 1px solid #000;
}

.pg-trust-strip__content {
    display: flex;
    justify-content: space-between;
    align-items: center;
    width: 100%;
    max-width: 1400px;
    margin: 0 auto;
    flex-wrap: nowrap;
}

.pg-trust-strip__item {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 11px;
    font-weight: 600;
    text-transform: uppercase;
    color: #000;
    letter-spacing: 1px;
    white-space: nowrap;
    text-align: center;
}

/* Mobile: 2x2 grid */
@media (max-width: 768px) {
    .pg-trust-strip__content {
        display: grid !important;
        grid-template-columns: 1fr auto;
        grid-template-rows: auto auto;
        gap: 4px 12px;
        align-items: center;
    }
    .pg-trust-strip__item:nth-child(1),
    .pg-trust-strip__item:nth-child(2) {
        grid-column: 1;
        text-align: left;
    }
    .pg-trust-strip__item:nth-child(3),
    .pg-trust-strip__item:nth-child(4) {
        grid-column: 2;
        text-align: right;
    }
}
```

**Ações necessárias:**
1. Verificar se `margin-top: 140px` é correto (compensação header sticky)
2. Se header ainda invade, ajustar:
   - `z-index: 900` (aumentar se necessário)
   - OU `margin-top` para maior valor
3. Testar em mobile (grid 2x2 deve funcionar)
4. Validar que espaço vazio à direita desapareceu

**Files to Modify:**
- `theme-deploy-corrigido/static/css/style-critical.tpl` (se ajustes necessários)
- Provavelmente NÃO é necessário — CSS já está pronto

**Testing:**
```
Desktop:
1. Trust-strip deve mostrar 4 items side-by-side
2. Espaçamento igual entre items
3. Border top e bottom visíveis
4. Nenhum espaço vazio à direita

Mobile (< 768px):
1. Grid 2x2 (col1: items 1-2 esquerda | col2: items 3-4 direita)
2. Items alinhados corretamente
3. Nenhum overflow ou truncamento
4. Espaço vazio desapareceu

Header:
1. Header não sobrepõe trust-strip
2. z-index correto (trust-strip deve estar sobre produto)
3. Sem gaps não-intencionais
```

**Exit Criteria:** ✅ Layout corrigido, sem espaço vazio, header não invade

---

## 📁 Arquivos Afetados

### A Modificar:
1. **`theme-deploy-corrigido/templates/product.tpl`**
   - Adicionar HTML da trust-strip (antes de `.section-single-product`)
   - ~20 linhas de código

2. **`theme-deploy-corrigido/static/css/style-critical.tpl`** (opcional)
   - Revisar valores de `margin-top`, `z-index`
   - Provavelmente não é necessário modificar

### Não Modificar:
- Checkout (intacto)
- Footer (intacto)
- Nenhuma forma Nuvemshop

---

## ✅ Quality Gates

### Gate 1: Análise Concluída
- [ ] Trust-strip identificado como faltante
- [ ] CSS validado (existe e está completo)
- [ ] Localização correta em product.tpl determinada
- [ ] → Aprova para Story 1

### Gate 2: Story 1 Completa
- [ ] HTML trust-strip implementado
- [ ] 4 items visíveis na página
- [ ] Posicionamento correto
- [ ] → Aprova para Story 2

### Gate 3: Story 2 Completa (QA)
- [ ] Desktop: 4 items lado-a-lado ✅
- [ ] Mobile: grid 2x2 ✅
- [ ] Header não invade ✅
- [ ] Espaço vazio foi ✅
- [ ] Nenhuma regressão ✅
- [ ] → Aprova para Deploy

### Gate 4: Pre-Deploy
- [ ] Arquivos prontos
- [ ] Nenhuma violação Nuvemshop
- [ ] Backup criado
- [ ] Git staged
- [ ] → Aprova para deployment

---

## 🚀 Rotina de Deploy (Simplificada)

Diferente do plano anterior — este é **SIMPLES** porque são apenas 2 arquivos:

### Fase 1: Backup
```bash
TIMESTAMP=$(date +%s)
tar -czf backups/pdp-trust-strip-fix-${TIMESTAMP}.tar.gz \
  theme-deploy-corrigido/templates/product.tpl \
  theme-deploy-corrigido/static/css/style-critical.tpl
```

### Fase 2: Upload FTP
```bash
ftp -v -n < <<EOF
open ftp.nuvemshop.com.br
quote USER {FTP_USER}
quote PASS {FTP_PASSWORD}
binary
cd /templates/006/603/800/twig/
put theme-deploy-corrigido/templates/product.tpl
put theme-deploy-corrigido/static/css/style-critical.tpl
bye
EOF
```

### Fase 3: Git & Versioning
```bash
git add theme-deploy-corrigido/templates/product.tpl
git commit -m "fix: Restaurar seção trust-strip na página de produto [Story 1-2]"
npm version patch -m "v1.1.6a: PDP layout fix - trust-strip restored"
git push origin main
```

### Fase 4: Console Output
```
═══════════════════════════════════════════════════════════════════
  🚀 PATAGANG ECOMMERCE — PDP LAYOUT FIX DEPLOYMENT
═══════════════════════════════════════════════════════════════════

📋 DEPLOYMENT: Trust-Strip Restoration
🕐 Timestamp: 2026-03-20T{TIME}Z
👤 Deployed by: @devops

═══════════════════════════════════════════════════════════════════
PHASE 1: Backup
═══════════════════════════════════════════════════════════════════
✅ BACKUP CRIADO:
   📦 backups/pdp-trust-strip-fix-{TIMESTAMP}.tar.gz
   📊 Size: 18 KB
   Arquivos: product.tpl, style-critical.tpl

═══════════════════════════════════════════════════════════════════
PHASE 2: FTP Upload
═══════════════════════════════════════════════════════════════════
🔗 Conectando a: ftp.nuvemshop.com.br
✅ Autenticado
📤 Upload:
   ✅ product.tpl (12.3 KB)
   ✅ style-critical.tpl (45.2 KB)
✅ Upload completo

═══════════════════════════════════════════════════════════════════
PHASE 3: Git Versioning
═══════════════════════════════════════════════════════════════════
✅ Commit: abc123def456...
   "fix: Restaurar seção trust-strip na página de produto [Story 1-2]"
✅ Version: 1.1.5 → 1.1.6a
✅ Push: origin/main

═══════════════════════════════════════════════════════════════════
🎉 DEPLOYMENT COMPLETO COM SUCESSO
═══════════════════════════════════════════════════════════════════
Status: ✅ DEPLOYED
Version: v1.1.6a
Time: 2026-03-20 {TIME} UTC

Verificar em: https://www.patagang.com.br/produtos/...
Rollback: tar -xzf backups/pdp-trust-strip-fix-{TIMESTAMP}.tar.gz

═══════════════════════════════════════════════════════════════════
```

---

## 📈 Timeline

| Fase | Duração | Responsável |
|------|---------|-------------|
| Story 1: Implementar trust-strip | 45-60 min | @dev |
| Story 2: Corrigir CSS/layout | 30-45 min | @dev |
| QA: Validação | 15-20 min | @qa |
| Deploy: FTP + Git | 15-20 min | @devops |
| **TOTAL** | **1h 45min - 2h 25min** | **Hoje** |

**Muito mais rápido que o plano anterior!** ⚡

---

## 🎁 Mudanças vs Plano Anterior

| Aspecto | Plano Anterior (ERRADO) | Novo Plano (CORRETO) |
|--------|------------------------|----------------------|
| **Problema Identificado** | ❌ Botão, preço, variantes | ✅ Falta trust-strip |
| **Stories** | 7 stories | 2 stories |
| **Duração** | 4-5 horas | 1.5-2.5 horas |
| **Complexidade** | Alta (JS binding) | Baixa (HTML + CSS) |
| **Risk** | Médio | Baixo |
| **Arquivos** | 3+ files | 1-2 files |

---

## 🔐 Compliance AIOX

✅ **Article I (CLI First):** Deploy via bash
✅ **Article III (Story-Driven):** 2 stories estruturadas
✅ **Article V (Quality First):** 3 gates de aprovação
✅ **Article VI (Absolute Imports):** Nenhuma violação Nuvemshop

---

## 📊 Conteúdo da Trust-Strip (Sugestão)

Baseado no CSS (4 items, uppercase, 11px):

```
Item 1: 🎁 3% DO PEDIDO DOADO PARA EDUCAÇÃO
Item 2: 🚚 FRETE GRÁTIS ACIMA DE R$250
Item 3: 🛡️ SEGURO COMPRADOR 100%
Item 4: ↩️ 30 DIAS PARA TROCA

OU (sem emojis se preferir mais minimalista):

Item 1: 3% DOADO PARA EDUCAÇÃO
Item 2: FRETE GRÁTIS EM PEDIDOS ACIMA DE R$250
Item 3: SEGURO COMPRADOR 100%
Item 4: 30 DIAS PARA TROCAR
```

---

## 🚨 Rollback Plan

Se algo der errado:

```bash
# Restaurar backup
tar -xzf backups/pdp-trust-strip-fix-{TIMESTAMP}.tar.gz -C .

# Re-upload via FTP
ftp ftp.nuvemshop.com.br
# ... upload dos arquivos

# Git revert
git revert {commit-hash}
```

---

## ✨ Próximos Passos

1. **@dev:** Comece Story 1 — Implementar trust-strip
   - Abrir `product.tpl`
   - Adicionar HTML trust-strip (antes de `.section-single-product`)
   - Testar em browser
2. **@dev:** Proceda com Story 2 — Revisar CSS
3. **@qa:** Validar quando @dev terminar
4. **@devops:** Deploy quando QA PASS

---

**Plano corrigido e pronto para execução!** ✅

---

*AIOX Story Development Cycle — Versão 2.0 (Revisada)*
*Problema Real: Falta seção trust-strip na página de produto*

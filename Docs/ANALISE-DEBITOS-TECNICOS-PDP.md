# 📋 Análise de Débitos Técnicos — Página de Produto (PDP)

**Data:** 2026-03-27
**Status:** Análise Completa
**Objetivo:** Refatorar estrutura HTML/CSS mantendo UX/UI visual identico

---

## 🔍 Problemas Identificados

### Problema 1: Estrutura HTML com Sobreposição de Elementos

**Estrutura atual (problemática):**
```
<main class="patagang-section-content"> (padding-top: 0 na página de produto)
  ├── <product-identity-banner> (margin-top: 4px) ← Fica quase encostado no header
  └── <div id="single-product" class="pg-pdp-container"> (padding-top: 0)
      ├── <product-informative-banner> ← **AQUI: invade o header!**
      ├── <div class="section-single-product"> (padding-top: 80px no tablet/mobile)
      └── ...
```

**Problemas:**
- ❌ Main tem `padding-top: 0` na página de produto (line 3700-3701)
- ❌ Identity banner fica colado no header (margin-top: 4px não é suficiente)
- ❌ Product-informative-banner herda espaçamento insuficiente
- ❌ z-index: 100 não funciona porque há stacking context conflitante
- ❌ Cascata de padding/margin conflitante (80px em pg-pdp-container vs 0px em main)

---

## 🏗️ Solução Proposta

### Refatoração: Criar Espaçamento Explícito no Main

**Nova estrutura (refatorada):**
```
<main class="patagang-section-content"> (padding-top: RESTAURADO 160px/140px/130px)
  ├── <product-identity-banner> (margin: 0) ← Sem margin, main compensa
  └── <div id="single-product" class="pg-pdp-container"> (padding-top: 0)
      ├── <product-informative-banner> (margin: 0, z-index: 10) ← Visível corretamente
      ├── <div class="section-single-product"> (padding-top: 40px)
      └── ...
```

**Vantagens:**
- ✅ Separação clara de responsabilidades (main cuida do header offset, banners do seu espaço interno)
- ✅ Z-index funciona corretamente (banner em z:10, header em z:9999)
- ✅ Cascata CSS previsível e testável
- ✅ Mantém visual identico
- ✅ Reduz conflito de espaçamentos

---

## 📝 Mudanças Necessárias

### 1. Restaurar `padding-top` na main para página de produto

**Arquivo:** `static/css/style-critical.tpl` (linhas 3700-3733)

**Antes:**
```css
body.template-product main.patagang-section-content {
  padding-top: 0;  /* ❌ Causa problema: header sem offset */
}

@media (max-width: 991px) {
  body.template-product main.patagang-section-content {
    padding-top: 0;  /* ❌ Tablet: sem offset */
  }
}

@media (max-width: 576px) {
  body.template-product main.patagang-section-content {
    padding-top: 0;  /* ❌ Mobile: sem offset */
  }
}
```

**Depois:**
```css
body.template-product main.patagang-section-content {
  padding-top: 160px;  /* ✅ Compensa header fixo */
}

@media (max-width: 991px) {
  body.template-product main.patagang-section-content {
    padding-top: 140px;  /* ✅ Tablet: ligeiramente menos */
  }
}

@media (max-width: 576px) {
  body.template-product main.patagang-section-content {
    padding-top: 130px;  /* ✅ Mobile: header mais compacto */
  }
}
```

### 2. Ajustar identity banner (remover margin-top)

**Arquivo:** `static/css/style-critical.tpl` (linhas 3568-3668)

**Antes:**
```css
.pg-identity-banner {
  margin-top: 120px;  /* ❌ Base: conflita com padding-top: 160px */
}

@media (max-width: 576px) {
  .pg-identity-banner {
    margin-top: 4px;  /* ❌ Mobile: insuficiente */
  }
}
```

**Depois:**
```css
.pg-identity-banner {
  margin-top: 0;  /* ✅ Main já compensa header via padding-top */
  margin-bottom: 16px;  /* ✅ Espaço depois do banner */
}

@media (max-width: 576px) {
  .pg-identity-banner {
    margin-top: 0;
    margin-bottom: 12px;
  }
}
```

### 3. Product informative banner (simplificar)

**Arquivo:** `static/css/style-critical.tpl` (linhas 2041-2080)

**Antes:**
```css
div.product-informative-banner {
  margin-top: 130px;  /* ❌ Conflita com padding-top: 80px em pg-pdp-container */
  z-index: 100;  /* ❌ Não funciona porque main tem padding-top: 0 */
}

@media (max-width: 576px) {
  div.product-informative-banner {
    margin-top: 0;
    margin-bottom: 0.5rem;
  }
}
```

**Depois:**
```css
div.product-informative-banner {
  margin-top: 0;  /* ✅ Main compensa header, banner sem offset extra */
  margin-bottom: 16px;  /* ✅ Espaço abaixo */
  z-index: 10;  /* ✅ Acima de elementos comuns, logo abaixo do header */
  position: relative;
}

@media (max-width: 576px) {
  div.product-informative-banner {
    margin-top: 0;
    margin-bottom: 12px;
  }
}
```

### 4. Section single product (remover padding conflitante)

**Arquivo:** `static/css/style-critical.tpl` (linhas 2888-2910)

**Antes:**
```css
.pg-pdp-container .section-single-product {
  padding: 40px 20px;  /* ❌ 40px no mobile é muito */
}

@media (max-width: 991px) {
  .pg-pdp-container .section-single-product {
    padding: 20px 0 !important;  /* ❌ Conflita com pg-pdp-container padding-top: 80px */
  }
}
```

**Depois:**
```css
.pg-pdp-container .section-single-product {
  padding: 40px 20px;  /* ✅ Espaço interno */
}

@media (max-width: 991px) {
  .pg-pdp-container .section-single-product {
    padding: 20px 0;  /* ✅ Sem !important, padrão claro */
  }
}

@media (max-width: 576px) {
  .pg-pdp-container .section-single-product {
    padding: 16px 0;  /* ✅ Mobile: reduzido mas respirável */
  }
}
```

---

## 📊 Comparação: Antes vs Depois

| Elemento | Antes | Depois | Impacto |
|----------|-------|--------|---------|
| main padding-top | 0 (PDP) | 160/140/130px | ✅ Espaço correto para header |
| identity-banner margin | 4px (mobile) | 0 | ✅ Main compensa |
| product-informative-banner | margin: 130px / z-index: 100 | margin: 0 / z-index: 10 | ✅ Visível acima do header |
| section-single-product padding | 40px/20px | Responsivo 40/20/16px | ✅ Espaçamento claro |
| **Visual final** | Banner atrás do header ❌ | Banner acima, header visível ✅ | **RESOLVIDO** |

---

## 🎯 Resultado Esperado

✅ **Banner informativo não invade header**
✅ **Galeria continua funcionando**
✅ **Info card continua funcionando**
✅ **Visual UX/UI identico**
✅ **Código mais manutenível e previsível**
✅ **Abre caminho para futuras refatorações**

---

## 📌 Próximas Etapas

1. **Implementar refatoração** (Story 10.3 Final)
2. **Validar em produção** (Gabriel)
3. **Sanear débitos técnicos futuros:**
   - Remover classes Bootstrap redundantes
   - Consolidar espaçamento responsive
   - Documentar CSS cascade pattern
   - Criar design system para spacing

---

**Status:** ✅ Pronto para implementação
**Responsável:** @dev (Dex)
**Validação:** Gabriel Cristofolini

# Investigação: Ajustes UX/UI Identificados na Validação

**Data:** 2026-03-26
**Status:** 📋 ANÁLISE COMPLETA - PRONTO PARA IMPLEMENTAÇÃO
**Reporter:** Gabriel Cristofolini (Validação)
**Investigador:** Claude (Orion @aiox-master)

---

## 🎯 RESUMO EXECUTIVO

3 ajustes críticos identificados na validação UX/UI:

| # | Grupo | Ajuste | Prioridade | Arquivos Afetados |
|---|-------|--------|-----------|-------------------|
| 1 | Banner | Remover "•", aumentar espaçamento, reduzir font | 🔴 HIGH | `header-advertising.tpl`, `style-critical.tpl` |
| 1.2 | Banner | Fundo transparente (like header) | 🔴 HIGH | `style-critical.tpl` |
| 2 | Galeria | Galeria 2x2 não ocupa altura total | 🟠 MEDIUM | `style-critical.tpl` |
| 3 | Galeria | Modal abre com sidebar (impactando layout) | 🔴 HIGH | `store.js.tpl`, `product.tpl` |

---

## 📍 AJUSTE #1: BANNER DE AVISO (Ad Bar)

### 1.1 Remover "•" e ajustar espaçamento entre frases

#### Arquivo
- **Template:** `snipplets/header/header-advertising.tpl`
- **CSS:** `theme-deploy-corrigido/static/css/style-critical.tpl` (linhas 1672-1769)
- **JS:** `static/js/store.js.tpl` (arquivo principal)

#### Estrutura HTML
```html
<!-- header-advertising.tpl (linhas 1-15) -->
<section class="section-advertising">
  {% if settings.ad_bar and settings.ad_text %}
    <div class="section-advertising__marquee">
      {% if settings.ad_url %}
        <a class="link-contrast section-advertising__link" href="{{ settings.ad_url | setting_url }}">
      {% endif %}
      <div class="section-advertising__track">
        <span class="section-advertising__copy">{{ settings.ad_text }}</span>
      </div>
      {% if settings.ad_url %}
        </a>
      {% endif %}
    </div>
  {% endif %}
</section>
```

**Ponto Crítico:** O texto vem de `{{ settings.ad_text }}` (configuração do Nuvemshop)
- Texto atual: "Frete grátis acima de R$250       •       10% OFF no PIX       •       30 dias para trocas e devoluções"
- Esperado: "Frete grátis acima de R$250              10% OFF no PIX              30 dias para trocas e devoluções"

#### CSS Atual (style-critical.tpl)
```css
/* Linha 1698-1706 */
.section-advertising__copy {
  display: block;
  font-size: 0.875rem;           /* ← Pode ser muito grande */
  font-weight: 600;
  letter-spacing: 0.3px;
  color: #000;
  margin: 0;
  line-height: 1.4;
}

/* Mobile breakpoint (linhas 1724-1737) */
@media (max-width: 576px) {
  .section-advertising__copy {
    font-size: 0.75rem;
  }
}

/* Tablet breakpoint (linhas 1740-1753) */
@media (min-width: 577px) and (max-width: 991px) {
  .section-advertising__copy {
    font-size: 0.8rem;
  }
}

/* Desktop breakpoint (linhas 1756-1769) */
@media (min-width: 992px) {
  .section-advertising__copy {
    font-size: 0.875rem;
  }
}
```

#### Estratégia de Implementação

**❌ EVITAR:**
- JavaScript para substituir texto (risco de erro como mencionado por Gabriel)
- Soluções com regex ou manipulação dinâmica de DOM

**✅ USAR:**
- **Opção A:** Modificar o texto na configuração do Nuvemshop (Admin → Tema)
- **Opção B:** Se precisar de solução via CSS/HTML:
  - Usar `word-spacing` para aumentar espaçamento
  - Usar `letter-spacing` para ajustar
  - Reduzir `font-size` para caber em uma linha

**Valores Recomendados:**
```css
.section-advertising__copy {
  font-size: 0.7rem;          /* Reduzido de 0.875rem */
  word-spacing: 0.3em;        /* Aumenta espaço entre palavras */
  letter-spacing: 0.2px;      /* Ligeiramente reduzido */
  white-space: nowrap;        /* Garante uma linha */
  overflow: hidden;
  text-overflow: ellipsis;
}
```

---

### 1.2 Fundo transparente (acompanhando header)

#### Análise Atual
```css
/* Linha 1672-1678 */
.section-advertising {
  background-color: transparent;  /* ✅ JÁ ESTÁ TRANSPARENTE! */
  padding: 10px 20px;
  width: 100%;
  max-width: 100%;
  box-sizing: border-box;
}
```

**⚠️ PROBLEMA IDENTIFICADO:**
- CSS diz `transparent`, mas Gabriel relatou que tem cor
- **Possível causa:** Elemento pai (`.section-advertising`) ou layout.tpl tem background color
- **Ou:** CSS em outro arquivo está sobrescrevendo (checar style-async.scss.tpl, style-colors.scss.tpl)

#### Arquivos a Verificar
```
theme-deploy-corrigido/layouts/layout.tpl          (linhas 79-100, 230-250)
theme-deploy-corrigido/static/css/style-colors.scss.tpl
theme-deploy-corrigido/static/css/style-async.scss.tpl
```

#### Solução Proposta
```css
/* Reforçar transparência com !important */
.section-advertising {
  background-color: transparent !important;
  background-image: none !important;
  /* Remover qualquer background que possa estar herdado */
}

/* Se estiver vindo do pai, também reforçar */
.patagang-section-top {
  background-color: transparent !important;
}
```

---

## 📍 AJUSTE #2: GALERIA - HEIGHT MISMATCH

### Galeria 2x2 não ocupa altura total do card

#### Arquivo
- **CSS:** `theme-deploy-corrigido/static/css/style-critical.tpl` (linhas 2807-2905)
- **Template:** `theme-deploy-corrigido/templates/product.tpl` (linhas 12-13)

#### Estrutura HTML
```html
<!-- product.tpl -->
<div class="row section-single-product g-0">
  <div class="col-12 col-lg-7 pg-pdp-image-col">
    {% include 'snipplets/product/product-image.tpl' %}
  </div>
  <div class="col-12 col-lg-5 pg-pdp-info-col">
    <div class="pg-pdp-info-card">
      {# Card de informações #}
    </div>
  </div>
</div>
```

#### CSS Atual (Desktop)
```css
/* Linhas 2842-2878 */
@media (min-width: 992px) {
  .pg-pdp-container .section-single-product.row {
    display: flex;
    flex-direction: row;
    flex-wrap: nowrap;
    align-items: stretch;  /* ✅ Ambas colunas mesma altura */
    gap: 40px;
    padding: 10px 40px;
    margin-top: 0;
  }

  .pg-pdp-container .pg-pdp-image-col {
    flex: 0 0 60%;
    max-width: 60%;
    width: 60%;
    padding: 0;
    height: 100%;  /* ✅ Ocupa altura total */
    display: flex;
    flex-direction: column;
    position: sticky;
    top: 120px;
    align-self: stretch;
  }

  .pg-pdp-container .pg-pdp-info-col {
    flex: 0 0 40%;
    max-width: 40%;
    width: 40%;
    padding: 0;
    height: 100%;  /* ✅ Ocupa altura total */
    display: flex;
    flex-direction: column;
    align-self: stretch;
  }
}
```

#### Problema Identificado
```
Na galeria interna (product-image.tpl):
- Há um .pg-gallery-container com max-height: 520px
- Quando o card info é mais alto que 520px, sobra espaço branco
- A galeria não cresce para acompanhar a altura do card
```

#### Solução Proposta
```css
/* Forçar galeria a ocupar altura total da coluna */
@media (min-width: 992px) {
  .pg-pdp-image-col .pg-gallery-container {
    height: 100%;           /* Ocupar 100% da altura da coluna */
    max-height: none;       /* Remover limite de altura */
    overflow-y: auto;       /* Scroll se necessário */
  }

  .pg-pdp-image-col .pg-gallery-grid {
    height: 100%;
    align-content: flex-start;
  }
}
```

---

## 📍 AJUSTE #3: MODAL DE GALERIA - SIDEBAR VISÍVEL

### Ao clicar em imagem, abre modal com sidebar (impactando layout)

#### Arquivo
- **JS:** `theme-deploy-corrigido/static/js/store.js.tpl` (linhas 1755-1861)
- **Template:** `theme-deploy-corrigido/templates/product.tpl` (linhas 39-92)
- **CSS:** `theme-deploy-corrigido/static/css/style-critical.tpl` (linhas 4622-4650)

#### Estrutura HTML do Modal
```html
<!-- product.tpl linhas 39-92 -->
<div id="pg-modal-gallery" class="pg-modal-gallery" aria-hidden="true">
  <div class="pg-modal-backdrop js-close-modal-gallery"></div>
  <div class="pg-modal-container">

    <!-- SIDEBAR COM THUMBNAILS (← PROBLEMA) -->
    <div class="pg-modal-sidebar">
      <div class="pg-modal-thumbs">
        {% for image in product.images %}
        <button class="pg-modal-thumb js-modal-thumb ...">
          <img src="{{ image | product_image_url('small') }}" />
        </button>
        {% endfor %}
      </div>
    </div>

    <!-- IMAGEM PRINCIPAL -->
    <div class="pg-modal-main">
      <img id="pg-modal-main-image" class="pg-modal-main-img" />
      <button class="pg-modal-nav pg-modal-nav--prev"></button>
      <button class="pg-modal-nav pg-modal-nav--next"></button>
    </div>

    <button class="pg-modal-close js-close-modal-gallery"></button>
    <div class="pg-modal-counter">
      <span id="pg-modal-current">1</span> / <span id="pg-modal-total">{{ product.images_count }}</span>
    </div>
  </div>
</div>
```

#### JavaScript Atual (store.js.tpl linhas 1755-1861)
```javascript
(function() {
  const modal = document.getElementById('pg-modal-gallery');
  const thumbs = modal.querySelectorAll('.js-modal-thumb');
  const closeButtons = modal.querySelectorAll('.js-close-modal-gallery');

  // ABRE SEMPRE COM TODA ESTRUTURA VISÍVEL (sidebar + main)
  function openModal(index) {
    currentIndex = index;
    updateMainImage();
    modal.classList.add('is-open');           // Mostra modal com tudo
    modal.setAttribute('aria-hidden', 'false');
    document.body.style.overflow = 'hidden';
  }

  // Thumbnails aparecem clicáveis
  thumbs.forEach((thumb, index) => {
    thumb.addEventListener('click', function() {
      currentIndex = index;
      updateMainImage();  // ← Navega na sidebar visível
    });
  });
})();
```

#### Problema
- Modal abre com `.pg-modal-sidebar` visível (impactando layout em mobile/desktop)
- Esperado: Apenas a imagem clicada aparece grande, sem sidebar de thumbnails

#### Solução Proposta

**Opção A: Esconder sidebar via CSS (mais simples)**
```css
#pg-modal-gallery[aria-hidden="false"] .pg-modal-sidebar {
  display: none !important;  /* Esconde sidebar quando modal abre */
}

#pg-modal-gallery[aria-hidden="false"] .pg-modal-main {
  width: 100%;  /* Imagem ocupa 100% */
}
```

**Opção B: Modificar JS para não mostrar sidebar**
```javascript
// No openModal():
function openModal(index) {
  currentIndex = index;
  updateMainImage();
  modal.classList.add('is-open');

  // Esconder sidebar
  const sidebar = modal.querySelector('.pg-modal-sidebar');
  if (sidebar) sidebar.style.display = 'none';

  modal.setAttribute('aria-hidden', 'false');
  document.body.style.overflow = 'hidden';
}

// Ao fechar, mostrar novamente
function closeModal() {
  modal.classList.remove('is-open');
  modal.setAttribute('aria-hidden', 'true');

  // Mostrar sidebar novamente para proximas aberturas
  const sidebar = modal.querySelector('.pg-modal-sidebar');
  if (sidebar) sidebar.style.display = '';

  document.body.style.overflow = '';
}
```

**⚠️ Recomendação:** Opção A é mais segura (CSS only, evita JavaScript como mencionado por Gabriel)

---

## 📋 PLANO DE IMPLEMENTAÇÃO

### Fase 1: Ajuste #1 - Banner
```
1. Opção mais segura: Modificar texto no Admin Nuvemshop
   - Remover "•" manualmente
   - Aumentar espaçamento entre frases

2. Se não puder modificar admin:
   - Reduzir font-size: 0.7rem (de 0.875rem)
   - Adicionar word-spacing
   - Forçar white-space: nowrap

3. Fundo transparente:
   - Adicionar !important em background-color: transparent
   - Verificar style-colors.scss.tpl
   - Reforçar em layout.tpl se necessário
```

### Fase 2: Ajuste #2 - Galeria Height
```
1. Localizar .pg-gallery-container em product-image.tpl
2. Adicionar CSS:
   - height: 100%
   - max-height: none
   - overflow-y: auto
3. Testar em desktop
```

### Fase 3: Ajuste #3 - Modal Sidebar
```
1. Opção A (Recomendada - CSS only):
   - Display: none na sidebar quando modal abre
   - Width: 100% na imagem principal

2. Testar em mobile e desktop
3. Verificar navegação (arrows, thumbnails)
```

---

## ⚠️ AVISOS IMPORTANTES

1. **JavaScript em Banner (Gabriel alertou):**
   - ❌ EVITAR substituição de texto via JS
   - ✅ USAR configuração do Nuvemshop ou CSS puro

2. **Modal Modal Sidebar:**
   - Sidebar é renderizada no HTML (não pode remover)
   - Apenas esconder via CSS é seguro
   - Ou modificar JS, mas apenas a lógica de display

3. **Testing:**
   - Todos os ajustes precisam ser validados em:
     - Mobile (< 430px)
     - Tablet (768px)
     - Desktop (1200px+)

---

## 📌 PRÓXIMAS AÇÕES

1. ✅ Gabriel aprova plano de implementação
2. [ ] Implementar Ajuste #1 (Banner)
3. [ ] Implementar Ajuste #2 (Galeria Height)
4. [ ] Implementar Ajuste #3 (Modal Sidebar)
5. [ ] Deploy v1.5.150
6. [ ] Gabriel valida em produção

---

**Documento Pronto para Implementação**
*Aguardando confirmação de Gabriel para proceder*

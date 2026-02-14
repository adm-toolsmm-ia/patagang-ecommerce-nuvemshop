# Listagem (categoria e busca) – Referência atual

Mapa completo da listagem de produtos. Use como fonte única para saber onde alterar estilos, estrutura e comportamento.

**Última atualização:** 2026-02-14 (refatoração: escopo único, sem genéricos)  
**Fonte:** `theme-deploy-corrigido/`

---

## 1. Quando a página é usada

| Template | URL | Body class |
|----------|-----|------------|
| Categoria | `/categoria-slug` (ex.: `/produtos-cachorros`) | `body.template-category` |
| Busca | `/search?q=termo` | `body.template-search` |

Ambos usam a mesma estrutura de grid e compartilham os mesmos CSS; os estilos são escopados com `body.template-category, body.template-search`.

---

## 2. Estrutura HTML

### 2.1 Página (category.tpl / search.tpl)

```
<section class="pg-search-page">
  <div class="pg-search-page__container">
    <div class="pg-search-page__header">
      <h1 class="pg-search-page__title">...</h1>
      <p class="pg-search-page__term">...</p>  {# descrição categoria ou termo busca #}
    </div>
    {# category.tpl: controles de filtro e ordenação #}
    <div class="pg-search-page__body">
      <div class="js-product-table pg-product-grid">
        {% include 'snipplets/product_grid.tpl' %}
      </div>
      {% include 'snipplets/grid/pagination.tpl' %}
    </div>
  </div>
</section>
```

- **Categoria:** tem filtros (modal `#nav-filters`), ordenação (`sort-by`); aplicados em `snipplets/grid/filters.tpl`.
- **Busca:** sem filtros; apenas grid e paginação.

### 2.2 Grid e item (product_grid.tpl, item.tpl)

- **product_grid.tpl:** loop `{% for product in products %}` → inclui `snipplets/grid/item.tpl`.
- **item.tpl:** cada card é `div.item-product` com:
  - `.item-image` → imagem via componente `product-item-image` (Nuvemshop injeta `padding-bottom` inline no container para proporção).
  - `.item-description` (container)
  - `.item-name`, `.item-price-container`, `.item-price`, `[data-component="payment-discount-price"]`, `.item-installments`, `.item-actions` (botão, etc.)
  - `.labels` (badges)

### 2.3 Configurações relevantes

- `config/settings.txt`: `grid_columns` (2 ou 3 colunas) influencia classes em item.tpl (`col-6 col-md-3` vs `col-12 col-md-4`).
- `payment_discount_price`: componente "com boleto" / preço à vista.

---

## 3. Ordem de carregamento de CSS (layout.tpl)

1. Critical (inline): `style-critical.tpl`, `style-menu-patagang.css.tpl`, `style-filters-patagang.css.tpl`
2. Cores (inline): `style-colors.scss.tpl`
3. Async (link): `style-async.scss.tpl` (media="print" → onload="all")
4. Home (link, só se `template == 'home'`): style-home-v2.css
5. Blog, `settings.css_code`
6. **Override final listagem** (inline, só se `template == 'category' or template == 'search'`): bloco `<style>` em layout.tpl

Qualquer regra em um item posterior sobrescreve uma anterior (mesma especificidade e `!important`).

---

## 4. Por arquivo: o que impacta listagem

| Arquivo | O que contém | Escopo |
|---------|--------------|--------|
| `static/css/style-critical.tpl` | `body.template-category .pg-product-grid .item-image` (e filhos) – base para FCP | Apenas listagem |
| `static/css/style-filters-patagang.css.tpl` | Filtros (modal, botões, controles) | Categoria; `.filters-overlay`, `.filter-*` |
| `static/css/style-async.scss.tpl` | **MÓDULO LISTAGEM** (fonte única): `.pg-search-page`, `.pg-product-grid .item-product`, imagem, nome, preço, botões, labels | `body.template-category, body.template-search` |
| `layouts/layout.tpl` | Override (head): padding-top, gap, proporção 1:1 imagem, cor "com boleto". Override (após foot_content): align-items, height/min-height, flex-grow | Condicional `template == 'category' or template == 'search'` |

**Design do card (compacto, quadrado, foto em destaque):** Aparência controlada somente pelo MÓDULO LISTAGEM e pelos overrides em layout.tpl. Não existem mais regras genéricas de `.item-product` sem escopo.

---

## 5. O que “vence” na cascata

- **Override final (layout.tpl):** carrega por último; vence para: `padding-top`, `gap`, `min-height` card, proporção imagem 1:1, cor do "com boleto".
- **MÓDULO LISTAGEM (async):** base visual da listagem; escopado com `body.template-category/search`; pode ser sobrescrito pelo override final.
- **Plataforma / base theme:** podem injetar regras; com `!important` e mesma especificidade, vence a última. O override final existe para garantir nossa “última palavra”.

---

## 6. Tabela de referência rápida

| Elemento | Arquivo | Onde alterar |
|----------|---------|--------------|
| Container pg-search-page, pg-product-grid | style-async (MÓDULO LISTAGEM), override layout | async para base; layout para padding-top, gap |
| Card item-product | style-async (MÓDULO LISTAGEM), override layout | async para base; layout para min-height |
| Imagem item-image, proporção 1:1 | style-async, override layout | override layout: `padding-bottom: 100%` |
| Nome, preço, “com boleto” | style-async (MÓDULO LISTAGEM), override layout | override para cor do boleto; async para tipografia e layout base |
| Botões item-actions | style-async (MÓDULO LISTAGEM) | MÓDULO LISTAGEM |
| Filtros (modal, controles) | style-filters-patagang.css.tpl | style-filters-patagang |
| Templates (estrutura HTML) | templates/category.tpl, search.tpl | category.tpl, search.tpl |
| Card individual (estrutura) | snipplets/grid/item.tpl | item.tpl |

---

## 7. Por que alterações às vezes não refletem

- Várias camadas (critical, async, override); ordem importa.
- Cache do tema no admin: após deploy, limpar cache em Themes → tema ativo → Limpar Cache.
- Consultar [css-impact-map.md](../../project/css-impact-map.md) para escopos de cada contexto de card.

---

## 8. Histórico de refatoração (2026-02-14)

**Refatoração aplicada:**
- Remoção de blocos genéricos de `.item-product` (Card dos Produtos, SEARCH & CATEGORY) em style-async.
- Consolidação em MÓDULO LISTAGEM como fonte única para listagem.
- Bloco `.section-products-related` removido do async; mantido somente no critical.
- Novo bloco `body.template-404 .pg-404-products__grid .item-product` para página 404.
- Escopo explícito no critical para `body.template-category .pg-product-grid` e `body.template-search .pg-product-grid`.
- Remoção de código morto (`.pg-card`, `.pg-product-card__*`).
- Override do botão desenvolvimento restrito à listagem.

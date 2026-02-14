# Mapa de impacto de seletores de cards de produtos

Após refatoração (2026-02-14): cada contexto de card tem escopo explícito. Regras genéricas de `.item-product` ou `.pg-dev-card` sem prefixo foram removidas.

**Última atualização:** 2026-02-14

---

## Uso

- Ao alterar um seletor, verificar o contexto em "Escopo".
- Ao adicionar regra nova para cards, usar sempre escopo `body.template-*` ou container específico.
- Não criar regras sem escopo que afetem `.item-product`, `.item-image`, `.pg-dev-card`.

---

## Contextos e escopos (fonte única por contexto)

| Contexto                       | Seletor base                                                                                | Arquivo                     | Onde alterar                    |
| ------------------------------ | ------------------------------------------------------------------------------------------- | --------------------------- | ------------------------------- |
| Listagem (categoria/busca)     | `body.template-category .pg-product-grid .item-product` (e filhos)                          | style-async MÓDULO LISTAGEM | style-async.scss.tpl ~5227-5558 |
| Produtos similares (PDP)       | `.section-products-related .pg-card` (e filhos V3: `__image`, `__name`, `__price`, `__btn`) | style-critical.tpl          | style-critical.tpl ~2295-2500   |
| 404 relacionados               | `body.template-404 .pg-404-products__grid .item-product` (e filhos)                         | style-async.scss.tpl        | style-async.scss.tpl ~5560-5642 |
| Vista o Propósito (home)       | `.pg-product-card-v2`                                                                       | style-home-v2.css           | style-home-v2.css ~360-442      |
| Seja o Primeiro (home)         | `body.template-home .pg-dev-card`                                                           | style-home-v2.css           | style-home-v2.css ~536-654      |
| PDP produto em desenvolvimento | `.pg-product-form .pg-dev-card`                                                             | style-critical.tpl          | style-critical.tpl ~5116-5295   |
| Search overlay destaques       | `.pg-search-overlay__product-card`                                                          | style-critical.tpl          | style-critical.tpl ~1067-1190   |

---

## Nota sobre .pg-dev-card

Duas estruturas distintas usam a mesma BEM root:
- **Home (carousel):** `body.template-home .pg-dev-card` com `__image`, `__info`, `__name`
- **PDP (página produto):** `.pg-product-form .pg-dev-card` com `__corner`, `__content`, `__button`, `__product-info`

O escopo no seletor é obrigatório; nunca alterar `.pg-dev-card` sem prefixo.

---

## Regras ainda genéricas (fora de cards)

| Seletor                             | Arquivo              | Onde impacta                           |
| ----------------------------------- | -------------------- | -------------------------------------- |
| `.item-product-reduced .item-image` | style-critical.tpl   | Cards em carrosséis com `reduced_item` |
| `.js-product-table.row`             | style-async.scss.tpl | Estrutura de grid (listagem)           |
| `.category-body`                    | style-async.scss.tpl | Background da página categoria         |

---

## Boas práticas

- Preferir escopo `body.template-*` ou container (`.pg-product-grid`, `.section-products-related`) quando a regra for específica.
- Consultar [standards-css-e-tema-nuvemshop.md](standards-css-e-tema-nuvemshop.md) para cascade e override.
- Atualizar este mapa ao adicionar novos contextos de card.

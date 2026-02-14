# Listagem (categoria e busca)

Páginas de **categoria** e **busca** de produtos: estrutura compartilhada, filtros, grid de cards, paginação.

---

## Conteúdo

| Arquivo | Descrição |
|---------|-----------|
| [referencia-atual.md](referencia-atual.md) | Mapa completo: quando a página é usada, estrutura HTML, ordem de CSS, por arquivo o que impacta, o que vence na cascata. Onde alterar listagem. |

---

## Quando usar

- Alterar layout, estilos ou comportamento da listagem de produtos (categoria ou busca).
- Entender onde estão os estilos da grid (MÓDULO LISTAGEM, override layout).
- Verificar impacto de seletores genéricos: consultar [Docs/project/css-impact-map.md](../../project/css-impact-map.md).
- Respeitar padrões CSS: [Docs/project/standards-css-e-tema-nuvemshop.md](../../project/standards-css-e-tema-nuvemshop.md).

---

## Identificadores

- **Body:** `template-category` (categoria) ou `template-search` (busca).
- **Templates:** `templates/category.tpl`, `templates/search.tpl`.
- **Snipplets:** `snipplets/product_grid.tpl`, `snipplets/grid/item.tpl` (card de produto).
- **Classes principais:** `.pg-search-page`, `.pg-product-grid`, `.item-product`, `.item-image`, `.item-description`, `.item-name`, `.item-price-container`.

# Header Patagang

Header global da loja: logo, menu (desktop com dropdown / mobile hambúrguer), ícones de busca, perfil e carrinho.

---

## Conteúdo

| Arquivo | Descrição |
|---------|-----------|
| [referencia-atual.md](referencia-atual.md) | Estado atual: arquivos, estrutura de classes, onde alterar logo/menu/busca/ícones, estilos inline vs externos. |

---

## Quando usar

- Alterar layout, textos ou estilos do header (logo, menu, ícones, busca).
- Saber onde está a busca (modal `#nav-search` com `header-search.tpl`) e onde estão os estilos (inline no .tpl + `style-menu-patagang.css.tpl`).
- Evitar confusão: a busca do header é o modal simples; o overlay com Destaques/Lançamentos é outro componente (ver `search-overlay/` se for o caso).

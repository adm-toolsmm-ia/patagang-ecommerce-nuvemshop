# Features – Documentação por feature

Uma subpasta por **feature** da loja: Search Overlay, seções da home, etc.

---

## Features documentadas

| Pasta | Descrição |
|-------|-----------|
| [listagem-categoria-busca/](listagem-categoria-busca/) | Páginas de categoria e busca: grid de produtos, filtros, MÓDULO LISTAGEM no async, override layout; mapa completo em referencia-atual. |
| [search-overlay/](search-overlay/) | Overlay de busca (header): overview, deploy, checklist de validação; histórico em `archive/`. |
| [home-vista-proposito/](home-vista-proposito/) | Seção "Vista o Propósito" da home: documentação de implementação dos cards. |
| [home-seja-o-primeiro/](home-seja-o-primeiro/) | Seção "Seja o Primeiro a Conhecer" da home: carrossel de produtos em desenvolvimento; referência atual. |
| [header-patagang/](header-patagang/) | Header global: logo, menu (desktop/mobile), busca, perfil, carrinho; referência atual. |

---

## Nova feature

1. Criar subpasta em `features/` (ex.: `features/nome-da-feature/`).
2. Adicionar `README.md` com índice e propósito.
3. Colocar overview, deploy, checklists na pasta; hotfixes/deploys antigos em `archive/`.
4. Quando houver arquivos de tema/CSS envolvidos, adicionar `referencia-atual.md` (estado atual, onde alterar).

## Convenção de atualização

Ao alterar estrutura ou arquivos de uma feature (novos snippets, classes, CSS): atualizar a `referencia-atual` (ou mapa) daquela feature. Se surgir seletor genérico relevante que afete múltiplos contextos, atualizar [Docs/project/css-impact-map.md](../project/css-impact-map.md).

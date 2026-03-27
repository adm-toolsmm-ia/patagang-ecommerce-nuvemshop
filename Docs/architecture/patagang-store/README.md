# Patagang Store Architecture

Documentacao tecnica da loja (`theme-deploy-corrigido`) baseada no estado real do codigo.

## Snapshot atual (code-based)

- Versao em runtime: `1.5.170`
- Estrutura principal:
  - `layouts/layout.tpl` (1076 linhas)
  - `templates/*.tpl` (21 ficheiros)
  - `snipplets/**/*.tpl` (180 ficheiros)
  - `static/**/*.tpl` (19 ficheiros)
- Arquivos CSS centrais:
  - `static/css/style-critical.tpl` (4765 linhas)
  - `static/css/style-async.scss.tpl` (6189 linhas)
- Arquivo JS central:
  - `static/js/store.js.tpl` (2992 linhas)

## Cadeia principal de carregamento (layout)

`layouts/layout.tpl` controla:

- includes de CSS critico e complementares
- links de CSS async
- includes de JS templated
- estrutura base de snipplets globais (header/footer/cart/modal/whatsapp)

Ponto de atencao no snapshot atual:

- `layout.tpl` referencia:
  - `static/js/external-no-dependencies.js.tpl`
  - `static/js/external.js.tpl`
- esses ficheiros nao existem em `theme-deploy-corrigido/static/js/`.

## Leitura recomendada

1. [01-STORE-OVERVIEW.md](./01-STORE-OVERVIEW.md)
2. [02-PAGE-STRUCTURE.md](./02-PAGE-STRUCTURE.md)
3. [03-COMPONENT-INVENTORY.md](./03-COMPONENT-INVENTORY.md)
4. [04-CSS-ARCHITECTURE.md](./04-CSS-ARCHITECTURE.md)
5. [05-JAVASCRIPT-MODULES.md](./05-JAVASCRIPT-MODULES.md)
6. [06-FILE-DEPENDENCY-TREE.md](./06-FILE-DEPENDENCY-TREE.md)
7. [07-NUVEMSHOP-CONSTRAINTS.md](./07-NUVEMSHOP-CONSTRAINTS.md)
8. [08-DEPLOYMENT-ARTIFACTS.md](./08-DEPLOYMENT-ARTIFACTS.md)

## Ligacoes AIOX (L3)

- `.aiox-core/data/patagang-store-catalog.yaml`
- `.aiox-core/data/patagang-component-dependency-map.yaml`
- `.aiox-core/data/patagang-architecture-state.yaml`
- `.aiox-core/data/patagang-project-state.yaml`
- `.aiox-core/data/patagang-context-policy.yaml`

## Nao-objetivo

Esta documentacao nao altera codigo funcional da loja e nao bloqueia melhorias.
Ela existe para reduzir ambiguidade e acelerar novas entregas de UX/UI.

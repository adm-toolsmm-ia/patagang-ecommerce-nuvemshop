# Onboarding para IA – Alterações no tema Patagang

Ponto de entrada para agentes de IA: **onde ler primeiro** ao alterar tema ou feature específica da loja.

---

## Alterações globais de tema

1. [context-home.md](context-home.md) — Estrutura do projeto, ordem de carregamento de CSS, como a home é renderizada.
2. [standards-css-e-tema-nuvemshop.md](standards-css-e-tema-nuvemshop.md) — Cascata, validação com DevTools, override final, consolidação.
3. [Docs/architecture/](../architecture/) — Arquitetura do projeto (stack, fluxo CSS, deploy).
4. [decisions.md](decisions.md) — Decisões arquiteturais (override no layout, critical vs async, listagem).

---

## Alterações por feature

Consultar a pasta da feature — começar por **README** e **referencia-atual** (quando existir):

| Feature | Pasta | Quando usar |
|---------|-------|-------------|
| Listagem (categoria/busca) | [Docs/features/listagem-categoria-busca/](../features/listagem-categoria-busca/) | Grid de produtos, filtros, cards |
| Header | [Docs/features/header-patagang/](../features/header-patagang/) | Logo, menu, busca, ícones |
| Vista o Propósito | [Docs/features/home-vista-proposito/](../features/home-vista-proposito/) | Seção de cards na home |
| Seja o Primeiro a Conhecer | [Docs/features/home-seja-o-primeiro/](../features/home-seja-o-primeiro/) | Carrossel "em desenvolvimento" na home |
| Search overlay | [Docs/features/search-overlay/](../features/search-overlay/) | Overlay de busca com Destaques/Lançamentos |

---

## CSS em arquivos grandes

- **Localizar seção:** Usar o **TOC** no topo de `theme-deploy-corrigido/static/css/style-critical.tpl` e `style-async.scss.tpl`.
- **Impacto entre contextos:** Consultar [css-impact-map.md](css-impact-map.md) para seletores que afetam listagem, home, PDP, etc.

---

## Deploy

- Após alterações no tema, executar deploy (regra em `.cursor/rules`): `Set-Location ftp-deploy; node deploy-optimized.js`
- Ver [context-home.md](context-home.md) (seção 1.2) e `ftp-deploy/README.md` para fluxo completo.
- Pós-deploy: limpar cache do tema no admin Nuvemshop (Themes → tema ativo → Limpar Cache).

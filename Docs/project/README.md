# Project – Contexto do projeto

Documentação do **contexto global** do repositório: estrutura de pastas, deploy, como a home é renderizada e convenções.

---

## Conteúdo

| Arquivo | Descrição |
|---------|-----------|
| [context-home.md](context-home.md) | Referência do estado atual da loja: estrutura do tema, deploy, backup full/sync, renderização da home, levantamentos técnicos. Base para novas alterações. |
| [standards-css-e-tema-nuvemshop.md](standards-css-e-tema-nuvemshop.md) | Padrões de CSS e tema Nuvemshop: cascade, validação com DevTools, override final, consolidação. Obrigatório considerar em análises e alterações de tema/CSS. |
| [decisions.md](decisions.md) | Decisões arquiteturais (ADR-lite): override no layout, critical vs async, listagem, features documentadas. |
| [ai-onboarding.md](ai-onboarding.md) | Onboarding para IA: onde ler primeiro para alterar tema ou feature específica. |
| [css-impact-map.md](css-impact-map.md) | Mapa de impacto de seletores genéricos (listagem, home, etc.). |

---

## Convenção de atualização

Ao alterar estrutura ou arquivos de uma feature (novos snippets, classes, CSS): atualizar a `referencia-atual` da feature. Se surgir seletor genérico relevante, atualizar [css-impact-map.md](css-impact-map.md).

---

## Quando usar

- Entender a estrutura do projeto (theme-deploy-corrigido, ftp-deploy, scripts).
- Saber como fazer deploy e pós-deploy (cache Nuvemshop).
- Consultar a estrutura HTML da home e ordem de carregamento de CSS.
- Base para análises e alterações na home ou no tema.
- Seguir padrões de CSS e tema ao analisar ou alterar estilos/tema.

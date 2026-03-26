# CODEBASE.md — ponte de contexto (AIOX / Patagang)

Qualquer LLM que altere o **tema Nuvemshop** (`theme-deploy-corrigido/`) deve seguir a **ordem de leitura** abaixo. O detalhe operacional mora em `Docs/architecture/`, não aqui.

## Ordem de leitura (tema e loja)

1. **[Docs/architecture/patagang-ai-operating-context.md](Docs/architecture/patagang-ai-operating-context.md)** — auditoria obrigatória, ordem de CSS, ficheiros críticos, classes Nuvemshop, checklist, deploy.
2. **[Docs/architecture/patagang-css-cascade.md](Docs/architecture/patagang-css-cascade.md)** — cascade em profundidade, `!important`, estudos de caso, checklist antes de deploy.
3. **[Docs/architecture/README.md](Docs/architecture/README.md)** — hub: anatomia da loja (`patagang-store/`), YAMLs, arquivo EPIC 9, metodologia.

## Dados máquina-legíveis

- `.aiox-core/data/patagang-css-patterns.yaml`
- `.aiox-core/data/patagang-learned-patterns.yaml`
- `.aiox-core/data/patagang-architecture-state.yaml`

## Resto do projeto (framework AIOX)

Ver [AGENTS.md](AGENTS.md) e [.aiox-core/constitution.md](.aiox-core/constitution.md).

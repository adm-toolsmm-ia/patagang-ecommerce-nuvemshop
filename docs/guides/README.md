# Guias AIOX — rotina dos agentes (Patagang)

Esta pasta concentra **documentação operacional** alinhada à engenharia AIOX: práticas seguras na Nuvemshop, deploy e tópicos recorrentes de implementação. Histórico de epics/stories e checkpoints de projeto estão em `Docs/epics/.archive/`, `Docs/stories/.archive/` e `Docs/project/.archive/`.

---

## Referência rápida (raiz)

| Documento | Uso pelos agentes |
|-----------|-------------------|
| [CACHE_BUSTING_EXPLICADO.md](./CACHE_BUSTING_EXPLICADO.md) | Cache de assets, parâmetros `?v=`, validação pós-deploy |
| [NUVEMSHOP-JAVASCRIPT-SAFE-PRACTICES.md](./NUVEMSHOP-JAVASCRIPT-SAFE-PRACTICES.md) | APIs `LS`, guards, práticas obrigatórias antes de alterar JS |
| [ROTINA-DEPLOYMENT-PADRAO.md](./ROTINA-DEPLOYMENT-PADRAO.md) | Sincronizar versão Git / `VERSION` / FTP |

---

## Subpastas

| Pasta | Conteúdo |
|-------|----------|
| [deploy/](./deploy/) | Checklists e artefatos de deploy (ex.: Fase 2) |
| [nuvemshop/](./nuvemshop/) | Fluxos e notas da plataforma |
| [pdp/](./pdp/) | Guias de execução e implementação na página de produto (PDP) |

---

## Padrões e arquitetura (fora de `guides/`)

| Tema | Local |
|------|--------|
| Metodologia brownfield AIOX, governança, roadmap | [`../architecture/methodology/`](../architecture/methodology/README.md), [`../architecture/STRUCTURAL-REFINEMENT-ROADMAP.md`](../architecture/STRUCTURAL-REFINEMENT-ROADMAP.md) |
| Cascata CSS, Epic 9 (referência + arquivo) | [`../architecture/README.md`](../architecture/README.md) |
| Stories/epics arquivados (incl. guias `8.x`) | [`../stories/.archive/`](../stories/.archive/) |

---

*Índice alinhado à limpeza mar/2026 — apenas guias de rotina AIOX + PDP em `guides/`.*

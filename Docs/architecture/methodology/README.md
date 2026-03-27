# Metodologia e governança AIOX — arquitetura documental

Esta pasta concentra **L4 / engenharia de contexto** para agentes: como organizar documentação brownfield e como fazer **limpeza segura** sem violar Constitution ou hierarquia de autoridades.

## Documentos

| Arquivo                                                                                                  | Uso pelos agentes                                                                   |
|----------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------|
| [AIOX-BROWNFIELD-ORGANIZATION-STANDARD.md](./AIOX-BROWNFIELD-ORGANIZATION-STANDARD.md)                 | Padrão de pastas, 10 fases brownfield, hierarquia de contexto (L1–L4)             |
| [AIOX-CLEANUP-REFERENCE-SUMMARY.md](./AIOX-CLEANUP-REFERENCE-SUMMARY.md)                               | Tiers de preservação, camadas AIOX, checklist antes de mover/apagar docs           |

**Referência espelhada em código:** `.aiox-core/development/docs/AIOX-ARCHITECTURE-REFERENCE-*.md` (quando existir) — o sumário de cleanup aponta para lá como “key location”.

## Relacao com a raiz de `architecture/`

- **`../README.md`** — hub de entrada do contexto ativo (cascata, anatomia da loja e YAMLs L3).
- **`../patagang-css-cascade.md`** — comportamento da cascata CSS do **tema** (operacional).
- **`../STRUCTURAL-REFINEMENT-ROADMAP.md`** — roadmap de refino estrutural do repositório/tema.
- **`../patagang-store/`** — anatomia numerada da loja (01–08).
- **`../patagang/`** — análise v3 + plano de otimização legado.

---

*Convenção AIOX: método e governança separados da anatomia do produto para reduzir ruído na raiz e melhorar recuperação de contexto pelos agentes.*

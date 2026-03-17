# Brownfield Discovery Workflow - EXECUTION PLAN

**Projeto:** Patagang E-commerce (Nuvemshop)
**Data Início:** 2026-03-15
**Status:** Em Execução
**Tempo Total Estimado:** 4-6 horas

---

## FASES A EXECUTAR

### ✅ FASE 1: Coleta - Arquitetura do Sistema
**Agent:** @architect
**Comando:** Manual document-project analysis
**Output:** docs/architecture/system-architecture.md
**Duração:** 30-60 min
**Status:** PENDENTE

**Tarefas do @architect:**
1. Analisar estrutura do projeto Nuvemshop
2. Documentar stack: Liquid templates, SCSS, FTP deployment
3. Mapear dependências e versões
4. Identificar padrões de código e duplicação
5. Documentar pontos de integração com Nuvemshop
6. Listar configurações críticas (cache, deploy)
7. Identificar débitos de sistema

**Contexto Crítico:**
- CODEBASE.md define regras obrigatórias sobre CSS loading order
- Project tem 6 camadas de CSS com diferentes estratégias de caching
- Múltiplos templates .scss.tpl cacheados server-side

---

### ✅ FASE 3: Coleta - Frontend/UX
**Agent:** @ux-design-expert
**Comando:** Manual *create-front-end-spec
**Output:** docs/frontend/frontend-spec.md
**Duração:** 30-45 min
**Status:** PENDENTE (depende da FASE 1)

**Tarefas do @ux-design-expert:**
1. Analisar componentes UI existentes (cards, grids, etc.)
2. Documentar design system/tokens (cores, tipografia, spacing)
3. Mapear padrões de layout (category, search, product pages)
4. Avaliar responsividade (mobile, tablet, desktop)
5. Acessibilidade (a11y) assessment
6. Consistência visual entre templates
7. Performance percebida (loading states, transitions)
8. Identificar débitos de UX/UI

**Componentes Críticos:**
- Product cards (pg-card, item-product)
- Product grid (pg-product-grid)
- Category/Search pages
- Product detail page
- Cart/Checkout pages

---

### ✅ FASE 4: Consolidação Inicial (DRAFT)
**Agent:** @architect
**Ação:** Manual consolidation
**Output:** docs/prd/technical-debt-DRAFT.md
**Duração:** 30-45 min
**Status:** PENDENTE (depende de FASE 1 + FASE 3)

**Tarefas do @architect:**
1. Ler docs/architecture/system-architecture.md
2. Ler docs/frontend/frontend-spec.md
3. Consolidar todos os débitos identificados
4. Criar matriz preliminar de débitos
5. Marcar seções para revisão especialista
6. Adicionar perguntas para @ux-design-expert

**Estrutura do DRAFT:**
```
# Technical Debt Assessment - DRAFT

## Para Revisão dos Especialistas

### 1. Débitos de Sistema
[Da phase 1]

### 2. Débitos de Frontend/UX
[Da phase 3]
⚠️ PENDENTE: Revisão do @ux-design-expert

### 3. Matriz Preliminar
| ID | Débito | Área | Impacto | Esforço | Prioridade |

### 4. Perguntas para Especialistas
- @ux-design-expert: [perguntas]
```

---

### ✅ FASE 6: Validação - Frontend/UX
**Agent:** @ux-design-expert
**Ação:** Manual specialist review
**Output:** docs/reviews/ux-specialist-review.md
**Duração:** 20-30 min
**Status:** PENDENTE (depende de FASE 4)

**Tarefas do @ux-design-expert:**
1. Ler docs/prd/technical-debt-DRAFT.md
2. Validar débitos de UX/Frontend
3. Estimar horas para cada débito
4. Priorizar do ponto de vista UX
5. Responder perguntas do architect
6. Documentar recomendações de design

**Formato do Review:**
```
## UX Specialist Review

### Débitos Validados
| ID | Débito | Severidade | Horas | Prioridade | Impacto UX |

### Débitos Adicionados
[novos débitos]

### Respostas ao Architect
[respostas]

### Recomendações de Design
[soluções]
```

---

### ✅ FASE 7: QA Review Geral
**Agent:** @qa
**Ação:** Manual quality gate review
**Output:** docs/reviews/qa-review.md
**Duração:** 30-45 min
**Status:** PENDENTE (depende de FASE 4 + FASE 6)

**Tarefas do @qa:**
1. Ler docs/prd/technical-debt-DRAFT.md
2. Ler docs/reviews/ux-specialist-review.md
3. Identificar gaps no assessment
4. Avaliar riscos cruzados
5. Validar dependências
6. Sugerir testes de validação
7. Dar parecer: APPROVED / NEEDS WORK

**Quality Gate Criteria:**
- Assessment está completo?
- Todos os débitos foram validados?
- Dependências fazem sentido?
- Riscos foram endereçados?

---

### ✅ FASE 8: Assessment Final
**Agent:** @architect
**Ação:** Manual finalization
**Output:** docs/prd/technical-debt-assessment.md
**Duração:** 30-45 min
**Status:** PENDENTE (depende de FASE 7 com aprovação QA)

**Pré-requisito:** QA Review = APPROVED

**Tarefas do @architect:**
1. Ler technical-debt-DRAFT.md
2. Ler ux-specialist-review.md
3. Ler qa-review.md
4. Incorporar ajustes de especialistas
5. Endereçar gaps do QA
6. Recalcular prioridades
7. Definir ordem final de resolução
8. Criar documento FINAL validado

**Estrutura Final:**
```
# Technical Debt Assessment - FINAL

## Executive Summary
- Total de débitos: X
- Críticos: Y | Altos: Z | Médios: W
- Esforço total: XXX horas

## Inventário Completo
### Sistema
### Frontend/UX

## Matriz de Priorização Final
[consolidada]

## Plano de Resolução
[ordem, dependências, timeline]

## Riscos e Mitigações
[do QA review]

## Critérios de Sucesso
[métricas, testes]
```

---

### ✅ FASE 9: Relatório Executivo
**Agent:** @analyst
**Ação:** Manual awareness report
**Output:** docs/reports/TECHNICAL-DEBT-REPORT.md
**Duração:** 30-45 min
**Status:** PENDENTE (depende de FASE 8)

**Tarefas do @analyst:**
1. Ler docs/prd/technical-debt-assessment.md
2. Criar relatório para stakeholders
3. Traduzir técnico para negócio
4. Calcular custos: resolver vs. não resolver
5. Documentar impactos (performance, segurança, UX, manutenibilidade)
6. Propor timeline realista
7. Calcular ROI

**Foco do Relatório:**
- **Custos claros:** Resolver vs. não resolver (em R$)
- **Impacto no negócio:** Conversão, segurança, churn, velocidade
- **Timeline:** Fases realistas (Quick Wins, Fundação, Otimização)
- **ROI:** Investimento vs. retorno esperado

---

### ✅ FASE 10: Planning (Epics + Stories)
**Agent:** @pm
**Ação:** Epic + Story creation
**Output:** docs/stories/epic-technical-debt.md + story-*.md
**Duração:** 30-60 min
**Status:** PENDENTE (depende de FASE 9)

**Tarefas do @pm:**
1. Ler technical-debt-assessment.md
2. Ler TECHNICAL-DEBT-REPORT.md
3. Criar Epic: "Resolução de Débitos Técnicos - Patagang"
4. Criar Stories para cada débito priorizado
5. Definir acceptance criteria
6. Estruturar timeline por fases

**Estrutura do Epic:**
```
# Epic: Resolução de Débitos Técnicos - Patagang

## Objetivo
[visão geral]

## Escopo
[débitos inclusos]

## Timeline
[por fases]

## Critérios de Sucesso
[DoD]

## Stories Incluídas
- Story 1.1: [débito 1]
- Story 1.2: [débito 2]
- ...
```

**Stories Criadas:**
- story-1.1-[debt-name].md
- story-1.2-[debt-name].md
- ...

---

## ARTEFATOS GERADOS

```
docs/
├── architecture/
│   └── system-architecture.md              [FASE 1] ✅
├── frontend/
│   └── frontend-spec.md                    [FASE 3] ✅
├── prd/
│   ├── technical-debt-DRAFT.md             [FASE 4] ✅
│   └── technical-debt-assessment.md        [FASE 8] ✅
├── reviews/
│   ├── ux-specialist-review.md             [FASE 6] ✅
│   └── qa-review.md                        [FASE 7] ✅
├── reports/
│   └── TECHNICAL-DEBT-REPORT.md            [FASE 9] ✅
└── stories/
    ├── epic-technical-debt.md              [FASE 10] ✅
    ├── story-1.1-*.md
    ├── story-1.2-*.md
    └── ...
```

---

## DEPENDÊNCIAS CRÍTICAS

```
FASE 1 (System) ──┐
                  ├──→ FASE 4 (DRAFT) ──→ FASE 6 (UX Review) ──┐
FASE 3 (UX) ─────┘                                            ├──→ FASE 7 (QA) ──→ FASE 8 (Final) ──→ FASE 9 (Report) ──→ FASE 10 (Epic)
                                                              ┘
```

**Notas:**
- FASE 2 (Database): PULADA (Nuvemshop managed, sem acesso direto)
- FASE 5 (DB Review): PULADA (banco não auditável)
- FASES 1-3 podem ser paralelas
- FASES 4-7 devem ser sequenciais
- FASE 8 depende de FASE 7 APPROVED

---

## PRÓXIMOS PASSOS

1. ✅ Criar este plano (CONCLUÍDO)
2. ✅ Ativar @architect para FASE 1 (CONCLUÍDO)
3. ✅ Ativar @ux-design-expert para FASE 3 (CONCLUÍDO)
4. ✅ Ativar @architect para FASE 4 (CONCLUÍDO)
5. ✅ Ativar @ux-design-expert para FASE 6 (CONCLUÍDO)
6. ✅ Ativar @qa para FASE 7 (CONCLUÍDO)
7. ✅ Ativar @architect para FASE 8 (CONCLUÍDO)
8. ✅ Ativar @analyst para FASE 9 (CONCLUÍDO)
9. ✅ Ativar @pm para FASE 10 (CONCLUÍDO)

---

## TEMPO ESTIMADO

| Fase | Agent | Duração |
|------|-------|---------|
| 1 | @architect | 30-60 min |
| 3 | @ux-design-expert | 30-45 min |
| 4 | @architect | 30-45 min |
| 6 | @ux-design-expert | 20-30 min |
| 7 | @qa | 30-45 min |
| 8 | @architect | 30-45 min |
| 9 | @analyst | 30-45 min |
| 10 | @pm | 30-60 min |
| **TOTAL** | | **4-6 horas** |

---

**Criado:** 2026-03-15 por Claude Code
**Versão:** 1.0
**Status:** EXECUÇÃO INICIADA

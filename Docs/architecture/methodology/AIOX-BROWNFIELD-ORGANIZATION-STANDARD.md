# 🏗️ AIOX Brownfield Organization Standard — Padrão de Estruturação
**Versão:** 1.0
**Status:** TEMPLATE ESTRUTURAL
**Propósito:** Definir como organizar documentações de projeto brownfield conforme AIOX 10-fase workflow
**Aplicável a:** Todos os projetos com refinamento técnico (Nuvemshop, Lovable, v0.dev migrations)

---

## 📋 FILOSOFIA AIOX BROWNFIELD

A metodologia AIOX de brownfield discovery segue **10 fases estruturadas**:

1. **Fase 1-3:** Coleta de dados (System, Database, Frontend)
2. **Fase 4:** Consolidação inicial (DRAFT)
3. **Fase 5-7:** Validação especialistas (DB, UX, QA)
4. **Fase 8:** Assessment final
5. **Fase 9:** Relatório executivo
6. **Fase 10:** Planning (Epic + Stories)

**Cada projeto deve organizar seu "debris" histórico** dentro dessa estrutura, mesmo que iniciado sem formalidade.

---

## 🗂️ ESTRUTURA DE DIRETÓRIOS PADRÃO

```
projeto/
│
├── docs/
│   ├── guides/
│   │   ├── BROWNFIELD-DISCOVERY-INDEX.md          ← Índice central (NOVO)
│   │   ├── BROWNFIELD-DISCOVERY-STATUS-REPORT.md  ← Onde estamos (NOVO)
│   │   │
│   │   ├── FASE-1_System-Documentation/           ← Pasta organizada por FASE
│   │   │   ├── README.md (navegação)
│   │   │   ├── system-architecture.md
│   │   │   ├── codebase-analysis.md
│   │   │   └── [story-specific docs]
│   │   │
│   │   ├── FASE-2_Database-Documentation/         ← Skip se não aplicável
│   │   │   └── [não aplicável para Nuvemshop]
│   │   │
│   │   ├── FASE-3_Frontend-Documentation/
│   │   │   ├── README.md
│   │   │   ├── frontend-spec.md
│   │   │   ├── ux-analysis.md
│   │   │   └── [story-specific docs]
│   │   │
│   │   ├── FASE-4_Initial-Consolidation/
│   │   │   ├── README.md
│   │   │   └── technical-debt-DRAFT.md
│   │   │
│   │   ├── FASE-5-7_Specialist-Reviews/
│   │   │   ├── README.md
│   │   │   ├── db-specialist-review.md (skip)
│   │   │   ├── ux-specialist-review.md
│   │   │   └── qa-review.md
│   │   │
│   │   ├── FASE-8_Final-Assessment/
│   │   │   ├── README.md
│   │   │   └── technical-debt-assessment.md
│   │   │
│   │   ├── FASE-9_Executive-Report/
│   │   │   ├── README.md
│   │   │   └── TECHNICAL-DEBT-REPORT.md
│   │   │
│   │   ├── FASE-10_Planning/
│   │   │   ├── README.md
│   │   │   ├── epic-technical-debt.md
│   │   │   └── [stories by topic]
│   │   │
│   │   ├── CONTEXT-HIERARCHY/                     ← 4-Level AIOX Hierarchy
│   │   │   ├── LEVEL-1_Foundation.md (Why?)
│   │   │   ├── LEVEL-2_Inventory.md (Which patterns?)
│   │   │   ├── LEVEL-3_Blueprint.md (How to refactor?)
│   │   │   └── LEVEL-4_Governance.md (How to inherit?)
│   │   │
│   │   ├── STORIES/                               ← Stories organizadas por epic
│   │   │   ├── EPIC-8-Technical-Refactoring/
│   │   │   │   ├── 8.1-Design-Tokens/
│   │   │   │   │   ├── story.md
│   │   │   │   │   └── [docs]
│   │   │   │   ├── 8.2-Critical-CSS/
│   │   │   │   │   ├── story.md
│   │   │   │   │   ├── 8.2-DOCUMENTATION-INDEX.md
│   │   │   │   │   ├── 8.2-PROJECT-HISTORY-CONTEXT.md
│   │   │   │   │   ├── 8.2-PATTERNS-INVENTORY.md
│   │   │   │   │   ├── 8.2-ARCHITECTURE-BLUEPRINT.md
│   │   │   │   │   └── [outros]
│   │   │   │   ├── 8.3-Remove-Important/
│   │   │   │   │   ├── story.md
│   │   │   │   │   └── [docs]
│   │   │   │   ├── 8.4-Template-Cleanup/
│   │   │   │   │   ├── story.md
│   │   │   │   │   └── [docs]
│   │   │   │   └── 8.5-JavaScript-Optimization/
│   │   │   │       ├── story.md
│   │   │   │       └── [docs]
│   │   │   │
│   │   │   └── EPIC-9-Frontend-Refinement/ (futuro)
│   │   │       └── [estrutura similar]
│   │   │
│   │   └── LEGACY/                                 ← Documentação histórica (não deletar)
│   │       └── [docs migrados para FASE-X]
│   │
│   ├── architecture/
│   │   ├── system-architecture.md
│   │   ├── css-architecture.md
│   │   └── javascript-architecture.md
│   │
│   ├── reviews/
│   │   ├── ux-specialist-review.md
│   │   └── qa-review.md
│   │
│   └── reports/
│       └── TECHNICAL-DEBT-REPORT.md
│
└── .aiox/
    ├── architecture-analysis-patagang-v3.md
    ├── context-engineering-backup.md
    └── [outros dados AIOX]
```

---

## 📄 PADRÃO DE DOCUMENTO POR FASE

### **Cada fase deve ter:**

#### **README.md (Navegação)**
```markdown
# Fase X: [Nome da Fase]

**Propósito:** [Uma linha explicando objetivo]
**Status:** [Completa/Em Andamento/Não Iniciada]
**Documents:** [Lista de arquivos nesta pasta]
**Next Phase:** [Qual fase vem depois]

## 📚 Documentos

| Arquivo | Propósito | Status |
|---------|----------|--------|
| [arquivo].md | [O que faz] | ✅/⏳/❌ |
```

#### **Documento de Contenudo (ex: system-architecture.md)**

Cada documento DEVE ter:

```markdown
# [Título]

**Fase:** [X — Nome]
**Status:** ✅/⏳/❌
**Propriedade:** @[agent-name]
**Criado:** [data]
**Última Atualização:** [data]
**Próximo Documento:** [qual]

---

## Sumário Executivo
[1-3 parágrafos resumindo o conteúdo]

## Conteúdo Principal
[Seções conforme necessário]

## Checklist de Validação
☐ Item 1
☐ Item 2

## Próximos Passos
[O que vem depois]

## Referências
[Links para outros docs]
```

---

## 🔄 4-LEVEL CONTEXT HIERARCHY (Padrão AIOX)

Toda documentação brownfield deve seguir 4 níveis:

### **LEVEL 1: FOUNDATION (Why?)**
**Propósito:** Explicar contexto histórico e decisões
**Arquivo:** `LEVEL-1_Foundation.md`
**Conteúdo:**
- Timeline do projeto
- Decisões arquiteturais históricas
- Padrões legados (IA vs humano)
- Razões por trás de cada escolha

**Exemplo:**
- `8.2-PROJECT-HISTORY-CONTEXT.md` é LEVEL 1

### **LEVEL 2: INVENTORY (Which patterns?)**
**Propósito:** Catalogar padrões, débitos, componentes
**Arquivo:** `LEVEL-2_Inventory.md`
**Conteúdo:**
- Lista de padrões identificados
- Catálogo de débitos técnicos
- Componentes reutilizáveis
- Dependências entre componentes

**Exemplo:**
- `8.2-PATTERNS-INVENTORY.md` é LEVEL 2
- `8.4-BATCH1-ORPHANS-DETAILED-FOR-APPROVAL.md` é LEVEL 2

### **LEVEL 3: BLUEPRINT (How to refactor?)**
**Propósito:** Arquitetura AS-IS/TO-BE e plano de ação
**Arquivo:** `LEVEL-3_Blueprint.md`
**Conteúdo:**
- Arquitetura atual (AS-IS)
- Arquitetura proposta (TO-BE)
- Fases de refatoração
- Dependências entre fases
- Riscos por fase

**Exemplo:**
- `8.2-FASE2-ARCHITECTURE-BLUEPRINT.md` é LEVEL 3
- `.aiox/architecture-analysis-patagang-v3.md` é LEVEL 3

### **LEVEL 4: GOVERNANCE (How to inherit?)**
**Propósito:** Living documentation, herança de contexto, padrões
**Arquivo:** `LEVEL-4_Governance.md`
**Conteúdo:**
- Padrões de código a manter
- Padrões a evitar
- Como novos developers herdaim conhecimento
- Checklist de qualidade
- Decisões que impactam próximas stories

**Exemplo:**
- `8.2-CONTEXT-GOVERNANCE.md` é LEVEL 4

---

## 📊 MATRIZ DE RASTREABILIDADE

Cada story deve ter matriz linkando:

```markdown
## Rastreabilidade Brownfield Discovery

| Fase | Artefato | Arquivo | Status | Owner |
|------|----------|---------|--------|-------|
| 1 | System Docs | system-architecture.md | ✅ | @architect |
| 3 | Frontend Spec | frontend-spec.md | ✅ | @ux-design-expert |
| 4 | DRAFT | technical-debt-DRAFT.md | ✅ | @architect |
| 6 | UX Review | ux-specialist-review.md | ✅ | @ux-design-expert |
| 7 | QA Review | qa-review.md | ✅ | @qa |
| 8 | Assessment | technical-debt-assessment.md | ⏳ | @architect |
| 9 | Report | TECHNICAL-DEBT-REPORT.md | ❌ | @analyst |
| 10 | Stories | docs/stories/epic-*.md | ✅ | @pm |
```

---

## 🎯 ORGANIZAÇÃO DE STORIES

Cada story tem sua pasta dedicada:

```
STORIES/EPIC-X-Name/
├── X.Y-SubFeature/
│   ├── story.md                          ← Arquivo da story (do sistema)
│   ├── DOCUMENTATION-INDEX.md            ← Índice centralizado
│   ├── X.Y-PROJECT-HISTORY-CONTEXT.md    ← LEVEL 1
│   ├── X.Y-PATTERNS-INVENTORY.md         ← LEVEL 2
│   ├── X.Y-ARCHITECTURE-BLUEPRINT.md     ← LEVEL 3
│   ├── X.Y-CONTEXT-GOVERNANCE.md         ← LEVEL 4
│   ├── X.Y-COMPLETION-REPORT.md          ← Resultado
│   └── REFERENCES/
│       ├── Root-cause-analysis.md
│       ├── Technical-decisions.md
│       └── [outros]
```

---

## ✅ CHECKLIST DE ORGANIZAÇÃO

Quando organizar documentações, verificar:

```
☐ Todos docs na pasta FASE correta (1-10)
☐ README.md em cada pasta FASE
☐ Documentos com frontmatter (Fase, Status, Owner, Dates)
☐ LEVEL 1-4 hierarchy mapeada
☐ Matriz de rastreabilidade completa
☐ Links entre docs funcionando
☐ Índice centralizado (BROWNFIELD-DISCOVERY-INDEX.md) atualizado
☐ Legacy docs movido para LEGACY/ (não deletado)
☐ Nenhum conteúdo perdido (apenas reorganizado)
☐ Checklist de validação em cada doc
```

---

## 🔗 LINKS PADRÃO ENTRE DOCS

Cada documento deve linkar para:
- **Fase anterior:** "← Fase X-1: [nome]"
- **Fase seguinte:** "Fase X+1: [nome] →"
- **Documentos relacionados:** "Ver também: [link]"
- **Stories associadas:** "Usado em: Story X.Y"

---

## 📈 EXEMPLO APLICADO: Story 8.2 Reorganização

**ANTES (desorganizado):**
```
docs/guides/
├── 8.2-DOCUMENTATION-INDEX.md
├── 8.2-PROJECT-HISTORY-CONTEXT.md
├── 8.2-PATTERNS-INVENTORY.md
├── 8.2-FASE2-ARCHITECTURE-BLUEPRINT.md
├── 8.2-CONTEXT-GOVERNANCE.md
└── [20+ outros arquivos misturados]
```

**DEPOIS (organizado AIOX):**
```
docs/guides/
├── STORIES/EPIC-8-Technical-Refactoring/
│   └── 8.2-Critical-CSS/
│       ├── story.md
│       ├── README.md
│       ├── LEVEL-1_PROJECT-HISTORY-CONTEXT.md
│       ├── LEVEL-2_PATTERNS-INVENTORY.md
│       ├── LEVEL-3_ARCHITECTURE-BLUEPRINT.md
│       ├── LEVEL-4_CONTEXT-GOVERNANCE.md
│       ├── 8.2-COMPLETION-REPORT.md
│       └── REFERENCES/
│           ├── css-analysis.md
│           └── [outros]
│
├── FASE-1_System-Documentation/
│   ├── system-architecture.md (referencia 8.2 aqui)
│
├── FASE-4_Initial-Consolidation/
│   └── technical-debt-DRAFT.md (inclui achados 8.2)
```

---

## 🚀 BENEFÍCIOS DESSA ESTRUTURA

✅ **Clareza:** Você sabe exatamente aonde procurar
✅ **Escalabilidade:** Adicionar nova story é trivial
✅ **Rastreabilidade:** Cada artefato linkado à fase
✅ **Herança:** Próximos devs entendem contexto (LEVEL 1-4)
✅ **Conformidade AIOX:** Segue padrão de 10-fase brownfield
✅ **Nenhuma perda:** Conteúdo reorganizado, nunca deletado
✅ **Eficiência:** Documentos centralizados, links clara

---

## 📝 PRÓXIMOS PASSOS PARA APLICAR

1. ✅ Criar pastas FASE-1 até FASE-10
2. ✅ Mover documentações existentes para pastas FASE corretas
3. ✅ Renomear seguindo padrão (adicionar LEVEL se aplicável)
4. ✅ Criar README.md em cada FASE
5. ✅ Criar BROWNFIELD-DISCOVERY-INDEX.md centralizado
6. ✅ Linkarvtodos os documentos (cross-references)
7. ✅ Atualizar CONTEXT-HIERARCHY com LEVEL 1-4
8. ✅ Validar que nenhum conteúdo foi perdido

---

**Status:** PRONTO PARA APLICAÇÃO
**Próximo:** Aguardando análise de risco de etapas para determinar sequência segura de execução


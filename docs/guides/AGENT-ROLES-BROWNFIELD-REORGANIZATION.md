# 🤖 AGENT ROLES & RESPONSIBILITIES — Brownfield Discovery Reorganization Plan

**Projeto:** Patagang Ecommerce (Nuvemshop FTP Theme)
**Objetivo:** Reorganizar documentações conforme AIOX Brownfield Standard
**Metodologia:** Designação clara de agentes + tarefas específicas
**Timeline:** 2-3 horas (reorganização) + 4-6 semanas (execução)
**Autoridade:** Gabriel Cristofolini (CTO) + @aiox-master (Orchestration)

---

## 🏛️ MATRIZ DE AGENTES POR FASE (Brownfield Discovery 10 Fases)

### **FASE 1: System Documentation (@architect — Aria)**
**Responsabilidade:** Documentar arquitetura completa do projeto
**Artefatos Atuais:**
- `.aiox/architecture-analysis-patagang-v3.md` ✅ (análise estrutural)
- Story 8.2: `8.2-PRODUCT-LAYOUT-ARCHITECTURE-ANALYSIS.md` ✅ (PDP analysis)

**Tarefas de Reorganização:**
```
1. ✅ Revisar `.aiox/architecture-analysis-patagang-v3.md`
2. ✅ Criar FASE-1_System-Documentation/ folder
3. ✅ Mover/copiar para: docs/guides/FASE-1_System-Documentation/
   └─ system-architecture.md (consolidado)
   └─ codebase-analysis.md (estrutura FTP)
   └─ css-architecture.md (load order)
   └─ javascript-architecture.md (bundle map)
4. ✅ Criar README.md (navegação FASE 1)
5. ✅ Linkar para próxima FASE (Frontend Documentation)
```

**Status Após Reorganização:**
- ✅ FASE 1 completa e centralizada
- ✅ Pronto para @ux-design-expert (FASE 3)

**Próxima Ação:** @architect confirma documentação está completa

---

### **FASE 2: Database Documentation (@data-engineer — Dara)**
**Responsabilidade:** Auditar banco de dados (se aplicável)
**Status para Patagang:** ⚪ **SKIP — Frontend Only**

**Justificativa:**
- Projeto é Nuvemshop FTP Theme (não tem banco próprio)
- Nuvemshop gerencia database completamente
- Nenhuma migração de schema necessária

**Tarefas:**
```
[ ] Criar FASE-2_Database-Documentation/ folder (vazia, com README explicando skip)
[ ] Documentar: "Database management is handled by Nuvemshop platform"
[ ] Link direto para FASE 3 (Frontend)
```

---

### **FASE 3: Frontend Documentation (@ux-design-expert — Uma)**
**Responsabilidade:** Documentar UI/UX, componentes, padrões visuais
**Artefatos Atuais:**
- Story 8.2: `8.2-PRODUCT-LAYOUT-ARCHITECTURE-ANALYSIS.md` ✅
- Story 8.3: `8.3-VISUAL-DESIGN-ADJUSTMENTS-MAPPED.md` ✅
- Story 8.4: `8.4-BATCH1-ORPHANS-DETAILED-FOR-APPROVAL.md` ✅ (snipplets inventory)

**Tarefas de Reorganização:**
```
1. ✅ Revisar documentações existentes (8.2, 8.3, 8.4)
2. ✅ Criar FASE-3_Frontend-Documentation/ folder
3. ✅ Consolidar em:
   └─ frontend-spec.md (UI componentes, padrões)
   └─ ux-analysis.md (user flows, mobile/desktop)
   └─ component-inventory.md (snipplets, organizados)
   └─ design-system.md (colors, typography, spacing)
4. ✅ Linkar stories 8.2, 8.3, 8.4 (referências)
5. ✅ Criar README.md (navegação FASE 3)
```

**Status Após Reorganização:**
- ✅ FASE 3 consolidada
- ✅ Pronto para @architect (FASE 4)

**Próxima Ação:** @ux-design-expert confirma UI/UX documentado

---

### **FASE 4: Consolidation Inicial (@architect — Aria)**
**Responsabilidade:** Consolidar achados em DRAFT, preparar para validação
**Artefatos Atuais:**
- NENHUM formal `technical-debt-DRAFT.md` centralizado
- Débitos espalhados em stories 8.2, 8.3, 8.4, 8.5

**Tarefas de Reorganização:**
```
1. ✅ Criar FASE-4_Initial-Consolidation/ folder
2. ✅ Ler TODAS as documentações:
   ├─ FASE-1: system-architecture.md
   ├─ FASE-3: frontend-spec.md + ux-analysis.md
   ├─ Stories 8.2-8.5: todos os docs
   └─ Análise de risco (agente Plan)
3. ✅ Criar: technical-debt-DRAFT.md
   └─ Seção 1: Débitos de Sistema (FASE 1)
   └─ Seção 2: Débitos de Frontend (FASE 3)
   └─ Seção 3: Matriz preliminar (priorização)
   └─ Seção 4: Perguntas para especialistas
4. ✅ Linkar para validações especialistas (FASE 5-7)
5. ✅ Criar README.md (navegação FASE 4)
```

**Status Após Reorganização:**
- ✅ DRAFT centralizado
- ✅ Pronto para validações (FASE 5-7)

**Próxima Ação:** @architect confirma DRAFT pronto para review

---

### **FASE 5-7: Specialist Reviews (@data-engineer, @ux-design-expert, @qa)**

#### **FASE 5: Database Review (@data-engineer — Dara)**
**Status:** ⚪ SKIP (não aplicável)

#### **FASE 6: UX/Frontend Review (@ux-design-expert — Uma)**
**Responsabilidade:** Validar débitos de UI, estimar esforço, propor soluções

**Artefatos Atuais:**
- Story 8.3: `8.3-VISUAL-DESIGN-ADJUSTMENTS-MAPPED.md` ✅
- Story 8.4: `8.4-BATCH1-ORPHANS-DETAILED-FOR-APPROVAL.md` ✅

**Tarefas de Reorganização:**
```
1. ✅ Criar FASE-5-7_Specialist-Reviews/ folder
2. ✅ Criar: ux-specialist-review.md
   └─ Lê technical-debt-DRAFT.md (FASE 4)
   └─ Valida cada débito de UI/UX
   └─ Estima horas por débito
   └─ Prioriza conforme UX impact
   └─ Responde perguntas do architect
3. ✅ Consolidar: 8.3-VISUAL-DESIGN-ADJUSTMENTS-MAPPED.md (ref)
4. ✅ Consolidar: 8.4-BATCH1-ORPHANS-DETAILED-FOR-APPROVAL.md (ref)
5. ✅ Criar README.md (navegação FASE 5-7)
```

**Status Após Reorganização:**
- ✅ UX review centralizado
- ✅ Pronto para QA review

**Próxima Ação:** @ux-design-expert valida e assina off

#### **FASE 7: QA Review (@qa — Quinn)**
**Responsabilidade:** QA gate — validar completude, identificar gaps, sugerir testes

**Artefatos Atuais:**
- NENHUM formal `qa-review.md` para discovery (qa gates existem por story)

**Tarefas de Reorganização:**
```
1. ✅ Criar: qa-review.md
   └─ Lê technical-debt-DRAFT.md (FASE 4)
   └─ Lê ux-specialist-review.md (FASE 6)
   └─ Identifica gaps (áreas não cobertas)
   └─ Avalia riscos cruzados
   └─ Valida dependências entre débitos
   └─ Sugere testes para validação
   └─ Gate: APPROVED / NEEDS WORK
2. ✅ Criar README.md (navegação FASE 5-7)
```

**Status Após Reorganização:**
- ✅ QA review centralizado
- ✅ Gate decision ready

**Próxima Ação:** @qa assina off no QA review

---

### **FASE 8: Final Assessment (@architect — Aria)**
**Responsabilidade:** Consolidar todos os reviews, criar assessment final

**Artefatos Atuais:**
- NENHUM formal `technical-debt-assessment.md`

**Tarefas de Reorganização:**
```
1. ✅ Criar FASE-8_Final-Assessment/ folder
2. ✅ Criar: technical-debt-assessment.md
   └─ Incorpora DRAFT (FASE 4)
   └─ Incorpora UX review (FASE 6)
   └─ Incorpora QA review (FASE 7)
   └─ Recalcula prioridades (consolidado)
   └─ Define ordem final de resolução
   └─ Matriz final de débitos (todas as stories)
   └─ Timeline estimada
   └─ Riscos e mitigações
3. ✅ Criar README.md (navegação FASE 8)
```

**Status Após Reorganização:**
- ✅ Assessment final centralizado
- ✅ Pronto para relatório executivo

**Próxima Ação:** @architect confirma assessment final

---

### **FASE 9: Executive Report (@analyst — Alex)**
**Responsabilidade:** Criar relatório para stakeholders (ROI, impacto negócio)

**Artefatos Atuais:**
- NENHUM formal `TECHNICAL-DEBT-REPORT.md`

**Tarefas de Reorganização:**
```
1. ✅ Criar FASE-9_Executive-Report/ folder
2. ✅ Criar: TECHNICAL-DEBT-REPORT.md
   └─ Executive summary (1 página)
   └─ Números-chave (total débitos, esforço, ROI)
   └─ Análise de custos (resolver vs não resolver)
   └─ Impacto no negócio (performance, UX, dev velocity)
   └─ Timeline recomendada (fases)
   └─ ROI da resolução
   └─ Próximos passos
3. ✅ Lê: technical-debt-assessment.md (FASE 8)
4. ✅ Cria narrativa em linguagem de negócio (não técnica)
5. ✅ Criar README.md (navegação FASE 9)
```

**Status Após Reorganização:**
- ✅ Relatório executivo pronto
- ✅ Para stakeholder awareness

**Próxima Ação:** @analyst entrega relatório

---

### **FASE 10: Planning (@pm — Morgan)**
**Responsabilidade:** Criar Epic + Stories para execução

**Artefatos Atuais:**
- ✅ Stories 8.1, 8.2, 8.3, 8.4, 8.5 já criadas (parcialmente)
- ❌ Epic formal `epic-technical-debt.md` não existe

**Tarefas de Reorganização:**
```
1. ✅ Criar FASE-10_Planning/ folder
2. ✅ Criar: epic-technical-debt.md
   └─ Epic definition
   └─ Objetivo (reduzir débitos técnicos)
   └─ Escopo (5 stories)
   └─ Success criteria (Lighthouse ≥85, !important < 50, etc)
   └─ Timeline (4-6 semanas)
   └─ Budget aprovado (Gabriel)
   └─ Stories linked:
      ├─ 8.1: Design Tokens (DONE)
      ├─ 8.2: CSS Reduction (IN PROGRESS)
      ├─ 8.3: !important Removal (IN PROGRESS)
      ├─ 8.4: Template Cleanup (TODO)
      └─ 8.5: JavaScript Optimization (TODO)
3. ✅ Criar organização de stories:
   ├─ STORIES/EPIC-8-Technical-Refactoring/
   │  ├─ 8.1-Design-Tokens/
   │  │  ├─ story.md
   │  │  ├─ COMPLETION-REPORT.md
   │  │  └─ [referencias]
   │  ├─ 8.2-Critical-CSS/
   │  │  ├─ story.md
   │  │  ├─ 8.2-DOCUMENTATION-INDEX.md (existente)
   │  │  ├─ LEVEL-1_PROJECT-HISTORY.md
   │  │  ├─ LEVEL-2_PATTERNS-INVENTORY.md
   │  │  ├─ LEVEL-3_ARCHITECTURE-BLUEPRINT.md
   │  │  ├─ LEVEL-4_CONTEXT-GOVERNANCE.md
   │  │  └─ [outros docs reorganizados]
   │  ├─ 8.3-Remove-Important/ [similar]
   │  ├─ 8.4-Template-Cleanup/ [similar]
   │  └─ 8.5-JavaScript-Optimization/ [similar]
4. ✅ Linkar todas as stories ao epic
5. ✅ Criar README.md (navegação FASE 10)
```

**Status Após Reorganização:**
- ✅ Epic formal criado
- ✅ Stories organizadas conforme AIOX L1-L4
- ✅ Pronto para desenvolvimento

**Próxima Ação:** @pm confirma estrutura de stories

---

## 📚 AGENT ROLES POR STORY & LEVEL (4-Level Context Hierarchy)

### **Mapeamento LEVEL 1-4 com Agentes**

```
Cada Story (8.1-8.5) deve ter:

LEVEL 1: Foundation (Why?) — @architect ou @analyst
  └─ Histórico, decisões legadas, contexto
  └─ Arquivo: STORY_X.Y-PROJECT-HISTORY-CONTEXT.md
  └─ Exemplo: 8.2-PROJECT-HISTORY-CONTEXT.md ✅ (já existe)

LEVEL 2: Inventory (Which patterns?) — @analyst
  └─ Padrões identificados, catálogo de débitos
  └─ Arquivo: STORY_X.Y-PATTERNS-INVENTORY.md
  └─ Exemplo: 8.2-PATTERNS-INVENTORY.md ✅ (já existe)
             8.4-BATCH1-ORPHANS-DETAILED-FOR-APPROVAL.md ✅

LEVEL 3: Blueprint (How to refactor?) — @architect
  └─ Arquitetura AS-IS/TO-BE, fases de implementação
  └─ Arquivo: STORY_X.Y-ARCHITECTURE-BLUEPRINT.md
  └─ Exemplo: 8.2-FASE2-ARCHITECTURE-BLUEPRINT.md ✅

LEVEL 4: Governance (How to inherit?) — @architect
  └─ Living documentation, padrões a manter/evitar
  └─ Arquivo: STORY_X.Y-CONTEXT-GOVERNANCE.md
  └─ Exemplo: 8.2-CONTEXT-GOVERNANCE.md ✅
```

### **Agentes por Story (Responsabilidades)**

#### **Story 8.1 — Design Tokens**
- ✅ @architect: System architecture (LEVEL 3)
- ✅ @dev: Implementation ✅ COMPLETA (v1.2.0)
- ✅ @qa: QA gate ✅ PASS
- ✅ @devops: FTP deploy ✅ v1.2.0

**Reorganização:**
```
Mover docs para: docs/guides/STORIES/EPIC-8-Technical-Refactoring/8.1-Design-Tokens/
├─ story.md (original)
├─ 8.1-COMPLETION-REPORT.md (novo)
└─ REFERENCES/
   └─ [achados/decisões]
```

---

#### **Story 8.2 — Critical CSS Reduction**
- @architect: LEVEL 1, 3, 4 ✅ (8.2-PROJECT-HISTORY, ARCHITECTURE-BLUEPRINT, CONTEXT-GOVERNANCE)
- @analyst: LEVEL 2 ✅ (8.2-PATTERNS-INVENTORY)
- @ux-design-expert: Validar redesign (LEVEL 3)
- @dev: Implementation 🔄 ETAPA 1 COMPLETA, ETAPA 2-3 TODO
- @qa: QA gate 🔄 IN PROGRESS
- @devops: FTP deploy 🔄 v1.5.9+

**Reorganização:**
```
Mover docs para: docs/guides/STORIES/EPIC-8-Technical-Refactoring/8.2-Critical-CSS/
├─ story.md
├─ 8.2-DOCUMENTATION-INDEX.md ✅ (mantém)
├─ LEVEL-1_PROJECT-HISTORY-CONTEXT.md ✅
├─ LEVEL-2_PATTERNS-INVENTORY.md ✅
├─ LEVEL-3_ARCHITECTURE-BLUEPRINT.md ✅
├─ LEVEL-4_CONTEXT-GOVERNANCE.md ✅
├─ 8.2-COMPLETION-REPORT.md (novo, após completa)
└─ REFERENCES/
   ├─ 8.2-PRODUCT-LAYOUT-ARCHITECTURE-ANALYSIS.md
   ├─ 8.2-FASE1-COMPLETION-REPORT.md
   ├─ 8.2-FASE2-EXECUTION-LOG.md
   ├─ 8.2-FASE2-DEPLOY-VALIDATION-GUIDE.md
   └─ [outros]
```

---

#### **Story 8.3 — Remove !important**
- @architect: LEVEL 1, 3, 4 (criar histórico, blueprint, governance)
- @analyst: LEVEL 2 (identificar todos !important)
- @ux-design-expert: Validar visual (LEVEL 3)
- @dev: Implementation 🔄 ETAPA B COMPLETA, ETAPA B.2 + C TODO
- @qa: QA gate 🔄 IN PROGRESS
- @devops: FTP deploy 🔄 v1.5.59+

**Reorganização:**
```
Mover docs para: docs/guides/STORIES/EPIC-8-Technical-Refactoring/8.3-Remove-Important/
├─ story.md
├─ 8.3-DOCUMENTATION-INDEX.md ✅ (mantém)
├─ LEVEL-1_PROJECT-HISTORY.md (novo)
├─ LEVEL-2_PATTERNS-INVENTORY.md (novo — mapear todos !important)
├─ LEVEL-3_ARCHITECTURE-BLUEPRINT.md (novo — fases A, B, C)
├─ LEVEL-4_CONTEXT-GOVERNANCE.md (novo)
├─ 8.3-PHASE-B-COMPLETION-REPORT.md ✅
├─ 8.3-VISUAL-DESIGN-ADJUSTMENTS-MAPPED.md ✅
└─ REFERENCES/
   └─ [notas de fase]
```

---

#### **Story 8.4 — Template Cleanup**
- @architect: LEVEL 1, 3, 4 (criar)
- @analyst: LEVEL 2 ✅ (8.4-BATCH1-ORPHANS-DETAILED-FOR-APPROVAL.md)
- @ux-design-expert: Validar (LEVEL 3)
- @dev: Implementation 📋 TODO
- @qa: QA gate 📋 TODO
- @devops: FTP deploy 📋 TODO

**Reorganização:**
```
Mover docs para: docs/guides/STORIES/EPIC-8-Technical-Refactoring/8.4-Template-Cleanup/
├─ story.md
├─ LEVEL-1_PROJECT-HISTORY.md (novo)
├─ LEVEL-2_PATTERNS-INVENTORY.md (novo)
│  └─ Consolidar: 8.4-BATCH1-ORPHANS-DETAILED-FOR-APPROVAL.md
│  └─ Consolidar: 8.4-BATCH1-SAFE-REMOVAL-DETAILED-ANALYSIS.md
│  └─ Consolidar: 8.4-PHASE-2-DEFERRED-DECISION-LOG.md
├─ LEVEL-3_ARCHITECTURE-BLUEPRINT.md (novo — tiering strategy)
├─ LEVEL-4_CONTEXT-GOVERNANCE.md (novo)
└─ REFERENCES/
   └─ [análise detalhada]
```

---

#### **Story 8.5 — JavaScript Optimization**
- @architect: LEVEL 1, 3, 4 (criar)
- @analyst: LEVEL 2 (prioridades de optimização)
- @dev: Implementation 🔄 v1.5.93 PROGRESSO, Priorities 1-4 TODO
- @qa: QA gate 🔄 IN PROGRESS
- @devops: FTP deploy 🔄 v1.5.94+

**Reorganização:**
```
Mover docs para: docs/guides/STORIES/EPIC-8-Technical-Refactoring/8.5-JavaScript-Optimization/
├─ story.md
├─ LEVEL-1_PROJECT-HISTORY.md (novo)
├─ LEVEL-2_PATTERNS-INVENTORY.md (novo — map JS patterns)
├─ LEVEL-3_ARCHITECTURE-BLUEPRINT.md (novo — modularization plan)
├─ LEVEL-4_CONTEXT-GOVERNANCE.md (novo)
├─ 8.5-IMPLEMENTATION-LOG.md ✅ (mantém)
├─ 8.5-CART-RECOVERY-DOCUMENTATION.md ✅ (mantém)
└─ REFERENCES/
   └─ [analysis docs]
```

---

## 🎯 SEQUÊNCIA DE REORGANIZAÇÃO (Quem Faz O Quê)

### **ROUND 1: Fases 1-3 (Foundation)**

**Semana 1 — Terça-feira (Hoje)**

```
PASSO 1: @architect — Organize FASE 1 (1 hora)
  [ ] Criar FASE-1_System-Documentation/ folder
  [ ] Consolidar architecture docs (copycat from .aiox/)
  [ ] Criar README.md
  Action: git add + commit "docs: organize FASE 1 System Documentation"

PASSO 2: @ux-design-expert — Organize FASE 3 (1.5 horas)
  [ ] Criar FASE-3_Frontend-Documentation/ folder
  [ ] Consolidar frontend specs (8.2, 8.3, 8.4 references)
  [ ] Criar README.md
  Action: git add + commit "docs: organize FASE 3 Frontend Documentation"

PASSO 3: @architect — Create FASE 2 Placeholder (15 min)
  [ ] Criar FASE-2_Database-Documentation/ folder (skip explanation)
  [ ] Criar README.md (explaining "N/A for Nuvemshop")
  Action: git add + commit "docs: add FASE 2 placeholder (database skipped)"

STATUS: Fases 1-3 ✅ Ready for consolidation
OWNER: @architect
NEXT: FASE 4 Consolidation
```

---

### **ROUND 2: Fase 4 (Consolidation)**

**Semana 1 — Quarta-feira**

```
PASSO 4: @architect — Consolidate FASE 4 (2 horas)
  [ ] Criar FASE-4_Initial-Consolidation/ folder
  [ ] Ler FASE-1, FASE-3, Analysis de risco, Stories 8.2-8.5
  [ ] Criar: technical-debt-DRAFT.md
  [ ] Consolidar achados em matriz
  [ ] Linkar para FASE 5-7
  [ ] Criar README.md
  Action: git add + commit "docs: create FASE 4 technical-debt DRAFT"

STATUS: FASE 4 ✅ Draft ready for specialist reviews
OWNER: @architect
NEXT: FASE 5-7 Specialist Reviews (paralelo)
```

---

### **ROUND 3: Fases 5-7 (Reviews)**

**Semana 1 — Quinta-feira**

```
PASSO 5A: @ux-design-expert — UX Review (1.5 horas) [PARALELO]
  [ ] Criar FASE-5-7_Specialist-Reviews/ folder
  [ ] Ler technical-debt-DRAFT.md (FASE 4)
  [ ] Criar: ux-specialist-review.md
  [ ] Validar débitos de UX, estimar horas
  [ ] Linkar references (8.3-VISUAL-DESIGN, 8.4-ORPHANS)
  Action: git add + commit "docs: create FASE 6 UX specialist review"

PASSO 5B: @qa — QA Review (1.5 horas) [PARALELO]
  [ ] Ler technical-debt-DRAFT.md (FASE 4)
  [ ] Ler ux-specialist-review.md (FASE 6)
  [ ] Criar: qa-review.md
  [ ] Identificar gaps, validar dependências
  [ ] Gate: APPROVED / NEEDS WORK
  Action: git add + commit "docs: create FASE 7 QA review"

STATUS: FASE 5-7 ✅ Specialist reviews complete
OWNER: @ux-design-expert + @qa
NEXT: FASE 8 Final Assessment
```

---

### **ROUND 4: Fase 8 (Assessment)**

**Semana 1 — Sexta-feira**

```
PASSO 6: @architect — Final Assessment (1.5 horas)
  [ ] Ler technical-debt-DRAFT.md (FASE 4)
  [ ] Ler ux-specialist-review.md (FASE 6)
  [ ] Ler qa-review.md (FASE 7)
  [ ] Criar: technical-debt-assessment.md FINAL
  [ ] Consolidar prioridades (conforme análise de risco)
  [ ] Definir ordem final de resolução
  [ ] Timeline e riscos
  Action: git add + commit "docs: create FASE 8 final technical debt assessment"

STATUS: FASE 8 ✅ Assessment final complete
OWNER: @architect
NEXT: FASE 9 Executive Report
```

---

### **ROUND 5: Fase 9 (Report)**

**Semana 2 — Segunda-feira**

```
PASSO 7: @analyst — Executive Report (2 horas)
  [ ] Criar FASE-9_Executive-Report/ folder
  [ ] Ler technical-debt-assessment.md (FASE 8)
  [ ] Criar: TECHNICAL-DEBT-REPORT.md
  [ ] Escrever em linguagem de negócio (ROI, impacto)
  [ ] Timeline, custos, benefícios
  [ ] Próximos passos
  Action: git add + commit "docs: create FASE 9 executive report"

STATUS: FASE 9 ✅ Stakeholder report ready
OWNER: @analyst
NEXT: FASE 10 Planning
```

---

### **ROUND 6: Fase 10 (Planning) + Stories Reorganization**

**Semana 2 — Terça-feira**

```
PASSO 8: @pm — Planning Epic (1.5 horas)
  [ ] Criar FASE-10_Planning/ folder
  [ ] Criar: epic-technical-debt.md
  [ ] Listar 5 stories (8.1-8.5) com status
  [ ] Link para TECHNICAL-DEBT-REPORT.md
  Action: git add + commit "docs: create FASE 10 planning epic"

PASSO 9: @sm — Story Reorganization (3 horas) [PARALELO]
  [ ] Criar STORIES/ folder structure
  [ ] Para cada story (8.1-8.5):
    ├─ Criar pasta STORY_X.Y-Name/
    ├─ Mover story.md
    ├─ Reorganizar LEVEL 1-4 docs
    ├─ Criar README.md (navegação)
    └─ Linkar ao epic
  Action: git add + commit "docs: organize stories with LEVEL 1-4 hierarchy"

PASSO 10: @architect — Central Index (1 hora)
  [ ] Criar: BROWNFIELD-DISCOVERY-INDEX.md (central)
  [ ] Mapear FASE-1 até FASE-10
  [ ] Linkar todos os documentos
  [ ] Status dashboard
  Action: git add + commit "docs: create central brownfield discovery index"

STATUS: FASE 10 ✅ Stories organized, planning complete
OWNER: @pm + @sm + @architect
NEXT: Development execution
```

---

## ✅ CHECKLIST DE REORGANIZAÇÃO COMPLETA

**Verifying all phases organized:**

```
PHASE 1 (System Docs) — @architect
  [ ] FASE-1_System-Documentation/ created
  [ ] system-architecture.md consolidated
  [ ] README.md created
  [ ] Links to FASE 2 + 3 working

PHASE 2 (Database) — @data-engineer
  [ ] FASE-2_Database-Documentation/ created (skip explanation)
  [ ] README.md with "N/A" note
  [ ] Links to FASE 3 working

PHASE 3 (Frontend) — @ux-design-expert
  [ ] FASE-3_Frontend-Documentation/ created
  [ ] frontend-spec.md + ux-analysis.md consolidated
  [ ] component-inventory.md created (from orphans analysis)
  [ ] README.md created
  [ ] Links to FASE 4 working

PHASE 4 (Consolidation) — @architect
  [ ] FASE-4_Initial-Consolidation/ created
  [ ] technical-debt-DRAFT.md created (all findings)
  [ ] Debt matrix consolidated
  [ ] Links to FASE 5-7 working

PHASES 5-7 (Reviews) — @ux-design-expert + @qa
  [ ] FASE-5-7_Specialist-Reviews/ created
  [ ] ux-specialist-review.md created
  [ ] qa-review.md created
  [ ] Links to FASE 8 working

PHASE 8 (Assessment) — @architect
  [ ] FASE-8_Final-Assessment/ created
  [ ] technical-debt-assessment.md created (final)
  [ ] Priorities consolidated (per risk analysis)
  [ ] Links to FASE 9 working

PHASE 9 (Report) — @analyst
  [ ] FASE-9_Executive-Report/ created
  [ ] TECHNICAL-DEBT-REPORT.md created
  [ ] ROI + business impact documented
  [ ] Links to FASE 10 working

PHASE 10 (Planning) — @pm + @sm
  [ ] FASE-10_Planning/ created
  [ ] epic-technical-debt.md created
  [ ] STORIES/ folder with EPIC-8-Technical-Refactoring/
  [ ] Stories 8.1-8.5 organized (LEVEL 1-4 per story)
  [ ] README.md per story
  [ ] Links to specs/docs working

CONTEXT HIERARCHY — All agents
  [ ] CONTEXT-HIERARCHY/ folder created
  [ ] LEVEL-1_Foundation.md (why?)
  [ ] LEVEL-2_Inventory.md (which patterns?)
  [ ] LEVEL-3_Blueprint.md (how to refactor?)
  [ ] LEVEL-4_Governance.md (how to inherit?)

CENTRAL INDEX — @architect
  [ ] BROWNFIELD-DISCOVERY-INDEX.md created
  [ ] All phases linked
  [ ] Status dashboard updated
  [ ] Cross-references validated

LEGACY — All agents
  [ ] LEGACY/ folder created
  [ ] Old docs moved (not deleted)
  [ ] Explanations for migrations
```

---

## 🚀 POST-REORGANIZATION ROLES (Execution Phase)

**Após reorganização, papéis para EXECUÇÃO:**

### **Development Cycle (Story Execution)**

**Por Story (8.1-8.5):**
```
@architect
  ├─ LEVEL 3: Ensure blueprint aligns with implementation
  └─ LEVEL 4: Update governance docs as patterns emerge

@dev (Dex)
  ├─ Implement per LEVEL 3 blueprint
  ├─ Update story.md with File List
  └─ Document decisions in story folder

@qa (Quinn)
  ├─ Review per acceptance criteria
  ├─ Create QA result notes
  └─ Gate: PASS / CONCERNS / FAIL

@devops (Gage)
  ├─ FTP deploy when @dev ready
  ├─ Version increment
  └─ Backup creation
```

### **Validation (Gabriel)**
```
Gabriel (CTO)
  ├─ Validate each deployment in production
  ├─ Approve: ✅ OK / ⚠️ CONCERNS / ❌ FAILED
  └─ Link story to BROWNFIELD-DISCOVERY-INDEX.md status
```

---

## 📞 COORDINATION PROTOCOL

**During reorganization, agents coordinate via:**

1. **Daily standups:** Quick updates on folder organization
2. **Handoff protocol:** Each agent leaves notes for next agent
3. **Central index:** BROWNFIELD-DISCOVERY-INDEX.md updated daily
4. **Git commits:** Clear, specific messages with agent initials
   - `@architect: organize FASE 1`
   - `@ux-design-expert: organize FASE 3`
   - etc.

---

## ✨ END RESULT

**After reorganization:**

✅ **10 Fases estruturadas** — Cada uma tem seu lugar, documentação, responsável
✅ **5 Stories organizadas** — Cada uma tem LEVEL 1-4 + referências + README
✅ **Agentes com papéis claros** — Sabem exatamente o que fazer em cada fase
✅ **Central index funcional** — Fácil navegar e entender estado do projeto
✅ **Pronto para execução** — Development pode começar com base estruturada

---

**Próxima ação:** Gabriel aprova → Agents começam Round 1 (FASE 1-3)


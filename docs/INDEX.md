# 📚 Documentação Patagang — Índice Completo

**Last Updated:** 2026-03-24 (Reorganização L4 completa)
**Status:** ✅ Epic 8 CONCLUÍDO (v1.5.93) | 📁 Documentação Reorganizada AIOX
**Branches:** `main` | `feature/8.3-remove-important` (active)

---

## 🎯 Quick Navigation

### Epic 8 — Complete Technical Refactoring (✅ COMPLETED)
All 5 stories completed and deployed to production (v1.5.93).

| Story | Title | Version | Status | Documentation |
|-------|-------|---------|--------|---------------|
| **8.1** | Design Tokens Unification | v1.5.x | ✅ DONE | [Story](../Docs/stories/.archive/8.1/8.1-design-tokens-unification.story.md) |
| **8.2** | Critical CSS Reduction | v1.5.x | ✅ DONE | [Story](../Docs/stories/.archive/8.2/8.2-critical-css-reduction.story.md) \| [Guides](../Docs/stories/.archive/8.2/guides/) |
| **8.3** | !important Resolution | v1.5.x | ✅ DONE | [Story](../Docs/stories/.archive/8.3/8.3-important-resolution.story.md) \| [Guides](../Docs/stories/.archive/8.3/guides/) |
| **8.4** | Template Cleanup | v1.5.93 | ✅ DONE | [Story](../Docs/stories/.archive/8.4/8.4-template-cleanup.story.md) \| [Guides](../Docs/stories/.archive/8.4/guides/) |
| **8.5** | JavaScript Optimization | v1.5.93 | ✅ APPROVED | [Story](../Docs/stories/.archive/8.5/8.5-javascript-optimization.story.md) \| [Guides](../Docs/stories/.archive/8.5/guides/) |

---

## 📂 Documentation Structure (AIOX L4)

### 🎬 Stories — Development Workflows
**Location:** `docs/stories/`

Formal user stories with acceptance criteria, development notes, and testing procedures.

- `8-epic-technical-refactoring.md` — Epic overview and dependencies
- `8.1-design-tokens-unification.story.md` — Design system unification
- `8.2-critical-css-reduction.story.md` — CSS optimization (< 50KB)
- `8.3-important-resolution.story.md` — Specificity-based !important removal
- `8.4-template-cleanup.story.md` — Snippet consolidation
- `8.5-javascript-optimization.story.md` — JS lazy-loading & consolidation

### 📖 Guides — How-To & Process Documentation
**Location:** `docs/guides/`

Implementation guides, checklists, and workflow documentation organized by story.

#### 8.2 — Critical CSS Reduction
- `guides/8.2/` — Guides, checklists, execution trackers for Story 8.2
- Reference: `.claude/rules/devops-epic8-standard-workflow.md` (validation checklist path)

#### 8.3 — !important Resolution
- `guides/8.3/` — Strategy, validation checklist, implementation guide
- Reference: Pattern documented in `.aiox-core/data/patagang-learned-patterns.yaml`

#### 8.4 — Template Cleanup
- `guides/8.4/` — Orphan analysis, cleanup phases, execution notes

#### 8.5 — JavaScript Optimization
- `guides/8.5/` — Implementation log, JavaScript analysis, optimization plan
- Reference: FTP recovery strategy in `.aiox-core/data/patagang-learned-patterns.yaml`

#### General Guides
- `guides/CACHE_BUSTING_EXPLICADO.md` — Cache busting explanation
- `guides/nuvemshop/` — Nuvemshop-specific integration guides

### 📊 Reports — Technical Analysis & Completion
**Location:** `docs/reports/`

Technical reports, deployment summaries, and execution logs organized by domain.

#### Epic 8 Execution
- `reports/.archive/epic8/` — Consolidated Epic 8 documentation
  - `EPIC8-EXECUTION-MASTER-LOG.md` — Complete execution history
  - `BROWNFIELD-DISCOVERY-COMPLETION-SUMMARY.md` — Discovery summary
  - `REFACTORING-EPIC8-SUMMARY.md` — Epic completion report
  - `REFACTORING-STATUS.md` — Status tracking across phases
  - `STORY-8.3-*.md` — Story-specific reports (deployment, validation, audit)
  - [`8.2-css-analysis.md`](../Docs/reports/.archive/epic8/8.2-css-analysis.md) — CSS analysis from Story 8.2 (Epic 8 arquivo)
  - `GITHUB-INTEGRATION-VALIDATION.md` — GitHub integration validation

#### Deployment Reports
- `reports/.archive/sessions/DEVOPS-DEPLOYMENT-REPORT.md` — FTP deployment workflow & logs (arquivo)
- `reports/*.md` — Previous story completion reports

### 🏗️ Architecture — Design Decisions & Technical Analysis
**Location:** `docs/architecture/`

System design, technical decisions, and architectural documentation.

#### Patagang Architecture
- [patagang-ai-operating-context.md](../Docs/architecture/patagang-ai-operating-context.md) — **Canónico (AIOX):** pré-voo para agentes/IA no tema Nuvemshop (auditoria, CSS, checklist, deploy)
- `architecture/patagang/` — Project-specific architecture
  - `architecture-analysis-patagang-v3.md` — Complete system analysis (v3)
  - `OPTIMIZATION_PLAN.md` — Technical optimization roadmap
  - `README.md` — Architecture navigation index

---

## 🔗 Quick Links by Purpose

### For **Gabriel** (Project Owner/CTO)
**Validation & Approval:**
- [Epic 8 Master Log](reports/.archive/epic8/EPIC8-EXECUTION-MASTER-LOG.md) — Complete history
- [Story 8.5 JavaScript Optimization](stories/8.5-javascript-optimization.story.md) — Current story in validation
- [Deployment Status](reports/.archive/epic8/REFACTORING-EPIC8-SUMMARY.md) — v1.5.93 deployment details
- **Validate at:** https://patagang.com.br/ (v1.5.93 production)

**Framework & Architecture:**
- [CODEBASE.md](../CODEBASE.md) — Ponte AIOX: ordem de leitura para tema (`Docs/architecture/patagang-ai-operating-context.md`)
- [Patagang Architecture](architecture/patagang/architecture-analysis-patagang-v3.md) — System design

### For **@dev** (Development Team)
**Implementation Guides:**
- [Story 8.2 Guides (arquivo)](../Docs/stories/.archive/8.2/guides/) — CSS reduction techniques & checklist
- [Story 8.3 Guides (arquivo)](../Docs/stories/.archive/8.3/guides/) — CSS specificity strategy
- [Story 8.4 Guides (arquivo)](../Docs/stories/.archive/8.4/guides/) — Template cleanup process
- [Story 8.5 Guides (arquivo)](../Docs/stories/.archive/8.5/guides/) — JavaScript optimization patterns

**Technical Reference:**
- [AI operating context (canonical)](../Docs/architecture/patagang-ai-operating-context.md) — Ler antes de mudar `theme-deploy-corrigido/`
- [Learned Patterns](../.aiox-core/data/patagang-learned-patterns.yaml) — CSS, cart recovery, FTP strategies
- [Nuvemshop Constraints](../.claude/rules/nuvemshop-ftp-constraints.md) — Platform constraints (8/8 checklist)

### For **@qa** (Quality Assurance)
**Validation Checklists:**
- [Epic 8 Workflow (arquivo)](../Docs/epics/.archive/EPIC-8-WORKFLOW-COMPLETE-GUIDE.md) — Validation process
- [Story Acceptance Criteria](stories/8.1-design-tokens-unification.story.md#acceptance-criteria) — Testing requirements
- [FTP Pre-Gate Checklist](../.claude/rules/devops-epic8-standard-workflow.md) — Deployment validation

**QA Reports:**
- [Epic 8 Reports](reports/.archive/epic8/) — All quality gates & verdicts

### For **@devops** (Deployment/Infrastructure)
**Deployment Procedures:**
- [DevOps Standard Workflow](../.claude/rules/devops-epic8-standard-workflow.md) — Mandatory workflow (Commit → Deploy → Validate → Push)
- [Deployment Status](reports/.archive/epic8/) — Version tracking & backup locations

**Rollback & Recovery:**
- [Learned Patterns — FTP Recovery](../.aiox-core/data/patagang-learned-patterns.yaml#ftpRecoverySafe) — Rollback procedure
- FTP Deploy Logs: `ftp-deploy/logs/` — Deployment history

### For **@architect** (Architecture & Design)
**Architecture Documents:**
- [System Architecture v3](architecture/patagang/architecture-analysis-patagang-v3.md) — Complete analysis
- [Optimization Plan](architecture/patagang/OPTIMIZATION_PLAN.md) — Technical strategy

**Design Decisions:**
- [Learned Patterns](../.aiox-core/data/patagang-learned-patterns.yaml) — CSS strategy, specificity, recovery patterns
- [FTP Constraints](../.claude/rules/nuvemshop-ftp-constraints.md) — Platform architecture rules

---

## 📊 Project Status — Epic 8

### Completion Status
```
✅ Epic 8 — Complete
  ✅ Story 8.1 — Design Tokens                    (v1.5.x)
  ✅ Story 8.2 — Critical CSS Reduction          (v1.5.x)
  ✅ Story 8.3 — !important Resolution           (v1.5.x)
  ✅ Story 8.4 — Template Cleanup                (v1.5.93)
  ⏳ Story 8.5 — JavaScript Optimization         (v1.5.93 — PENDING GABRIEL)
```

### Version Timeline
| Version | Story | Date | Status |
|---------|-------|------|--------|
| v1.5.72 | 8.1-8.2 | 2026-03-XX | ✅ Deployed |
| v1.5.93 | 8.3-8.5 (recovery) | 2026-03-24 | 🔴 Production (v1.5.74 + cart recovery) |

**Current Production:** v1.5.93 (awaiting Gabriel validation)
**Backup Available:** All versions recoverable via `ftp-deploy/rollback-incremental.js`

### Learned Patterns Captured
1. ✅ CSS Specificity Strategy (Story 8.3) — Replace !important via increased specificity
2. ✅ Cart Recovery Pattern (Story 8.4/8.5) — Preserve cupom GANGDAPATA + ONG association
3. ✅ FTP Recovery Safe (Epic 8.5) — Rollback procedure via rollback-incremental.js

---

## 📋 Documentation Reorganization (2026-03-24)

### What Changed
All documentation moved from scattered locations to proper AIOX L4 structure:
- **Before:** Stories mixed with guides, reports, logs all in `Docs/guides/`
- **After:** Organized by type (stories/, guides/8.x/, reports/.archive/epic8/, architecture/patagang/)

### Files Reorganized
| File(s) | From | To | Reason |
|---------|------|----|---------|
| Story files | Docs/ | Docs/stories/ | Formal story documents |
| Story guides/checklists | Docs/guides/ | Docs/guides/8.x/ | Organized by story |
| Reports/logs | Scattered | Docs/reports/.archive/epic8/ | Consolidated in reports domain |
| Architecture analysis | .aiox/ | Docs/architecture/patagang/ | Permanent documentation |
| FTP deploy logs | Root + Docs | ftp-deploy/logs/ | Runtime artifacts |
| Scripts | Root | scripts/ | Utility scripts |

### Git History Preserved
All moves used `git mv` to preserve commit history. Example:
```bash
git log --follow Docs/reports/.archive/epic8/EPIC8-EXECUTION-MASTER-LOG.md
# Shows original location and all commits
```

---

## 🚀 Next Steps

### Immediate (Story 8.5)
1. **Gabriel validates** v1.5.93 in production (https://patagang.com.br/)
2. **Decision:** ✅ APPROVED / ⚠️ CONCERNS / ❌ FAILED
3. **DevOps pushes** to GitHub (if approved)

### Short Term (Stories 8.6+)
1. Continue with next stories using updated structure
2. New stories should follow guide at `.claude/rules/file-structure-standards.md`
3. Document patterns in `.aiox-core/data/patagang-learned-patterns.yaml`

### Future (Brownfield Discovery)
1. Complete brownfield assessment workflow
2. Identify technical debt
3. Plan improvements based on AIOX IDS (Incremental Development System)

---

## 🧭 How to Use This Index

### Finding Documentation
1. **Know the story?** → Go to [Stories](#-stories--development-workflows)
2. **Need how-to guide?** → Go to [Guides](#-guides--how-to--process-documentation)
3. **Looking for analysis?** → Go to [Reports](#-reports--technical-analysis--completion)
4. **Investigating architecture?** → Go to [Architecture](#️-architecture--design-decisions--technical-analysis)

### By Role
- **🎬 Gabriel:** Validation & project status [links above](#for-gabriel-project-ownerctoquick-links-by-purpose)
- **💻 @dev:** Implementation guides & patterns [links above](#for-dev-development-teamquick-links-by-purpose)
- **🔍 @qa:** Checklists & validation criteria [links above](#for-qa-quality-assurancequick-links-by-purpose)
- **🚀 @devops:** Deployment procedures & rollback [links above](#for-devops-deploymentinfrastructurequick-links-by-purpose)
- **🏗️ @architect:** Architecture & design decisions [links above](#for-architect-architecture--designquick-links-by-purpose)

---

## 📞 Contact & Support

**Maintained by:**
- @architect — Architecture & structure decisions
- @dev — Implementation patterns & guides
- @devops — Deployment & version management
- @qa — Validation & testing documentation

**Last Review:** 2026-03-24 (documentation reorganization complete)
**Next Review:** After Story 8.6 completion or 2026-04-07 (quarterly)

---

## 🔐 Access & Confidentiality

All documentation is **internal and project-specific**:
- ✅ For Patagang development team only
- ❌ Not for public distribution
- 🔒 Contains customer-sensitive information (Nuvemshop configuration)
- 📋 Implementation details and technical decisions

---

**🏆 Status:** Documentation reorganized to AIOX L4 standards (2026-03-24)
**✅ All 5 stories in Epic 8 completed and deployed**
**⏳ Awaiting production validation (Gabriel)**

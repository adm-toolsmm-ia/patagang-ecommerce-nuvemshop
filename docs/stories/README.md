# Patagang E-commerce Stories

**Type:** Development Stories (L4 — Project Runtime)
**Framework:** AIOX Story Development Cycle (SDC)
**Last Updated:** 2026-03-21

---

## Overview

Histórias organizadas por épico, representando as melhorias implementadas na loja Nuvemshop Patagang.

---

## 📊 Story Index

### Epic 7 — Nuvemshop Store Corrections
**Status:** Completed (v1.1.18)
**Duration:** Single session

| Story | Title | Status | Version |
|-------|-------|--------|---------|
| 7.1 | Corrigir Página de Produto (Desconto + Layout) | ✅ Deployed | v1.1.18 |

---

### Epic 8 — Refatoração Técnica CSS & JavaScript
**Status:** Pending Approval
**Duration:** 3-4 weeks (2 devs)
**Priority:** High

Complete refactoring of CSS and JavaScript for better performance, maintainability, and code quality.

| Story | Phase | Title | Effort | Status |
|-------|-------|-------|--------|--------|
| 8.1 | 1 | Unificação de Design Tokens | 13h | Draft |
| 8.2 | 2 | Redução do style-critical.tpl | 21h | Draft |
| 8.3 | 3 | Resolução de !important | 34h | Draft |
| 8.4 | 4 | Otimização de Templates | 13h | Draft |
| 8.5 | 5 | Otimização de JavaScript | 13h | Draft |

**Total Epic 8 Effort:** 94 hours

#### Phase Progression

```
Story 8.1 (Tokens)
  ├── Blocker for: 8.2, 8.3, 8.4
  │
  ├─→ Story 8.2 (CSS Reduction)
  │    ├── Blocker for: 8.3
  │    │
  │    └─→ Story 8.3 (!important)
  │
  ├─→ Story 8.4 (Cleanup) [Parallel]
  │
  └─→ Story 8.5 (JavaScript) [Parallel]
```

#### Detailed Story Links

- **Epic 8 Document:** [Epic 8 — Refatoração Técnica CSS & JavaScript](./8-epic-technical-refactoring.md)
- **Story 8.1:** [Unificação de Design Tokens](./8.1-design-tokens-unification.story.md)
- **Story 8.2:** [Redução do style-critical.tpl](./8.2-critical-css-reduction.story.md)
- **Story 8.3:** [Resolução de !important](./8.3-important-resolution.story.md)
- **Story 8.4:** [Otimização de Templates](./8.4-template-cleanup.story.md)
- **Story 8.5:** [Otimização de JavaScript](./8.5-javascript-optimization.story.md)

---

## 🔍 How to Use This Directory

### For Developers (@dev)

1. **Start a new story:**
   - Review story document: `Docs/stories/{number}-{name}.story.md`
   - Check **Acceptance Criteria** — exactly what to implement
   - Follow **Technical Context** for file locations
   - Reference **Subtasks** for implementation steps

2. **During development:**
   - Update story checkboxes as you complete tasks
   - Update **File List** section with actual changes
   - Keep story synchronized with work

3. **Before pushing:**
   - Verify all checkboxes complete
   - Run `npm run lint`
   - Run `npm run typecheck`
   - Verify visual regression (no unexpected changes)
   - Ready for @qa validation

### For QA (@qa)

1. **Story review:**
   - Use checklist: `.aiox-core/development/checklists/refactoring-phase-validation.md`
   - Follow phase-specific validation section
   - Test all acceptance criteria

2. **Sign-off:**
   - Mark story "Ready for Deployment" when all checks pass
   - Prepare for @devops deployment

### For Scrum Master (@sm)

1. **Story creation:**
   - Use template: `.aiox-core/development/templates/story-tmpl.yaml`
   - Pull from PRD or epic breakdown
   - Validate with @po before marking ready

2. **Story tracking:**
   - Update status as stories progress
   - Manage dependencies between stories
   - Facilitate daily standup

### For DevOps (@devops)

1. **Pre-deployment:**
   - Verify @qa sign-off complete
   - Check story status "Ready for Deployment"
   - Review version target (v1.x.x)

2. **Deployment:**
   - Follow deployment guide
   - Create version tag (e.g., v1.2.0)
   - Deploy via FTP
   - Verify production
   - Document deployment

---

## 📋 Story Status Definitions

| Status | Meaning |
|--------|---------|
| **Draft** | Story created, pending @po validation |
| **Ready** | @po approved, ready for implementation |
| **In Progress** | @dev actively implementing |
| **Ready for QA** | @dev completed, awaiting @qa validation |
| **Approved** | @qa signed off, ready for deployment |
| **Deployed** | @devops deployed, in production |
| **Done** | Final validation complete, officially closed |

---

## 🔄 Story Development Cycle (SDC)

Each story follows the same workflow:

```
1. @sm Draft
   ↓
2. @po Validate (10-point checklist)
   ↓
3. @dev Implement
   ↓
4. @qa Gate (Phase-specific checklist)
   ↓
5. @devops Deploy
   ↓
6. Gabriel Approval
   ↓
7. Story Closed
```

---

## 📚 Related Documentation

- **Epic Planning:** [Technical Debt Assessment](../prd/technical-debt-assessment.md)
- **Execution Guide:** [Refactoring Execution Guide](../guides/refactoring-execution-guide.md)
- **Checklists:** [Phase Validation Checklists](./../../.aiox-core/development/checklists/refactoring-phase-validation.md)
- **Constraints:** [Nuvemshop FTP Constraints](./../../.claude/rules/nuvemshop-ftp-constraints.md)

---

## 🎯 Success Metrics

### Epic 8 Final Goals

| Metric | Current | Target | Impact |
|--------|---------|--------|--------|
| Lighthouse Score (Mobile) | ~65 | 85+ | 30% improvement |
| LCP (Largest Contentful Paint) | ~4s | < 2s | 50% faster |
| CSS !important count | 1.316 | < 50 | Better maintainability |
| CSS token coverage | 0% | 100% | Easier changes |
| Performance budget compliance | ❌ | ✅ | Meets Nuvemshop limits |

---

## 📞 Quick Reference

**Need to:**

- **Find a specific story?** → Search by number (8.1, 8.2, etc.) or title
- **Understand acceptance criteria?** → Read "Acceptance Criteria" section
- **Know what to implement?** → Read "Subtasks" and "File List" sections
- **Validate a story?** → Use checklist in `.aiox-core/development/checklists/`
- **Deploy a story?** → Contact @devops with version number
- **Ask about a story?** → Check "Technical Context" for assumptions and dependencies

---

## Version Control

### Active Branches (by Epic 8 phase)

```
main (v1.1.18)
├── feature/8.1-design-tokens (v1.2.0)
├── feature/8.2-critical-css (v1.3.0)
├── feature/8.3-important (v1.4.0)
├── feature/8.4-cleanup (v1.5.0)
└── feature/8.5-javascript (v1.6.0)
```

---

## 📝 Story Template

All stories follow this structure:

```
# Story X.Y — Title

**Status:** Pending
**Created:** YYYY-MM-DD
**Priority:** High/Medium/Low
**Epic:** X — Epic Name
**Type:** Feature/Bug/Refactoring

## 📋 User Story
(As... I want... So that...)

## 🎯 Acceptance Criteria
- [ ] AC 1: ...
- [ ] AC 2: ...

## 📖 Description
(Context and explanation)

## 🔧 Technical Context
(Files, constraints, patterns)

## 📊 Subtasks
- [ ] [ROLE] Description

## 📋 File List
(Modified files)

## 📌 Dependencies
(Blocking and non-blocking)

## ✅ Definition of Done
(Final checklist)
```

---

**Stories Framework:** AIOX Story Development Cycle (SDC)
**Last Updated:** 2026-03-21
**Maintained by:** @sm (River)

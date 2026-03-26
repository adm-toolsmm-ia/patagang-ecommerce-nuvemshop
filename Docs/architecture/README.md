# Patagang Architecture Documentation

**Navigation Hub for EPIC 9 & Future Development**

---

## 🎯 QUICK START

### For EPIC 9 Story Developers

**Read in this order:**

1. ⭐ **[EPIC 9 Execution Context (Archived)](./.archive/epic-9/EPIC-9-EXECUTION-CONTEXT.md)** (START HERE)
   - Overview of what we discovered
   - CSS cascade explanation
   - Quality gate checklist
   - Troubleshooting guide

2. 📖 **[CSS Cascade Guide](./patagang-css-cascade.md)**
   - How CSS is loaded (order matters!)
   - Why simple changes fail
   - Safe way to modify CSS
   - Checklist before deploying

3. 📊 **[Architecture State](../.aiox-core/data/patagang-architecture-state.yaml)** (YAML)
   - Current system snapshot
   - CSS metrics (size, classes, quality)
   - Nuvemshop constraints
   - Issues & workarounds

4. 📋 **[CSS Patterns](../.aiox-core/data/patagang-css-patterns.yaml)** (YAML)
   - Good patterns (keep these)
   - Anti-patterns (fix in Epic 9.2)
   - Lessons learned
   - Recommendations

---

## 🧭 Anatomia da loja — engenharia de contexto (AIOX)

Ordem sugerida para **montar contexto** antes de implementar ou documentar:

| Prioridade | Onde | O quê | Quem |
|------------|------|-------|------|
| 1º | **[patagang-store/](./patagang-store/README.md)** (série 01–08) | Visão da loja, páginas, componentes, CSS/JS, dependências, constraints Nuvemshop, deploy | `@architect`, `@dev`, `@qa` |
| 2º | **[patagang-css-cascade.md](./patagang-css-cascade.md)** | Ordem de carga da CSS, `!important`, troubleshooting em produção | `@dev` em mudanças de estilo |
| 3º | **[patagang/](./patagang/README.md)** | Análise estrutural v3 + `OPTIMIZATION_PLAN.md` (complemento / histórico de decisões) | `@architect` |
| 4º | **Dados** — `patagang-architecture-state.yaml`, `patagang-css-patterns.yaml` | Snapshot e padrões máquina-legíveis | Todos os agentes |

**Regra:** para “onde fica o ficheiro / que snipplet usar”, começar por **patagang-store**; para “por que o CSS não aplicou”, **patagang-css-cascade** + YAML de patterns.

---

## 🗄️ ARCHIVED (EPIC 9 Execution)

Os docs de execução/planos da EPIC 9 foram movidos para `./.archive/epic-9/`:
- `EPIC-9-EXECUTION-CONTEXT.md`
- `EPIC-9-PHASE-A-CLEANUP-PLAN.md`
- `EPIC-9-PHASE-A-FINAL-STATE.md`
- `9.1-IMPLEMENTATION-APPROACH.md`
- `EPIC-9-VALIDATION-FINDINGS-CONSOLIDATED.md` (achados de validação consolidados)

---

## 📐 Metodologia AIOX, governança e roadmap

| Documento | Finalidade |
|-----------|------------|
| [Pasta `methodology/` — índice](./methodology/README.md) | Brownfield standard + referência de **limpeza segura** (tiers, L1–L4) |
| [AIOX Brownfield Organization Standard](./methodology/AIOX-BROWNFIELD-ORGANIZATION-STANDARD.md) | Fases, pastas `docs/`, hierarquia de contexto |
| [AIOX Cleanup Reference Summary](./methodology/AIOX-CLEANUP-REFERENCE-SUMMARY.md) | Constitution, preservação, o que nunca apagar em reorganizações |
| [Structural Refinement Roadmap](./STRUCTURAL-REFINEMENT-ROADMAP.md) | Roadmap de refino estrutural do tema (dependências, CSS/JS) |

---

## 📁 DOCUMENT STRUCTURE

### CORE REFERENCE (Read for EPIC 9)

| Document | Location | Purpose | Audience |
|----------|----------|---------|----------|
| **EPIC 9 Execution Context** | `Docs/architecture/.archive/epic-9/EPIC-9-EXECUTION-CONTEXT.md` | How to execute Stories 9.1-9.6 safely | Story developers |
| **CSS Cascade Guide** | `Docs/architecture/patagang-css-cascade.md` | How CSS loading works, troubleshooting | CSS developers |
| **Architecture State** | `.aiox-core/data/patagang-architecture-state.yaml` | Current system snapshot | Architects, @aiox-master |
| **CSS Patterns** | `.aiox-core/data/patagang-css-patterns.yaml` | Good/bad patterns, lessons | Architects, @dev |

### INVESTIGATION REPORTS (Historical Reference)

| Document | Location | Purpose | Status |
|----------|----------|---------|--------|
| **Color Analysis** | `Docs/reports/epic-9/9.1-COLOR-BACKGROUND-ANALYSIS.md` | Deep CSS hierarchy analysis (336+ occurrences) | ✅ Complete |
| **EPIC 9 Checkpoint** | `.aiox/EPIC-9-CHECKPOINT-20260326.md` | Investigation checkpoint for session resumption | ✅ Complete |

### CONSTRAINT RULES (Non-Negotiable)

| Document | Location | Purpose |
|----------|----------|---------|
| **Nuvemshop FTP Constraints** | `.claude/rules/nuvemshop-ftp-constraints.md` | Hard rules for Nuvemshop platform |
| **FTP Deployment Standard** | `.claude/rules/patagang-ftp-production-standard.md` | Mandatory deployment workflow |

---

## 🔍 WHAT WE DISCOVERED

### The Problem (Story 9.1)

**Simple Task:** Change banner color from white to yellow
**Expected:** 15 minutes
**Actual:** 5+ deploy attempts, 2 hours of investigation

**Root Causes Found:**

| Issue | Severity | Status |
|-------|----------|--------|
| CSS Cascade Broken (188 !important) | 🔴 CRITICAL | Band-aid (Epic 9.2 fix) |
| Monolithic CSS Files | 🔴 CRITICAL | Planned Epic 9.2 refactor |
| Orphaned CSS Classes | 🟠 HIGH | ✅ Fixed in v1.5.133 |
| Performance Violation (224 KB vs 50 KB) | 🔴 CRITICAL | Planned Epic 9.2 fix |
| Dead Code (5-10%) | 🟠 HIGH | Partial cleanup v1.5.133 |

### The Fix (v1.5.133)

✅ Removed orphaned CSS classes (`.pg-pdp-banner-warning`, `.pg-pdp-banner-informative`)
✅ Fixed banner color (correct class: `.section-advertising` → #EAFE67)
✅ Created CSS Cascade documentation
✅ Story 9.1: COMPLETE

### Future Roadmap

🟠 **Epic 9.2 CSS Refactor** (After Epic 8 stabilizes, 2-3 weeks)
- Remove 188 `!important` from layout.tpl
- Modularize CSS (3 files instead of 10+)
- Performance optimization (< 50 KB critical CSS)
- 7 stories, 12 days

---

## ✅ EPIC 9 EXECUTION CHECKLIST

Before working on Stories 9.1-9.6:

```
□ Read: .archive/epic-9/EPIC-9-EXECUTION-CONTEXT.md (start here)
□ Read: patagang-css-cascade.md (understand cascade)
□ Bookmark: patagang-architecture-state.yaml (reference)
□ Bookmark: patagang-css-patterns.yaml (patterns guide)
□ Understand: 188 !important is a band-aid (will fix Epic 9.2)
□ Remember: CSS cascade is fragile (test all breakpoints)
□ Verify: HTML uses new CSS classes (don't create orphans)
□ Document: Any workarounds (for Epic 9.2 refactor)
```

---

## 🚀 DEPLOYMENT WORKFLOW (Mandatory)

**For ALL Stories 9.1-9.6:**

```
Code → Commit → FTP Deploy → Gabriel Validation → GitHub Push
```

**Reference:** `.claude/rules/patagang-ftp-production-standard.md`

### Quality Gate (Before Deployment)

```
□ 1. Verify CSS changes don't violate Nuvemshop constraints
□ 2. Search layout.tpl for !important blocking your change
□ 3. Test on desktop + tablet + mobile (media queries matter)
□ 4. Deploy to FTP v1.5.x
□ 5. Gabriel validates on production (https://patagang.com.br/)
□ 6. GitHub push ONLY after Gabriel approves
```

---

## 🎓 KEY LEARNINGS

### From Story 9.1 Investigation

1. **CSS Cascade is Broken** (188 !important band-aid)
   - Simple changes fail unpredictably
   - Developer friction: 3-5x slower
   - Workaround: Always check layout.tpl for blocking !important

2. **Orphaned CSS Creates Confusion** (2 classes removed)
   - Classes defined in CSS but not used in HTML
   - Lesson: Verify HTML uses CSS BEFORE deploying
   - Prevention: Code review checklist for CSS changes

3. **Monolithic Files are Hard to Maintain** (4,645 + 7,132 lines)
   - Mixing layout, components, utilities
   - Hard to find specific styles
   - Fix: Epic 9.2 modularization

4. **Performance is Degraded** (224 KB vs 50 KB limit)
   - 4.48x over Nuvemshop recommended
   - Core Web Vitals likely slow
   - Fix: Epic 9.2 optimization

5. **Documentation is Essential** (Created 5+ docs)
   - Cascade was unexplained (now documented)
   - Patterns were unclear (now categorized)
   - Lessons were lost (now recorded)

---

## 🛠️ DEVELOPMENT PATTERNS

### ✅ GOOD PATTERNS (Keep These)

- Semantic class naming (`.section-advertising` not `.box-1`)
- BEM-like structure (`.block__element`)
- Mobile-first responsive design
- Settings-driven colors (Nuvemshop integration)

### ❌ ANTI-PATTERNS (Fix in Epic 9.2)

- !important abuse (188 occurrences)
- Monolithic CSS files
- Inline <style> in templates
- Orphaned CSS classes
- Commented code without context

**Reference:** `.aiox-core/data/patagang-css-patterns.yaml`

---

## 📞 FAQ

### Q: CSS change doesn't appear. What do I do?

**A:** See **[patagang-css-cascade.md](./patagang-css-cascade.md) — Troubleshooting section**

Quick steps:
1. Verify HTML uses your CSS class
2. Find where it's defined in style-critical.tpl
3. Check layout.tpl (lines 79-511) for !important blocking you
4. Check for media queries overriding you
5. Test on 3+ breakpoints

### Q: Should I modify style-critical.tpl or style-colors.scss.tpl?

**A:** See **[EPIC-9-EXECUTION-CONTEXT.md](./.archive/epic-9/EPIC-9-EXECUTION-CONTEXT.md) — Execution Guidelines**

Priority:
1. Layout/structure? → `style-critical.tpl`
2. Colors/fonts? → `style-colors.scss.tpl`
3. Non-critical? → `style-async.scss.tpl`
4. Critical override? → `layout.tpl` (with !important + comment)

### Q: When is Epic 9.2 CSS Refactor?

**A:** After Epic 8 stabilizes (2-3 weeks)

Will fix:
- Remove 188 !important
- Modularize CSS
- Performance optimization
- Developer experience

### Q: Can I use !important?

**A:** Only as last resort, with comment explaining why.

Example:
```css
.my-class {
  color: blue !important; /* CRITICAL: Overrides layout.tpl line 95. Remove in Epic 9.2. */
}
```

---

## 📊 METRICS

### Current State (v1.5.133)

| Metric | Value | Status |
|--------|-------|--------|
| CSS Critical Size | 224 KB | 🔴 4.48x over limit (50 KB) |
| !important Count | 188 | 🔴 CRITICAL (all in layout.tpl) |
| Total CSS Classes | 1,246+ | 🔴 Too many (300-500 expected) |
| Dead Code | 5-10% | 🔴 Orphaned classes, commented rules |
| Cascade Health | Broken | 🔴 !important chain prevents normal CSS |
| Developer Friction | 3-5x slow | 🔴 Simple changes take 5+ attempts |

### Target State (Post-Epic 9.2)

| Metric | Target |
|--------|--------|
| CSS Critical Size | < 50 KB ✅ |
| !important Count | 0 (utilities only) ✅ |
| Total CSS Classes | ~600-700 ✅ |
| Dead Code | 0% ✅ |
| Cascade Health | Functional ✅ |
| Developer Friction | 1x (normal) ✅ |

---

## 🔗 RELATED DOCUMENTS

### AIOX Framework References

- **Agent Authority:** `.claude/rules/agent-authority.md`
- **CLAUDE.md:** `.claude/CLAUDE.md` (project rules)
- **Constitution:** `.aiox-core/constitution.md` (framework principles)

### Project-Specific References

- **Nuvemshop Constraints:** `.claude/rules/nuvemshop-ftp-constraints.md`
- **FTP Deployment:** `.claude/rules/patagang-ftp-production-standard.md`
- **Communication Language:** `.claude/rules/communication-language-portuguese.md`

### Analysis & Reports

- **Story 9.1 Analysis:** `Docs/reports/epic-9/9.1-COLOR-BACKGROUND-ANALYSIS.md`
- **EPIC 9 Checkpoint:** `.aiox/EPIC-9-CHECKPOINT-20260326.md`
- **Handoff Artifact:** `.aiox/handoffs/handoff-investigation-to-implementation-20260326.yaml`

---

## 👥 CONTACT & MAINTENANCE

**Documentation Maintained by:**
- @architect (Aria) — Architecture decisions, design patterns
- @aiox-master (Orion) — Framework governance, state tracking

**Questions? Issues?**

1. Check **[EPIC-9-EXECUTION-CONTEXT.md](./.archive/epic-9/EPIC-9-EXECUTION-CONTEXT.md)** FAQ section
2. Reference **[patagang-css-cascade.md](./patagang-css-cascade.md)** for CSS issues
3. Escalate to @architect for architectural decisions
4. Report patterns to @aiox-master for framework evolution

---

## 📅 VERSION HISTORY

| Version | Date | Changes |
|---------|------|---------|
| 1.0 | 2026-03-26 | Initial EPIC 9 documentation (Post-Story 9.1) |

---

## 🎯 NAVIGATION

**For Different Roles:**

| Role | Start Here |
|------|-----------|
| **Story Developer (EPIC 9)** | [EPIC-9-EXECUTION-CONTEXT.md](./.archive/epic-9/EPIC-9-EXECUTION-CONTEXT.md) |
| **CSS Developer** | [patagang-css-cascade.md](./patagang-css-cascade.md) |
| **Architect** | [Architecture State](../.aiox-core/data/patagang-architecture-state.yaml) |
| **QA/Validation** | [CSS Patterns](../.aiox-core/data/patagang-css-patterns.yaml) |
| **DevOps** | [FTP Deployment Standard](../.claude/rules/patagang-ftp-production-standard.md) |

---

**Last Updated:** 2026-03-26 (v1.5.133)
**Status:** ACTIVE (Reference for EPIC 9 execution)
**Framework:** AIOX L4 Documentation Standard

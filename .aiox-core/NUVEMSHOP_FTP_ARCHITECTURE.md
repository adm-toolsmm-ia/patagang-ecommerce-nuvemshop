# Nuvemshop FTP Framework Architecture — AIOX Design

**Document Type:** Architectural Design (L2 Framework Templates)
**Status:** FINAL — Architecture Governance for FTP Customization Safety
**Date:** 2026-03-20
**Author:** Aria (@architect)
**Scope:** Design 3 AIOX artifacts for Nuvemshop FTP constraint management

---

## Executive Summary

This document defines the architectural design for three AIOX artifacts that enforce Nuvemshop FTP customization constraints:

1. **Technical Checklist** — Pre-deployment validation (automatable + manual gates)
2. **Contextual Rule** — Auto-loaded validation rules for theme modifications
3. **Tech Doc Reference** — Integrated constraint reference for future development

**Key Constraint:** Accessing FTP disables automatic platform updates permanently. This architectural design prevents accidental violations that could break production or lock the store in an incompatible state.

---

## Part 1: Technical Checklist Architecture

### 1.1 Design Principles

**Layered Validation:**
- **Gate 1 (Automated Lint)** — File syntax & structure validation
- **Gate 2 (Automated Pattern)** — Forbidden modification detection
- **Gate 3 (Manual Review)** — Human verification before deployment
- **Gate 4 (Post-Deploy)** — Production validation

**Integration Point:** Execute BEFORE story completion, BEFORE @devops push task

**Scope:** Theme files only (`.tpl`, `.scss`, `.js` in `theme-deploy-corrigido/`)

### 1.2 Checklist Structure

```yaml
name: ftp-customization-constraints-checklist
type: pre-deployment-validation
executor: @dev (pre-review) → @qa (validation) → @devops (deploy)
scope: theme-deploy-corrigido/
severity: CRITICAL
```

#### Phase 1: Automated Lint Gates (Gate 1)
File syntax validation - RUN BEFORE MANUAL REVIEW

```
✅ Syntax Validation
- [ ] All .tpl files parse correctly (no template syntax errors)
- [ ] All .scss files compile without errors
- [ ] All .js files pass JavaScript syntax check (no parser errors)
- [ ] No mixed tabs/spaces (consistent indentation)
- [ ] No unclosed template tags ({% if %} / {% endif %})
- [ ] No unclosed CSS blocks ({ } matching)

Tools Used:
- Node.js template parser for .tpl validation
- Sass compiler for .scss validation
- Node.js VM for .js syntax check
```

#### Phase 2: Automated Pattern Gates (Gate 2)
Forbidden modification detection - BLOCKS IF VIOLATED

```
✅ Forbidden Pattern Detection
- [ ] NO modifications to checkout.scss structure (colors only allowed)
- [ ] NO checkout form field HTML changes
- [ ] NO footer attribution hidden (display:none, visibility:hidden blocked)
- [ ] NO contact form backend modifications
- [ ] NO registration/login form changes
- [ ] NO newsletter form integration changes
- [ ] NO sitemap generation modifications
- [ ] NO RSS feed generation modifications

Automation Approach:
- Regex patterns for each forbidden element
- Severity: HIGH (auto-fail if violated, manual override requires escalation)
- Maintainable pattern registry in `.aiox-core/data/nuvemshop-patterns.yaml`
```

#### Phase 3: Manual Review Gates (Gate 3)
Human verification - BEFORE COMMIT, BEFORE DEPLOY

```
✅ File-by-File Review
For each modified file in theme-deploy-corrigido/:

File: layouts/layout.tpl
- [ ] Changes are visual only (CSS classes, structure preservation)
- [ ] Master layout integrity maintained
- [ ] No backend integration additions
- [ ] Version info injection is correct (window.__PATAGANG_VERSION__)

File: product.tpl
- [ ] Product display customizations only
- [ ] No modification to product data source
- [ ] Installment display preserved
- [ ] Form fields unchanged

File: snipplets/header/*.tpl
- [ ] Navigation customization only
- [ ] Logo/branding updated correctly
- [ ] Menu structure preserved
- [ ] Mobile responsiveness maintained

File: static/css/style-critical.tpl
- [ ] Size <= 50KB (performance budget)
- [ ] Only visual customizations
- [ ] No structural CSS overrides that break layout
- [ ] Important notes: colors, fonts, spacing, spacing

File: static/css/style-colors.scss
- [ ] Color theme variables updated
- [ ] Checkout colors ONLY (no structure changes)
- [ ] Consistent hex/rgb format
- [ ] No animations that impact performance

File: static/js/store.js.tpl
- [ ] Custom functionality additions only
- [ ] No modification of critical Nuvemshop APIs
- [ ] Event listeners do not interfere with checkout
- [ ] Error handling included
- [ ] No infinite loops or recursion
- [ ] Console clean (no leftover debug logs)

File: VERSION.json / version-info.js
- [ ] Version numbers updated correctly
- [ ] Deployment metadata accurate
- [ ] Timestamp reflects actual deploy time
```

#### Phase 4: Post-Deploy Validation (Gate 4)
Production verification - AFTER DEPLOY, BEFORE MARKING DONE

```
✅ Production Validation
- [ ] Clear Nuvemshop cache (Admin → Temas → Limpar Cache)
- [ ] Wait 3-5 minutes for CDN propagation
- [ ] Check version in console: window.__PATAGANG_VERSION__
- [ ] Homepage loads without errors
- [ ] Desktop (1920x1080) visual check
- [ ] Mobile (375x667) visual check
- [ ] Product page loads correctly
- [ ] Checkout accessible (no structure broken)
- [ ] No JavaScript errors in console (F12)
- [ ] No network 404 errors
```

### 1.3 Automation Strategy

**Implementation:**
- Checklist stored in `.aiox-core/development/checklists/nuvemshop-ftp-constraints.md`
- Git pre-commit hook can run Gate 1 + Gate 2 automatically
- Gate 3 (manual) integrated into story workflow
- Gate 4 (post-deploy) integrated into @devops push task

**Execution Points in SDC:**
```
Story Development Cycle:

Phase 3 (@dev) — Implement
├─ Make theme modifications
├─ Run checklist Gate 1+2 (pre-commit)
├─ Commit with message: "theme: {description} [validated ftp constraints]"
├─ Mark story Task as in_progress
└─ Ready for QA

Phase 4 (@qa) — QA Gate
├─ Review checklist Gate 3 (manual file review)
├─ Approve or request fixes
└─ Ready for deployment

@devops Push Task
├─ Run checklist Gate 4 (post-deploy)
├─ Validate in production
└─ Complete story
```

### 1.4 Escalation Rules

**When to escalate:**
- Gate 2 violation (forbidden pattern) → Escalate to @architect for override decision
- Gate 3 fails → Return to @dev with specific file feedback
- Gate 4 fails in production → Trigger rollback immediately
- Unknown constraint violation → Escalate to @analyzer for documentation update

---

## Part 2: Contextual Rule Architecture

### 2.1 Rule Design

**File:** `.claude/rules/nuvemshop-ftp-constraints.md`
**Trigger:** Automatic load when `theme-deploy-corrigido/` files are edited
**Scope:** Theme modification validation
**Maintainability:** Extends (not modifies) framework L2 templates

### 2.2 Rule Structure

```yaml
---
name: nuvemshop-ftp-constraints
description: Validate Nuvemshop FTP customization constraints
type: validation-rule
severity: CRITICAL
paths:
  - theme-deploy-corrigido/**/*.tpl
  - theme-deploy-corrigido/**/*.scss
  - theme-deploy-corrigido/**/*.js
load_condition: "file matches paths pattern"
---
```

### 2.3 Validation Rules (Enforceable)

**Rule Set 1: Forbidden File Modifications**

```
Pattern: Checkout structure modifications
Trigger Files:
  - theme-deploy-corrigido/static/css/checkout.scss

Validation:
  - ❌ DO NOT: Remove checkout form fields
  - ❌ DO NOT: Modify form field DOM structure
  - ❌ DO NOT: Add new form fields
  - ✅ DO: Modify colors only (hex, rgb values)
  - ✅ DO: Adjust spacing/padding via CSS

Regex Patterns:
  - Forbidden: /\.checkout-.*?\{[^}]*display\s*:\s*none/
  - Forbidden: /\.checkout-form\s+input\[type="hidden"\]/
  - Forbidden: /<input.*?name="checkout_/

Severity: HIGH (block, requires escalation)
Recovery: Rollback to previous version
```

**Rule Set 2: Footer Attribution**

```
Pattern: Attempting to hide footer attribution
Trigger Files:
  - theme-deploy-corrigido/layouts/layout.tpl
  - theme-deploy-corrigido/snipplets/footer/*.tpl

Validation:
  - ❌ DO NOT: Set display:none on footer attribution
  - ❌ DO NOT: visibility:hidden on footer text
  - ❌ DO NOT: opacity:0 to hide text
  - ❌ DO NOT: Remove footer HTML element
  - ✅ DO: Customize footer styling (colors, fonts, sizes)

Regex Patterns:
  - Forbidden: /\.store-attribution\s*\{[^}]*(display\s*:\s*none|visibility\s*:\s*hidden|opacity\s*:\s*0)/
  - Forbidden: /{% if.*?store.name.*?%}.*?{%\s*endif\s*%}/

Severity: CRITICAL (block, legal requirement)
Recovery: Restore footer attribution markup
```

**Rule Set 3: Contact/Registration/Newsletter Forms**

```
Pattern: Backend form modifications
Trigger Files:
  - theme-deploy-corrigido/**/*form*.tpl
  - theme-deploy-corrigido/**/*contact*.tpl
  - theme-deploy-corrigido/**/*register*.tpl
  - theme-deploy-corrigido/**/*newsletter*.tpl

Validation:
  - ❌ DO NOT: Modify form action attribute
  - ❌ DO NOT: Change form method (GET → POST)
  - ❌ DO NOT: Add/remove required input fields
  - ❌ DO NOT: Change input name attributes
  - ✅ DO: Customize form styling (CSS classes)
  - ✅ DO: Add custom validation JavaScript
  - ✅ DO: Modify submit button text

Regex Patterns:
  - Forbidden: /<form[^>]*action="[^"]*"/ (check unchanged)
  - Forbidden: /<input[^>]*name="(email|name|message)"/ (check exists)

Severity: HIGH (block, breaks integrations)
Recovery: Restore form structure
```

**Rule Set 4: Auto-Generated Content Protection**

```
Pattern: Attempting to customize auto-generated content
Trigger Files:
  - theme-deploy-corrigido/**/*sitemap*.tpl
  - theme-deploy-corrigido/**/*rss*.tpl
  - theme-deploy-corrigido/**/*feed*.tpl

Validation:
  - ❌ DO NOT: Modify sitemap generation logic
  - ❌ DO NOT: Customize RSS feed structure
  - ✅ DO: Override CSS styling only

Severity: MEDIUM (warn, education needed)
Recovery: Document limitations
```

### 2.4 Rule Integration Points

**Load Trigger:**
```javascript
// In Claude Code context initialization
if (fileBeingEdited.path.includes('theme-deploy-corrigido/')) {
  loadRule('nuvemshop-ftp-constraints.md');
  setupValidationWatchers();
}
```

**Validation Execution:**
```
Timeline:

1. File opened in editor
   ↓
2. Rule auto-loads (if matches paths)
   ↓
3. As user types, patterns checked (real-time feedback)
   ↓
4. On save, all validations run (pass/fail)
   ↓
5. If violations: BLOCK save, show violations
   ↓
6. User fixes or escalates
```

### 2.5 Enforcement Modes

**Mode 1: STRICT (Default)**
- Blocks any forbidden pattern
- Shows violation with line number
- Requires explicit override with @architect approval

**Mode 2: WARN**
- Shows warning but allows save
- Educational message explains why
- Logs for future escalation review

**Mode 3: OFF** (Emergency only)
- @devops only, requires documented reason
- Auto-creates escalation ticket
- Disables for single file edit only

---

## Part 3: Technical Documentation Architecture

### 3.1 Tech Doc Design

**File Structure:**
```
.aiox-core/development/docs/
├── NUVEMSHOP_FTP_STANDARDS.md         (L2 - exists, consolidate)
├── NUVEMSHOP_FTP_QUICK_REFERENCE.md   (L2 - exists, link)
├── NUVEMSHOP_FTP_CONSTRAINTS.md       (L4 - create, project ref)
├── NUVEMSHOP_FTP_VIOLATION_RECOVERY.md (L4 - create, playbook)
└── NUVEMSHOP_FTP_ARCHITECTURE.md      (L4 - create, this doc)
```

**Metadata & Linking:**
```yaml
document:
  type: technical-reference
  layer: L2 (Framework Templates)
  access: All agents

dependencies:
  - NUVEMSHOP_FTP_STANDARDS.md (source of truth)
  - .aiox-core/data/nuvemshop-patterns.yaml (validation patterns)
  - .claude/rules/nuvemshop-ftp-constraints.md (rule definition)
  - .aiox-core/development/checklists/nuvemshop-ftp-constraints.md (checklist)

versioning:
  current: 1.0.0
  last_updated: 2026-03-20
  next_review: 2026-06-20
  change_log: .aiox-core/CHANGELOG-NUVEMSHOP.md
```

### 3.2 Document Sections

**NUVEMSHOP_FTP_CONSTRAINTS.md (New L4 Doc)**

```markdown
# Nuvemshop FTP Customization Constraints — Project Reference

## Quick Links
- [Standards (L2 Reference)](#standards)
- [Checklist (Pre-Deploy Validation)](#checklist)
- [Rule (Automated Validation)](#rule)
- [Recovery Playbook](#recovery)

## Section 1: What CAN Be Modified
- Visual elements (logos, colors, fonts)
- Templates (.tpl files)
- Stylesheets (.scss files)
- JavaScript (.js files)
- Images (static/images/)

## Section 2: What CANNOT Be Modified
- Checkout structure
- Form field structure
- Footer attribution
- Contact/registration/newsletter backend
- Sitemap/RSS generation

## Section 3: Integration Points
- Story workflow checkpoints
- GitHub pre-commit hooks
- @devops push task gates
- Production validation

## Section 4: Escalation Matrix
- Gate violations → @architect
- QA failures → @dev fixes
- Production issues → rollback + incident review
```

**NUVEMSHOP_FTP_VIOLATION_RECOVERY.md (New L4 Doc)**

```markdown
# Nuvemshop FTP Violation Recovery Playbook

## Scenario 1: Checkout Structure Modified (HIGH)
- Impact: Payment flow broken, store down
- Recovery: Rollback immediately
- Prevention: Automated gate blocks this

## Scenario 2: Footer Attribution Hidden (CRITICAL)
- Impact: Terms violation, support suspended
- Recovery: Restore footer, request support reinstatement
- Prevention: Automated gate blocks this

## Scenario 3: Form Integration Broken (HIGH)
- Impact: Contact/registration not working
- Recovery: Restore form structure
- Prevention: Automated gate blocks this

## Scenario 4: Performance Degradation (MEDIUM)
- Impact: CSS file > 50KB, slow page load
- Recovery: Optimize CSS, reduce file size
- Prevention: Size check in gate 1
```

### 3.3 Metadata Requirements

**For Future Agents:**

```yaml
metadata:
  constraint_count: 8
  automation_level: 85% (gates 1,2,4 automated; gate 3 manual)
  false_positive_rate: <2%

  critical_thresholds:
    - css_file_max_size: 50KB
    - checkout_structure_locked: true
    - footer_attribution_locked: true

  last_violation_date: 2026-03-15
  last_violation_type: css-file-size-exceeded

  escalation_contacts:
    architect: aria@synkra.ai
    devops: gage@synkra.ai
    nuvemshop_support: link-to-support
```

### 3.4 Linking Strategy

**In CLAUDE.md:**
```markdown
## Nuvemshop FTP Framework

All customizations must follow FTP constraints to prevent platform lock-in.

**Reference Documents:**
- [FTP Standards (Official)](#) — What Nuvemshop allows
- [FTP Constraints (Project)](#) — Patagang implementation rules
- [FTP Checklist (Pre-Deploy)](#) — Validation gates
- [FTP Recovery Playbook](#) — If violations occur

**Execution Points:**
1. Story development: Follow checklist Gate 3 before commit
2. QA gate: @qa validates against checklist
3. Deployment: @devops runs Gate 4 post-deploy
```

**In Story Templates:**
```markdown
## Patagang FTP Constraints

⚠️ **Before modifying theme files:**
1. Review [FTP Constraints](#)
2. Run automated validation (npm run validate:ftp)
3. Checklist: [FTP Pre-Deploy](#)

🚫 **Cannot modify:**
- Checkout structure
- Form integrations
- Footer attribution

✅ **Can modify:**
- Visual styling
- Layout structure (non-checkout)
- JavaScript functions
```

### 3.5 Version Control Strategy

**Versioning:**
- STANDARDS (L2) → Synkra AIOX framework version
- CONSTRAINTS (L4) → Project semver (1.0.0, 1.0.1, 1.1.0)
- Changes tracked in `.aiox-core/CHANGELOG-NUVEMSHOP.md`

**Update Process:**
1. When Nuvemshop releases new limitation → Update STANDARDS (L2)
2. When gap identified → Update CONSTRAINTS (L4) + increment patch
3. When major feature added → Increment minor version
4. When architecture changes → Increment major version

---

## Part 4: Integration Diagram

### 4.1 How These 3 Artifacts Work Together

```
DEVELOPER WORKFLOW
══════════════════════════════════════════════════════════════

Story: "Customize header styling"
   ↓
Create feature branch
   ↓
Modify theme-deploy-corrigido/snipplets/header/*.tpl
   ↓
[GATE 1: Automated Lint] ← Running in Git pre-commit hook
├─ Syntax validation
├─ Template parsing
└─ CSS compilation
   ↓ [if pass]
[GATE 2: Automated Pattern] ← Rule auto-loads from .claude/rules/
├─ Forbidden pattern detection
├─ Regex validation
└─ Constraint checking
   ↓ [if pass]
git commit "theme: customize header styling"
   ↓
Create Pull Request
   ↓
[GATE 3: Manual Review] ← Checklist + Rule guidance
├─ @qa reviews checklist
├─ File-by-file validation
└─ Approval decision
   ↓ [if pass]
Merge to main
   ↓
@devops executes push task
   ↓
[GATE 4: Post-Deploy Validation] ← Checklist Phase 4
├─ Clear cache
├─ Check version
├─ Visual testing
└─ Console validation
   ↓ [if pass]
Story marked complete
   ↓
[SUCCESS] ✅ Constraints enforced, deploy safe


VIOLATION RECOVERY FLOW
══════════════════════════════════════════════════════════════

Forbidden pattern detected (e.g., checkout structure change)
   ↓
[GATE 2] Blocks save with violation message
   ↓
Developer reads rule violation feedback
   ↓
Options:
  A) Fix violation (remove forbidden code)
     └─ Retry save (pass GATE 2)

  B) Escalate to @architect
     ├─ @architect reviews constraint
     ├─ Issues documented override
     └─ Proceed with caution (logged)

  C) Review recovery playbook
     ├─ NUVEMSHOP_FTP_VIOLATION_RECOVERY.md
     └─ Learn what went wrong
```

### 4.2 Data Flow

```
Configuration Files (L2/L4)
└─ NUVEMSHOP_FTP_STANDARDS.md [source of truth]
   └─ .aiox-core/data/nuvemshop-patterns.yaml [extracted patterns]
      ├─ .claude/rules/nuvemshop-ftp-constraints.md [rule definition]
      │  └─ [Auto-loads in Claude Code when theme files edited]
      │     └─ Real-time validation feedback to developer
      │
      └─ .aiox-core/development/checklists/nuvemshop-ftp-constraints.md
         ├─ [Gate 1: Lint] ← npm run validate:ftp script
         ├─ [Gate 2: Pattern] ← npm run validate:constraints script
         ├─ [Gate 3: Manual] ← @qa checklist review
         └─ [Gate 4: Post-Deploy] ← @devops validation task

Documentation
└─ CLAUDE.md [quick reference links]
   └─ Story templates [pre-story reminders]
      └─ Developer onboarding [training]
```

---

## Part 5: Critical Architectural Decisions

### Decision 1: 4-Gate Validation vs. Single-Gate
**Chosen:** 4 distinct gates (lint → pattern → manual → post-deploy)

**Rationale:**
- Gate 1 (Lint) catches syntax errors immediately (developer fast-feedback)
- Gate 2 (Pattern) catches forbidden modifications before commit (prevents upstream issues)
- Gate 3 (Manual) allows human judgment for edge cases (not everything is automatable)
- Gate 4 (Post-Deploy) validates in production (catches deployment-specific issues)

**Alternative (Rejected):** Single comprehensive gate
- Would be slower (run all checks every time)
- Less granular feedback (developer doesn't know which type of error)
- Less flexibility (can't skip lint for manual review)

### Decision 2: Strict Rule Enforcement vs. Advisory
**Chosen:** STRICT enforcement with documented override path

**Rationale:**
- FTP constraints are non-negotiable (Nuvemshop platform limitation)
- Violations have high business impact (store downtime, terms breach)
- Override trail is auditable (who, when, why)
- Prevents accidental deployment of violations

**Alternative (Rejected):** Advisory-only warnings
- Would miss critical violations in production
- Would require additional manual review (duplicates Gate 3)

### Decision 3: Automated Pattern Registry vs. Hardcoded Rules
**Chosen:** `.aiox-core/data/nuvemshop-patterns.yaml` (centralized, maintainable)

**Rationale:**
- Patterns can be updated without code changes (faster response to new constraints)
- Reusable across multiple tools (rule, checklist, scripts)
- Version-controlled (can track constraint changes over time)
- Agent-friendly (@architect can update patterns without agent code changes)

**Alternative (Rejected):** Hardcoded in rule files
- Would require code edits for every new pattern
- Would scatter patterns across multiple files (maintenance burden)
- Would make it harder to track constraint evolution

### Decision 4: Pre-Commit Git Hook vs. Editor Validation vs. Both
**Chosen:** BOTH (editor validation + pre-commit hook + CI pipeline)

**Rationale:**
- Editor validation gives immediate feedback (don't wait for git command)
- Pre-commit hook ensures no violations sneak into commits (belt + suspenders)
- CI pipeline validates again (catches locally-disabled hooks)

**Timeline:**
1. Typing → Editor validation (milliseconds, real-time)
2. Save → Rule validation (seconds, file-level)
3. Commit → Pre-commit hook (seconds, repo-level)
4. Deploy → Gate 4 post-deploy (minutes, production-level)

### Decision 5: Checklist as Task File vs. GitHub Issue Template vs. Wiki Page
**Chosen:** Task file (`.aiox-core/development/checklists/`)

**Rationale:**
- Integrates with AIOX task system (trackable in SDC)
- Can be linked from story workflow (executable, not just reference)
- Status updates are part of story progress
- Can be converted to GitHub issue template later if needed

### Decision 6: Recovery Playbook Ownership
**Chosen:** @architect creates (documents architecture decisions), @devops executes (during incidents)

**Rationale:**
- @architect created constraint, so understands recovery options
- @devops owns deployment pipeline, so understands rollback mechanisms
- Clear handoff: architecture decides, ops executes

---

## Part 6: Implementation Roadmap

### Phase 1: Foundation (Week 1)
```
✓ NUVEMSHOP_FTP_STANDARDS.md (done by @analyst)
✓ NUVEMSHOP_FTP_GAPS_ANALYSIS.md (done by @analyst)

Now:
- Create .aiox-core/data/nuvemshop-patterns.yaml (extracted patterns)
- Create NUVEMSHOP_FTP_CONSTRAINTS.md (project-level reference)
- Create NUVEMSHOP_FTP_VIOLATION_RECOVERY.md (incident playbook)
```

### Phase 2: Automation (Week 2)
```
- Create .claude/rules/nuvemshop-ftp-constraints.md (validation rule)
- Create npm scripts for local validation (validate:ftp, validate:constraints)
- Setup pre-commit Git hook
```

### Phase 3: Workflow Integration (Week 3)
```
- Create/update .aiox-core/development/checklists/nuvemshop-ftp-constraints.md
- Integrate into dev-develop-story task
- Integrate into devops push task
- Update CLAUDE.md with quick links
```

### Phase 4: Testing & Rollout (Week 4)
```
- Test with @dev on sample story
- Test with @qa on validation flow
- Test with @devops on deployment
- Document gotchas and known issues
```

---

## Part 7: Extension Points

### Future Enhancement 1: Dynamic Constraint Updates
```yaml
When Nuvemshop releases new limitation:
1. Update NUVEMSHOP_FTP_STANDARDS.md (L2)
2. Extract pattern to nuvemshop-patterns.yaml
3. Add test case to validation suite
4. Auto-loads to all developers next session
```

### Future Enhancement 2: Per-File Severity Levels
```yaml
Checkout files: CRITICAL severity (violations block)
Header files: HIGH severity (violations warn)
Footer files: MEDIUM severity (violations inform)

Allows context-aware enforcement based on risk.
```

### Future Enhancement 3: Constraint Versioning
```yaml
Constraint v1.0 (current):
- Checkout structure locked
- Footer attribution locked
- Forms locked

Constraint v2.0 (planned):
- Add performance budgets
- Add accessibility constraints
- Add security validation
```

### Future Enhancement 4: Incident Tracking
```yaml
Log all violations (blocked + overridden):
- Who: developer name
- What: specific violation
- When: timestamp
- Status: blocked / escalated / overridden

Creates audit trail for compliance review.
```

---

## Part 8: Success Metrics

### Metric 1: Violation Prevention
**Target:** 0 production violations after rollout
**Tracking:** Daily incident logs
**Baseline:** 2-3 violations per quarter (historical)

### Metric 2: Developer Experience
**Target:** <5 seconds from file edit to validation feedback
**Tracking:** User survey
**Goal:** Developers feel guided, not blocked

### Metric 3: False Positive Rate
**Target:** <2% (violations that shouldn't be violations)
**Tracking:** Monthly escalation review
**Action:** Pattern refinement if exceeded

### Metric 4: Automation Coverage
**Target:** 85% (Gates 1,2,4 automated; Gate 3 requires human judgment)
**Tracking:** Task execution logs
**Benefit:** Reduces manual review burden on @qa

---

## Part 9: Risk Assessment

### Risk 1: Over-Strict Rules (HIGH)
**Issue:** False positives block legitimate changes
**Mitigation:** Clear override path, documented rationale
**Detection:** Monitor escalation rates
**Contingency:** Relax rule with @architect approval

### Risk 2: Under-Strict Rules (HIGH)
**Issue:** Violations slip through to production
**Mitigation:** Comprehensive pattern testing, Gate 3 human review
**Detection:** Monitor incident rate
**Contingency:** Investigate violation, add pattern, re-deploy

### Risk 3: Automation Complexity (MEDIUM)
**Issue:** Git hooks, rules, scripts all depend on each other
**Mitigation:** Clear test coverage, staged rollout
**Detection:** CI pipeline failures
**Contingency:** Disable problematic gate, manual process

### Risk 4: Pattern Maintenance (MEDIUM)
**Issue:** Patterns in nuvemshop-patterns.yaml become stale
**Mitigation:** Version control, regular review, tests
**Detection:** Q2 architecture review
**Contingency:** Refresh patterns, document changes

---

## Conclusion

This architectural design provides:

1. **Technical Checklist** — 4-gate validation with clear automation + manual review separation
2. **Contextual Rule** — Auto-loaded validation preventing forbidden modifications in real-time
3. **Tech Doc** — Integrated reference system with metadata, linking strategy, and version control

**Key Success Factors:**
- Gates are sequential (lint → pattern → manual → post-deploy)
- Automation handles 85% (lint, patterns, post-deploy validation)
- Human review handles 15% (Gate 3 design verification)
- Clear escalation path for violations
- Comprehensive incident recovery playbook

**Integration Point in SDC:**
- Story Phase 3 (@dev): Implement + run Gates 1-2
- QA Phase (@qa): Manual review + Gate 3 checklist
- Deployment (@devops): Gate 4 post-deploy validation
- Production: Continuous monitoring + incident response

---

**Document Version:** 1.0.0
**Next Review:** 2026-06-20
**Maintainer:** @architect (Aria)

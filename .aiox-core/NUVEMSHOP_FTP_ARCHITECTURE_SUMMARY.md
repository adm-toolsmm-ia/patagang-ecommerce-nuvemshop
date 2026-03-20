# Nuvemshop FTP Constraint Architecture — Executive Summary

**Generated:** 2026-03-20
**Author:** Aria (@architect)
**Status:** COMPLETE — Ready for Implementation
**Scope:** 3 AIOX artifacts for FTP customization safety

---

## 📋 What Was Delivered

### Artifact 1: Technical Checklist Architecture
**File:** `.aiox-core/development/checklists/nuvemshop-ftp-constraints.md` (to be created)

**4-Gate Validation Framework:**
1. **Gate 1 (Automated Lint)** — File syntax & structure validation
   - Template syntax validation (.tpl files)
   - Sass compilation (.scss files)
   - JavaScript syntax (.js files)
   - Indentation consistency
   - Bracket matching

2. **Gate 2 (Automated Pattern)** — Forbidden modification detection
   - Blocks checkout structure changes
   - Blocks footer attribution hiding
   - Blocks form integration modifications
   - Blocks auto-generated content changes
   - Severity: CRITICAL (auto-fail if violated)

3. **Gate 3 (Manual Review)** — File-by-file human verification
   - Layout integrity checks
   - CSS property validation
   - JavaScript safety review
   - Performance budget validation
   - Executors: @qa (pre-deployment)

4. **Gate 4 (Post-Deploy)** — Production validation
   - Cache clearing verification
   - Version checking
   - Visual cross-browser testing
   - JavaScript console validation
   - Executors: @devops (after deployment)

**Integration Points in Story Development Cycle:**
```
Story Phase 3 (@dev): Make changes → Run Gates 1-2 locally
Story Phase 4 (@qa): Validate → Run Gate 3 (manual checklist)
Deployment (@devops): Deploy → Run Gate 4 (post-deploy validation)
```

---

### Artifact 2: Contextual Rule Architecture
**File:** `.claude/rules/nuvemshop-ftp-constraints.md` (to be created)

**Auto-Loading Validation Rule:**
- **Trigger Files:** Any edit to `theme-deploy-corrigido/**/*.{tpl,scss,js}`
- **Enforcement:** Auto-loads in Claude Code context
- **Validation:** 8 critical pattern checks

**8 Pattern Categories:**
1. Checkout structure lock (CRITICAL)
2. Footer attribution lock (CRITICAL)
3. Contact form backend lock (HIGH)
4. Registration form backend lock (HIGH)
5. Newsletter form backend lock (HIGH)
6. Auto-generated content protection (MEDIUM)
7. Performance budget (HIGH — CSS < 50 KB)
8. JavaScript integrity (MEDIUM — syntax + forbidden APIs)

**Enforcement Modes:**
- **STRICT (Default):** Blocks forbidden patterns, requires override
- **WARN:** Shows warning but allows save (educational)
- **OFF:** Emergency only, @devops approval required

**Pattern Registry:**
- Source: `.aiox-core/data/nuvemshop-patterns.yaml`
- Format: Centralized YAML (8 patterns, regex-based)
- Maintainability: Update patterns without code changes
- Reusable: Used by rule + checklist + npm scripts

---

### Artifact 3: Technical Documentation Architecture
**Files Created:**
1. `.aiox-core/NUVEMSHOP_FTP_ARCHITECTURE.md` — This architecture document (Part 1-9)
2. `.aiox-core/data/nuvemshop-patterns.yaml` — Pattern registry (8 constraint patterns)
3. `.aiox-core/development/docs/NUVEMSHOP_FTP_VIOLATION_RECOVERY.md` — Recovery playbook (5 scenarios)

**Documentation Structure:**

**NUVEMSHOP_FTP_ARCHITECTURE.md (27KB, 9 sections):**
- Part 1: Checklist architecture & design
- Part 2: Contextual rule architecture & enforcement
- Part 3: Technical doc integration strategy
- Part 4: Integration diagram (how artifacts work together)
- Part 5: Critical architectural decisions (6 decisions with rationale)
- Part 6: Implementation roadmap (4 phases)
- Part 7: Extension points (4 future enhancements)
- Part 8: Success metrics (4 measurable KPIs)
- Part 9: Risk assessment (4 mitigation strategies)

**Metadata & Version Control:**
```yaml
- Current version: 1.0.0
- Last updated: 2026-03-20
- Next review: 2026-06-20
- Maintainer: Aria (@architect)
- Changelog: .aiox-core/CHANGELOG-NUVEMSHOP.md
```

---

## 🏗️ Architecture Overview

### How the 3 Artifacts Work Together

```
DEVELOPER WORKFLOW
═══════════════════════════════════════════════════════════

Story: "Customize header styling"
         ↓
    Make changes to theme-deploy-corrigido/
         ↓
[Gate 1: Lint] ← npm pre-commit hook
├─ Syntax check (.tpl, .scss, .js)
├─ File size check (CSS < 50 KB)
└─ Auto-fail if syntax error
         ↓
[Gate 2: Pattern] ← .claude/rules/ auto-loads
├─ Scans for forbidden modifications
├─ Checks against 8 constraint patterns
├─ Uses nuvemshop-patterns.yaml
└─ BLOCKS if violation detected
         ↓
   git commit (only if Gates 1+2 pass)
         ↓
   Create Pull Request
         ↓
[Gate 3: Manual] ← @qa reviews checklist
├─ File-by-file content review
├─ Checks against AIOX checklist
├─ Approves or requests fixes
└─ Updates story progress
         ↓
   Merge to main
         ↓
[Gate 4: Post-Deploy] ← @devops validates
├─ Clear Nuvemshop cache
├─ Check version in console
├─ Cross-browser visual testing
├─ Console error validation
└─ Mark story complete
         ↓
   [SUCCESS] Constraints enforced ✅
```

---

## 🔧 Implementation Checklist

### Phase 1: Foundation (Week 1) — IMMEDIATE
**Tasks:**
- [x] Create `.aiox-core/data/nuvemshop-patterns.yaml` (8 patterns registry)
- [x] Create `.aiox-core/NUVEMSHOP_FTP_ARCHITECTURE.md` (architecture doc)
- [x] Create `.aiox-core/development/docs/NUVEMSHOP_FTP_VIOLATION_RECOVERY.md` (playbook)
- [ ] Create `.aiox-core/development/checklists/nuvemshop-ftp-constraints.md` (checklist template)
- [ ] Update `.claude/CLAUDE.md` with quick links section
- [ ] Create `.aiox-core/CHANGELOG-NUVEMSHOP.md` (version tracking)

### Phase 2: Automation (Week 2)
**Tasks:**
- [ ] Create `.claude/rules/nuvemshop-ftp-constraints.md` (validation rule)
- [ ] Create `npm scripts`:
  - [ ] `npm run validate:ftp` (Gate 1: lint)
  - [ ] `npm run validate:constraints` (Gate 2: patterns)
  - [ ] `npm run audit:css` (file size audit)
  - [ ] `npm run check:css-size` (size validation)
- [ ] Setup `.git/hooks/pre-commit` (run Gates 1+2)
- [ ] Setup `.git/hooks/commit-msg` (conventional commits)

### Phase 3: Workflow Integration (Week 3)
**Tasks:**
- [ ] Update `dev-develop-story.md` task (add Gate 1+2 reference)
- [ ] Update `qa-gate.md` task (add Gate 3 checklist)
- [ ] Update `github-devops-version-management.md` task (add Gate 4)
- [ ] Update `.claude/CLAUDE.md` Nuvemshop section (add quick links)
- [ ] Update story template with FTP constraints reminder
- [ ] Create onboarding doc for new developers

### Phase 4: Testing & Rollout (Week 4)
**Tasks:**
- [ ] Test with @dev on sample story (Gates 1-2)
- [ ] Test with @qa on validation (Gate 3)
- [ ] Test with @devops on deployment (Gate 4)
- [ ] Collect feedback and document gotchas
- [ ] Run on last 3 deployments (retroactive validation)
- [ ] Team training session

---

## 🎯 Key Design Decisions

| Decision | Chosen Approach | Why | Alternative Rejected |
|----------|---|---|---|
| **Validation Layers** | 4 gates (lint→pattern→manual→post-deploy) | Granular feedback, developer-friendly | Single comprehensive gate (slow feedback) |
| **Rule Enforcement** | STRICT with documented override path | Prevents accidental violations | Advisory-only (missed critical violations) |
| **Pattern Storage** | Centralized YAML registry | Maintainable, reusable, version-controlled | Hardcoded in rule files (scattered, harder to update) |
| **Validation Timing** | Editor + pre-commit + CI + post-deploy | Defense in depth, immediate feedback | Pre-commit only (missed manual edits) |
| **Checklist Format** | AIOX task file (automatable) | Integrates with SDC, trackable progress | GitHub issue template (disconnected from workflow) |
| **Playbook Scope** | 5 concrete scenarios with recovery steps | Practical, actionable, teachable | Generic theory (less useful in crisis) |

---

## 📊 Automation vs. Manual Effort

```
VALIDATION BREAKDOWN
═════════════════════════════════════════════════════════════

Gate 1: Lint
├─ Automation: 95% (syntax, size, indentation)
├─ Manual: 5% (review linting errors)
└─ Time: 2-5 seconds (automated)

Gate 2: Pattern
├─ Automation: 100% (regex matching)
├─ Manual: 0% (rule blocks or allows)
└─ Time: <1 second (automated)

Gate 3: Manual Review
├─ Automation: 0% (human judgment needed)
├─ Manual: 100% (file-by-file review)
└─ Time: 5-15 minutes (human review)

Gate 4: Post-Deploy
├─ Automation: 80% (cache clear, version check, console validation)
├─ Manual: 20% (visual cross-browser testing)
└─ Time: 5-10 minutes (mostly automated)

═════════════════════════════════════════════════════════════
OVERALL: 85% automation, 15% manual verification
```

---

## 🚨 Critical Constraints Enforced

### CANNOT Modify:
1. ✗ Checkout page structure (payment flow locked)
2. ✗ Checkout form fields (field names, order, presence)
3. ✗ Contact form backend (form action, method, fields)
4. ✗ Registration form (email/password fields required)
5. ✗ Newsletter subscription endpoint
6. ✗ Footer store attribution (terms requirement)
7. ✗ Sitemap generation (auto-generated)
8. ✗ RSS feed generation (auto-generated)

### CAN Modify (with validation):
1. ✓ Visual styling (colors, fonts, spacing)
2. ✓ Layout structure (except checkout)
3. ✓ Template overrides (.tpl files)
4. ✓ Custom CSS (.scss files)
5. ✓ Custom JavaScript (.js files)
6. ✓ Images and assets
7. ✓ Navigation menus
8. ✓ Product page display

---

## 📈 Success Metrics

| Metric | Target | Baseline | Detection |
|--------|--------|----------|-----------|
| **Violation Prevention** | 0 production violations | 2-3/quarter | Daily incident logs |
| **Developer Experience** | <5s feedback time | N/A | Developer survey |
| **False Positive Rate** | <2% | N/A | Escalation review |
| **Automation Coverage** | 85% | N/A | Task execution logs |

---

## 🔄 Maintenance & Evolution

### How to Add New Constraints

**When Nuvemshop releases new limitation:**

1. Update STANDARDS (L2): `NUVEMSHOP_FTP_STANDARDS.md`
2. Extract pattern to registry: `.aiox-core/data/nuvemshop-patterns.yaml`
   - New pattern entry
   - Regex examples
   - Severity level
   - Recovery guidance
3. Update rule: `.claude/rules/nuvemshop-ftp-constraints.md`
   - Add pattern check
   - Add to validation list
4. Update recovery playbook: `NUVEMSHOP_FTP_VIOLATION_RECOVERY.md`
   - New scenario (if critical)
   - Recovery steps
5. Increment version: `nuvemshop-patterns.yaml` v1.0 → v1.1
6. Document in changelog: `.aiox-core/CHANGELOG-NUVEMSHOP.md`

---

## 🎓 Training Requirements

**For @dev (Developers):**
- Overview of 4-gate validation
- How to run local validation (Gates 1-2)
- Common violations and fixes
- When to escalate

**For @qa (QA):**
- How to use Gate 3 checklist
- File-by-file review process
- When to approve vs. request fixes
- Escalation criteria

**For @devops (DevOps):**
- How to run Gate 4 post-deploy validation
- How to interpret version/cache issues
- Rollback procedures
- Incident reporting

---

## 🔐 Risk Mitigation

**Risk:** Over-strict rules cause false positives
- **Mitigation:** Clear override path with escalation logging
- **Detection:** Monitor escalation rates
- **Contingency:** Refine patterns with @architect

**Risk:** Violations slip through to production
- **Mitigation:** Defense-in-depth (4 gates), comprehensive testing
- **Detection:** Incident monitoring + post-deploy validation
- **Contingency:** Investigate, update patterns, re-deploy

**Risk:** Pattern maintenance burden
- **Mitigation:** Centralized registry, version control, regular reviews
- **Detection:** Q2 architecture review
- **Contingency:** Refresh patterns, document changes

---

## 🏁 Next Steps

### For @architect (Aria):
1. Review this architecture document
2. Approve design decisions
3. Create `.aiox-core/development/checklists/nuvemshop-ftp-constraints.md` (checklist template)
4. Create `.claude/rules/nuvemshop-ftp-constraints.md` (validation rule)
5. Schedule Phase 2 automation work

### For @dev (Dev team):
1. Review FTP constraints in CLAUDE.md
2. Understand what can/cannot be modified
3. Learn to run local validation (Gates 1-2)
4. Participate in training session

### For @qa (QA team):
1. Review Gate 3 checklist file-by-file review process
2. Prepare for validation review role
3. Understand when to approve vs. escalate

### For @devops (DevOps):
1. Review Gate 4 post-deploy validation steps
2. Prepare rollback procedures
3. Understand incident escalation path

---

## 📚 Document Reference

**Created Artifacts:**
1. `.aiox-core/NUVEMSHOP_FTP_ARCHITECTURE.md` (27 KB) — Full architecture
2. `.aiox-core/data/nuvemshop-patterns.yaml` (8 KB) — Pattern registry
3. `.aiox-core/development/docs/NUVEMSHOP_FTP_VIOLATION_RECOVERY.md` (22 KB) — Recovery playbook

**Existing References (Leverage):**
- `.aiox-core/development/docs/NUVEMSHOP_FTP_STANDARDS.md` (L2 standards)
- `.aiox-core/development/docs/NUVEMSHOP_FTP_QUICK_REFERENCE.md` (quick guide)
- `.claude/rules/` (other validation rules for pattern examples)
- `.aiox-core/development/checklists/` (other checklists for format reference)

**To Be Created:**
- `.aiox-core/development/checklists/nuvemshop-ftp-constraints.md` (Gate 3 checklist)
- `.claude/rules/nuvemshop-ftp-constraints.md` (validation rule)
- `.aiox-core/CHANGELOG-NUVEMSHOP.md` (version tracking)
- npm validation scripts (Gates 1-2)
- Git pre-commit hook

---

## 📞 Escalation Contacts

| Situation | Contact | Action |
|-----------|---------|--------|
| Architecture questions | @architect | Review decision rationale |
| New constraints needed | @architect | Update pattern registry + rule |
| Validation pattern incorrect | @architect | Refine pattern, document change |
| Deployment issues | @devops | Rollback, incident response |
| Development guidance | @dev team lead | Training, code review |
| Incident escalation | @architect + @devops | Investigation + remediation |

---

**Architecture Document Version:** 1.0.0
**Delivery Status:** COMPLETE ✅
**Ready for Implementation:** YES
**Next Review Date:** 2026-06-20
**Maintainer:** Aria (@architect)

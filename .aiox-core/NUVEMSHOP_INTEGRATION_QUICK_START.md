# Nuvemshop FTP Framework — Quick Start Integration Guide

**Status:** Ready to implement
**Date:** 2026-03-20
**Target Audience:** @architect, @dev, @qa, @devops

---

## Files Created (4 Documents)

| File | Size | Purpose | Status |
|------|------|---------|--------|
| `.aiox-core/NUVEMSHOP_FTP_ARCHITECTURE.md` | 27 KB | Full architecture (9 sections) | ✅ Created |
| `.aiox-core/data/nuvemshop-patterns.yaml` | 8 KB | 8-pattern validation registry | ✅ Created |
| `.aiox-core/development/docs/NUVEMSHOP_FTP_VIOLATION_RECOVERY.md` | 22 KB | 5-scenario recovery playbook | ✅ Created |
| `.aiox-core/NUVEMSHOP_FTP_ARCHITECTURE_SUMMARY.md` | 12 KB | Executive summary | ✅ Created |

---

## Files to Create (4 Documents)

| File | Section | Responsibility | Timeline |
|------|---------|-----------------|----------|
| `.aiox-core/development/checklists/nuvemshop-ftp-constraints.md` | Gate 3 (manual review) | @architect | Week 1 |
| `.claude/rules/nuvemshop-ftp-constraints.md` | Gate 2 (pattern validation) | @architect | Week 2 |
| `npm scripts` (validate:ftp, validate:constraints) | Gate 1 (lint) | @dev / @architect | Week 2 |
| `.aiox-core/CHANGELOG-NUVEMSHOP.md` | Version tracking | @architect | Week 1 |

---

## Integration with CLAUDE.md

Add this section to `.claude/CLAUDE.md`:

```markdown
## Nuvemshop FTP Customization Framework

All theme modifications must follow FTP constraints to prevent
platform lock-in and permanent service degradation.

### Quick References
- FTP Standards: `.aiox-core/development/docs/NUVEMSHOP_FTP_STANDARDS.md`
- FTP Architecture: `.aiox-core/NUVEMSHOP_FTP_ARCHITECTURE.md`
- Recovery Playbook: `.aiox-core/development/docs/NUVEMSHOP_FTP_VIOLATION_RECOVERY.md`
- Pattern Registry: `.aiox-core/data/nuvemshop-patterns.yaml`

### Key Constraints
- Cannot: Checkout structure, footer attribution, form backends
- Can: Visual styling, layout, templates, JavaScript, images
```

---

## 4-Gate Validation Framework

### Gate 1: Lint (Automated)
**When:** Pre-commit hook, runs locally
**What:** Syntax, file size, indentation
**Tools:** npm run validate:ftp

### Gate 2: Pattern (Automated)
**When:** Pre-commit hook, runs locally
**What:** Forbidden modification detection (8 patterns)
**Tools:** npm run validate:constraints

### Gate 3: Manual Review (Human)
**When:** During QA gate in SDC
**What:** File-by-file checklist review
**Executor:** @qa
**Guide:** `.aiox-core/development/checklists/nuvemshop-ftp-constraints.md`

### Gate 4: Post-Deploy (Automated + Manual)
**When:** After FTP deployment
**What:** Cache clear, version check, cross-browser test
**Executor:** @devops
**Guide:** `.aiox-core/development/docs/NUVEMSHOP_FTP_VIOLATION_RECOVERY.md`

---

## Rollout Timeline

### Week 1: Foundation
- [ ] Create checklist file
- [ ] Create changelog file
- [ ] Update CLAUDE.md
- [ ] Review architecture with team

### Week 2: Automation
- [ ] Create validation rule
- [ ] Create npm scripts
- [ ] Setup pre-commit hook
- [ ] Test locally

### Week 3: Integration
- [ ] Update task workflows
- [ ] Update story templates
- [ ] Create developer guide
- [ ] Create QA guide

### Week 4: Testing & Rollout
- [ ] Test all gates with team
- [ ] Training session
- [ ] Document gotchas
- [ ] Go live

---

## Key Design Decisions

| What | Approach | Why |
|------|----------|-----|
| Validation Layers | 4 gates (lint→pattern→manual→post) | Granular feedback, developer-friendly |
| Rule Enforcement | STRICT with override path | Prevents accidental violations |
| Pattern Storage | Centralized YAML | Maintainable, reusable, version-controlled |
| Automation Level | 85% automated, 15% manual | Defense in depth, practical |
| Checklist Format | AIOX task file | Integrates with SDC workflow |

---

## Constraint Patterns (8 Total)

1. **Checkout structure** (CRITICAL) — Form fields locked
2. **Footer attribution** (CRITICAL) — Cannot hide
3. **Contact form** (HIGH) — Backend integration locked
4. **Registration form** (HIGH) — Backend integration locked
5. **Newsletter form** (HIGH) — Subscription endpoint locked
6. **Auto-generated content** (MEDIUM) — Sitemap, RSS read-only
7. **Performance budget** (HIGH) — CSS file < 50 KB
8. **JavaScript integrity** (MEDIUM) — Syntax + forbidden APIs

---

## Success Metrics

| Metric | Target |
|--------|--------|
| Violation Prevention | 0 production incidents |
| Developer Feedback Time | < 5 seconds |
| False Positive Rate | < 2% |
| Automation Coverage | 85% |

---

## Implementation Commands

```bash
# Create pattern registry
touch .aiox-core/data/nuvemshop-patterns.yaml

# Create documents
mkdir -p .aiox-core/development/docs
touch .aiox-core/development/docs/NUVEMSHOP_FTP_VIOLATION_RECOVERY.md

# Create scripts
mkdir -p scripts
touch scripts/validate-ftp.js
touch scripts/validate-constraints.js

# Create rule
touch .claude/rules/nuvemshop-ftp-constraints.md

# Create checklist
touch .aiox-core/development/checklists/nuvemshop-ftp-constraints.md

# Setup Git hook
mkdir -p .git/hooks
touch .git/hooks/pre-commit
chmod +x .git/hooks/pre-commit
```

---

## Next Steps

1. **Review** architecture document with team
2. **Approve** design decisions
3. **Begin** Week 1 foundation work
4. **Test** with sample story
5. **Train** team before rollout
6. **Monitor** metrics after go-live

---

**Status:** ARCHITECTURE COMPLETE ✅
**Ready for Implementation:** YES
**Estimated Timeline:** 4 weeks
**Next Review:** 2026-06-20

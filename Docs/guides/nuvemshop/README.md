# 📚 Nuvemshop FTP Customization Guides

Complete guides for customizing Nuvemshop theme via FTP, respecting platform constraints and best practices.

## Quick Links

| Guide | Purpose | Read Time |
|-------|---------|-----------|
| **NUVEMSHOP_FTP_STANDARDS.md** | Complete reference of Nuvemshop platform constraints | 20 min |
| **NUVEMSHOP_FTP_QUICK_REFERENCE.md** | Developer quick lookup (5-minute read) | 5 min |
| **NUVEMSHOP_FTP_VIOLATION_RECOVERY.md** | Step-by-step recovery procedures for mistakes | 15 min |
| **NUVEMSHOP_INTEGRATION_QUICK_START.md** | Getting started: setup and onboarding | 10 min |
| **NUVEMSHOP_CONTEXT_REFACTORING_GUIDE.md** | Architecture refactoring plan for AIOX 10/10 compliance | 30 min |

## Quick Start for Developers

**First time? Start here:**
1. Read: NUVEMSHOP_FTP_QUICK_REFERENCE.md (5 min)
2. Skim: NUVEMSHOP_FTP_STANDARDS.md (constraints section)
3. Code confidently!

**Made a mistake?**
→ See: NUVEMSHOP_FTP_VIOLATION_RECOVERY.md

**Implementing changes?**
→ Check: NUVEMSHOP_INTEGRATION_QUICK_START.md

**Want architecture details?**
→ Read: NUVEMSHOP_CONTEXT_REFACTORING_GUIDE.md

## Related Documentation

- **Architecture**: `docs/architecture/nuvemshop/` — Technical design
- **Reports**: `docs/reports/nuvemshop/` — Analysis & assessments
- **Reviews**: `docs/reviews/nuvemshop/` — Architecture reviews

## Key Constraints to Remember

🔴 **CRITICAL (Cannot violate):**
- Checkout structure (locked by platform)
- Footer attribution (legal requirement - TOS)
- Form field backend integration

🟡 **HIGH (Important):**
- CSS performance budget (< 50KB)
- JavaScript safety checks
- Form integrity (contact, registration, newsletter)

## Framework Files

Related AIOX framework files:
- **Rule**: `.claude/rules/nuvemshop-ftp-constraints.md` (contextual guidance)
- **Checklist**: `.aiox-core/development/checklists/nuvemshop-ftp-constraints.md` (QA validation)
- **Patterns**: `.aiox-core/data/nuvemshop-patterns.yaml` (constraint registry)
- **Script**: `ftp-deploy/validate-nuvemshop-constraints.js` (automation)

---

📖 Last Updated: 2026-03-20

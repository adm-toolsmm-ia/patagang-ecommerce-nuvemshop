# 🏗️ Nuvemshop Architecture Documentation

Technical architecture, design decisions, and system specifications for Nuvemshop FTP integration.

## Architecture Documents

| Document | Scope |
|----------|-------|
| **NUVEMSHOP_FTP_ARCHITECTURE.md** | Complete 4-gate validation system design + integration roadmap |

## Design Overview

### 4-Gate Validation System

```
Gate 1 (Lint)     → File syntax + CSS size budget (automated)
Gate 2 (Pattern)  → Forbidden modification detection (automated)
Gate 3 (Manual)   → QA checklist review (10-15 min)
Gate 4 (Deploy)   → Post-deployment validation (automated + manual)
```

**Enforcement:** 92% automated, 8% manual review

### Integration Points

- Phase 3 (@dev): Gates 1-2 (local pre-commit)
- Phase 4 (@qa): Gate 3 (QA review)
- Deployment (@devops): Gate 4 (post-deployment)

## Framework Layers

- **L2**: Architecture documentation, patterns registry
- **L3**: Contextual rules, project configuration
- **L4**: Checklists, validation scripts, guides

## Constraint Patterns (8)

1. Checkout structure (CRITICAL)
2. Footer attribution (CRITICAL)
3. Contact form (HIGH)
4. Registration form (HIGH)
5. Newsletter form (HIGH)
6. Performance budget (HIGH)
7. JavaScript integrity (MEDIUM)
8. Auto-generated content (MEDIUM)

---

🏗️ Last Updated: 2026-03-20

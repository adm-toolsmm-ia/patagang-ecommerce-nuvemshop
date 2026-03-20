# Architect Agent Memory (Aria)

## Active Patterns
<!-- Current, verified patterns used by this agent -->

### Architecture Decisions
- CLI First > Observability > UI (Constitution Article I)
- Task-First: Tasks define WHAT, executors are interchangeable
- Provider-agnostic code-intel layer (Code Graph MCP primary)
- SYNAPSE 8-layer context engine (L0-L2 active, L3-L7 disabled per NOG-18)

### Key Architectural Patterns
- Tiered loading in UAP: Critical (80ms) → High (120ms) → Best-effort (180ms)
- Circuit breaker for external providers (code-intel, MCP)
- Atomic writes for file persistence (`atomicWriteSync`)
- ideSync for cross-IDE agent distribution

### Technology Stack
- Node.js 18+, CommonJS, ES2022
- Jest 30.2.0, ESLint, Prettier
- Supabase (database), Vercel (hosting)

### Delegation Rules
- Database schema design → @data-engineer
- Git push/PR → @devops
- Implementation → @dev

### Project Structure
- `.aiox-core/core/` — Engine modules
- `docs/architecture/` — Architecture docs
- `docs/prd/` — Sharded PRDs

## Patagang Nuvemshop Architecture Decisions
<!-- Technology and design decisions for FTP-deployed Nuvemshop theme -->
<!-- Last Updated: 2026-03-20 -->

### Project Architecture (Patagang Ecommerce)
- **Platform**: NuvemShop (Twig-based, FTP-deployed theme)
- **Theme Location**: `theme-deploy-corrigido/` (FTP root)
- **Deployment**: FTP with auto-versioning (`.aiox-core/infrastructure/ftp-deployment/`)
- **Design System**: Evolving (v3.0 with responsive fixes)

### Design Constraints (Non-Negotiable)
These are enforced by `.claude/rules/nuvemshop-ftp-constraints.md`

| Area | Constraint | Reason | Flexibility |
|------|-----------|--------|-------------|
| Checkout | Form structure locked | Platform TOS | Colors/styling only |
| Footer | Attribution visible | Platform TOS (legal) | Position/styling |
| Forms | Field structure locked | Backend integration | Labels/placeholders only |
| JavaScript | No global overrides | Platform stability | Namespaced code only |
| CSS | < 50 KB (critical) | Page render performance | Optimize/compress required |

### CSS Architecture (Cascata Model)
**Load Order (CRITICAL for specificity):**
1. `style-critical.tpl` (inline, first paint)
2. `style-colors.scss.tpl` (async)
3. `style-async.scss.tpl` (async, non-critical)
4. `layout.tpl <style>` (inline, FINAL - uses !important to override all)

**Pattern**: Use layout.tpl final override block for cross-cutting style fixes

### Integration Patterns
- **Images**: Nuvemshop image server handles srcset (verified working)
- **Conditionals**: Use Twig template variable (`{% if template == 'product' %}`)
- **Forms**: Never modify backend; only styling/UX text allowed
- **Reviews Plugin**: Verify admin activation before assuming JS availability

### Monitoring & Versioning
- **Version tracking**: Auto-incremented on FTP deploy
- **Backups**: Stored in `backups/incremental/` (latest tracked)
- **Rollback procedure**: FTP restore from backup folder

---

## Promotion Candidates
<!-- Patterns seen across 3+ agents — candidates for CLAUDE.md or .claude/rules/ -->
<!-- Format: - **{pattern}** | Source: {agent} | Detected: {YYYY-MM-DD} -->

## Archived
<!-- Patterns no longer relevant — kept for history -->
<!-- Format: - ~~{pattern}~~ | Archived: {YYYY-MM-DD} | Reason: {reason} -->

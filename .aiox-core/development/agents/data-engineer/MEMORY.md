# Data Engineer Agent Memory (Dara)

## Active Patterns
<!-- Current, verified patterns used by this agent -->

### Key Patterns
- CommonJS (`require`/`module.exports`), NOT ES Modules
- ES2022, Node.js 18+, 2-space indent, single quotes
- Absolute imports always (never relative `../`)
- kebab-case for files, PascalCase for components

### Project Structure
- `.aiox-core/core/` — Core modules
- `packages/db/` — Database packages (if applicable)
- `tests/` — Test suites (mirrors source structure)

### Git Rules
- NEVER push — delegate to @devops
- Conventional commits: `feat:`, `fix:`, `docs:`, `test:`

### Database Conventions
- Schema design follows architect decisions
- RLS policies for row-level security
- Migration scripts with rollback procedures

## Patagang Database Patterns
<!-- Database design patterns for NuvemShop integration (if applicable) -->
<!-- Last Updated: 2026-03-20 -->

### Patagang Database Context
**Status:** NuvemShop is SaaS (no direct database access required for basic implementation)

**If Database is Needed:**
- Backend API integration with Nuvemshop (read orders, products, customers)
- Cache layer for performance (Redis / Memcached)
- Analytics database (separate from Nuvemshop)

### Design Principles
- **Delegation from @architect:** @architect defines high-level data architecture
- **@data-engineer responsibility:** Detailed DDL, migrations, optimization
- **Integration pattern:** Nuvemshop webhook integration → local cache → analytics

### Schema Design (If Applicable)
```sql
-- Example: Order cache table
CREATE TABLE order_cache (
  id UUID PRIMARY KEY,
  nuvemshop_order_id INT UNIQUE,
  status VARCHAR(50),
  total DECIMAL(10,2),
  synced_at TIMESTAMP,
  created_at TIMESTAMP
);

-- RLS Policy: Only app service can access
ALTER TABLE order_cache ENABLE ROW LEVEL SECURITY;
```

### Nuvemshop Integration Pattern
1. Webhook receives order event from Nuvemshop
2. Validate and insert into local cache
3. Trigger analytics processing
4. Return 200 OK to Nuvemshop

---

## Promotion Candidates
<!-- Patterns seen across 3+ agents — candidates for CLAUDE.md or .claude/rules/ -->
<!-- Format: - **{pattern}** | Source: {agent} | Detected: {YYYY-MM-DD} -->

## Archived
<!-- Patterns no longer relevant — kept for history -->
<!-- Format: - ~~{pattern}~~ | Archived: {YYYY-MM-DD} | Reason: {reason} -->

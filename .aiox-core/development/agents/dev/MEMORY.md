# Dev Agent Memory (Dex)

## Active Patterns
<!-- Current, verified patterns used by this agent -->

### Key Patterns
- CommonJS (`require`/`module.exports`), NOT ES Modules
- ES2022, Node.js 18+, 2-space indent, single quotes
- Absolute imports always (never relative `../`)
- kebab-case for files, PascalCase for components
- Jest 30.2.0 for testing, `npm test` to run

### Project Structure
- `.aiox-core/core/` — Core modules (synapse, session, code-intel, orchestration)
- `.aiox-core/development/` — Agents, tasks, templates, scripts
- `.aiox-core/infrastructure/` — CI/CD, git detection, project-status
- `tests/` — Test suites (mirrors source structure)
- `docs/stories/` — Story files (active development)

### Git Rules
- NEVER push — delegate to @devops
- Conventional commits: `feat:`, `fix:`, `docs:`, `test:`, `chore:`, `refactor:`
- Reference story: `feat: implement feature [Story NOG-18]`

### Common Gotchas
- Windows paths: use forward slashes in code, bash shell not cmd
- `fs.existsSync` for sync checks, `fs.promises` for async
- atomicWriteSync from `.aiox-core/core/synapse/utils/atomic-write` for safe file writes
- CodeRabbit runs in WSL, not Windows directly

### Story Workflow
- Read task → Implement → Write tests → Validate → Mark checkbox [x]
- ONLY update: checkboxes, Debug Log, Completion Notes, Change Log, File List
- NEVER modify: Status, Story, AC, Dev Notes, Testing sections

## Promotion Candidates
<!-- Patterns seen across 3+ agents — candidates for CLAUDE.md or .claude/rules/ -->
<!-- Format: - **{pattern}** | Source: {agent} | Detected: {YYYY-MM-DD} -->
- **NEVER push — delegate to @devops** | Source: dev, analyst, sm, data-engineer, ux, qa (6 agents) | Detected: 2026-02-22 | Status: Already elevated to `.claude/rules/agent-authority.md`
- **CommonJS module system (require/module.exports)** | Source: dev, analyst, sm, data-engineer, ux, architect (6 agents) | Detected: 2026-02-22 | Status: Already in CLAUDE.md (Padroes de Codigo)
- **Conventional commits format** | Source: dev, devops, analyst, sm, data-engineer, ux (6 agents) | Detected: 2026-02-22 | Status: Already in CLAUDE.md (Convencoes Git)
- **kebab-case for files** | Source: dev, analyst, sm, data-engineer, ux (5 agents) | Detected: 2026-02-22 | Status: Already in CLAUDE.md (Padroes de Codigo)

## Patagang Nuvemshop Project Patterns
<!-- Verified patterns specific to Patagang ecommerce (FTP-deployed Nuvemshop theme) -->
<!-- Last Updated: 2026-03-20 -->

### FTP Theme Structure
- **Base folder**: `theme-deploy-corrigido/` (FTP root)
- **Templates**: `layouts/layout.tpl` (master), `snipplets/*.tpl` (components), `templates/*.tpl` (pages)
- **Styles**: `static/css/style-*.scss.tpl` (CSS files are Twig-templated)
- **Load order**: style-critical.tpl (inline) → style-colors.scss.tpl (async) → style-async.scss.tpl → layout.tpl `<style>` (final override)

### Nuvemshop FTP Constraints (CRITICAL - Article V Quality First)
**See:** `.claude/rules/nuvemshop-ftp-constraints.md`
- 🔴 **CRITICAL:** Checkout structure locked (no field modifications)
- 🔴 **CRITICAL:** Footer attribution MUST be visible (TOS requirement)
- 🔴 **CRITICAL:** Contact/Registration/Newsletter forms — structure locked
- 🟡 **HIGH:** CSS file size limit (style-critical.tpl < 50 KB)
- 🟡 **HIGH:** JavaScript safety (no override of Nuvemshop globals)
- 🟡 **MEDIUM:** Auto-generated files locked (sitemap.xml, robots.txt)

**Implementation Pattern:**
- Only modify: Colors, fonts, spacing, visibility (UI enhancements)
- Never modify: Form fields, checkout logic, form submission, global JS overrides
- Test: FTP deploy checklist in `.aiox-core/development/checklists/ftp-deploy-checklist.md`

### Nuvemshop Twig Template Conditionals
- `{% if template == 'product' %}` → Product detail page
- `{% if template == 'category' %}` → Category listing
- `{% if template == 'home' %}` → Homepage
- `{% if template == 'cart' %}` → Shopping cart
- `{% if template == 'checkout' %}` → Checkout (LOCKED STRUCTURE)
- `{% if template == 'account.*' %}` → Account pages

### Design System (Current)
- **Primary Yellow**: #EAFE67 (saturated, use sparingly)
- **Primary Black**: #1A1A1A
- **Gray Neutral**: #F0F0F0, #E8E8E8 (recommended for UI)
- **Green (success)**: #00CC66

### File Updates in Story
- **Update always**: File List section, checkbox progress [x]
- **Never modify**: Story title, Status, AC, scope, Dev Notes
- **Story file location**: `docs/stories/{storyID}.story.md`

---

## Archived
<!-- Patterns no longer relevant — kept for history -->
<!-- Format: - ~~{pattern}~~ | Archived: {YYYY-MM-DD} | Reason: {reason} -->

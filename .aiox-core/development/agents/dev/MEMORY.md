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

## Patagang Project Patterns (Story 8.5 — 2026-03-24)

### Lazy-Load Pattern for Heavy Scripts
- **Pattern:** Move heavy external scripts from template load to DOMContentLoaded
- **Applied:** Olark live chat in Story 8.5 Priority 1
- **Process:**
  1. Identify heavy script in external.js.tpl or similar
  2. Extract minified script code
  3. Add conditional check: `if (condition) { loadScript(); }`
  4. Wrap in DOMContentLoaded.addEventOrExecute(() => { ... })
  5. For template variables: use `window.store.live_chat` instead of `{{ store.live_chat }}`
- **Benefit:** Page renders faster, heavy scripts load in background
- **Files Affected:** external.js.tpl, store.js.tpl
- **Versions:** v1.5.74 (Priority 1), planned: v1.5.75-77 (Priorities 2-4)

### FTP Deploy Pattern (Story 8.5)
- **Process:** `node ftp-deploy/deploy.js "v1.X.X: message [Story Y.Z]" --force`
- **Auto-actions:**
  1. Version auto-increments (patch version)
  2. Git commit created (version bump)
  3. Git tag created (v1.X.X)
  4. Git push executes (tag pushed to GitHub)
  5. Backup created: `backups/deployment-vX.X.X/TIMESTAMP/`
  6. Files uploaded to FTP
  7. Validation: checksums verified on FTP
- **Output:** See `ftp-deploy-vX.X.X.log`
- **Rollback:** `node ftp-deploy/rollback-incremental.js --version v1.X.X`

### Nuvemshop FTP Constraints (Always Verify)
- ✅ Safe: CSS, JS, HTML changes
- ❌ Never modify: Checkout structure, footer attribution, form fields
- Reference: `.claude/rules/nuvemshop-ftp-constraints.md`

## Archived
<!-- Patterns no longer relevant — kept for history -->
<!-- Format: - ~~{pattern}~~ | Archived: {YYYY-MM-DD} | Reason: {reason} -->

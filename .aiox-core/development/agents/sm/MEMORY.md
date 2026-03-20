# Scrum Master Agent Memory (River)

## Active Patterns
<!-- Current, verified patterns used by this agent -->

### Key Patterns
- CommonJS (`require`/`module.exports`), NOT ES Modules
- ES2022, Node.js 18+, 2-space indent, single quotes
- kebab-case for files, PascalCase for components

### Project Structure
- `docs/stories/epics/` — Epic directories with INDEX.md + stories
- `.aiox-core/development/templates/` — Story templates
- `.aiox-core/development/checklists/` — Draft checklists

### Git Rules
- NEVER push — delegate to @devops
- Conventional commits: `docs:` for story creation

### Story Conventions
- Story naming: `story-{PREFIX}-{N}-{slug}.md`
- Epic INDEX.md tracks all stories with status
- Stories flow: Draft → Ready → InProgress → InReview → Done

## Patagang Story Creation Patterns
<!-- Story templates and patterns for NuvemShop FTP theme work -->
<!-- Last Updated: 2026-03-20 -->

### Epic-Driven Story Creation
1. **From Epic:** @pm creates epic (EPIC-01, EPIC-02, etc.) in `.aiox-core/data/patagang-project-state.yaml`
2. **Create Story:** @sm `*draft` story with reference to epic
3. **Template:** Use `.aiox-core/development/templates/story-tmpl.yaml`
4. **Naming:** `{epicNum}.{storyNum}.{slug}.story.md`

### Story Metadata for Patagang
```yaml
story:
  id: "1.1.1"
  title: "Implement Help Sidebar Button"
  epic: "EPIC-01"
  description: "..."
  acceptance_criteria:
    - "AC 1: Button visible on all pages except checkout"
    - "AC 2: Color matches design system"
    - "AC 3: FTP validation ✅"
  ftp_constraints:
    - "no_checkout_modifications"
    - "style_only"
  files:
    - "theme-deploy-corrigido/snipplets/help-sidebar.tpl"
    - "theme-deploy-corrigido/static/css/style-help-sidebar.scss"
```

### Story-Epic Relationship
- Story is ALWAYS tied to epic (Story-Driven Article III)
- Epic tracks story progress
- Story status flows: Draft → Ready → InProgress → Done

---

## Promotion Candidates
<!-- Patterns seen across 3+ agents — candidates for CLAUDE.md or .claude/rules/ -->
<!-- Format: - **{pattern}** | Source: {agent} | Detected: {YYYY-MM-DD} -->

## Archived
<!-- Patterns no longer relevant — kept for history -->
<!-- Format: - ~~{pattern}~~ | Archived: {YYYY-MM-DD} | Reason: {reason} -->

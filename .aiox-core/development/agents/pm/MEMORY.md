# PM Agent Memory (Morgan)

## Active Patterns
<!-- Current, verified patterns used by this agent -->

### Responsibilities
- PRD creation (greenfield + brownfield)
- Epic creation and management
- Product strategy and roadmap
- Requirements gathering (spec pipeline)

### Epic Orchestration
- `*execute-epic` with `EPIC-{ID}-EXECUTION.yaml`
- State tracked in `.aiox/epic-{epicId}-state.yaml`
- Wave-based parallel execution

### Delegation
- Story creation → @sm (`*draft`)
- Course correction → @aiox-master (`*correct-course`)
- Deep research → @analyst (`*research`)

### Bob Mode (user_profile=bob)
- PM acts as orchestrator when `user_profile: bob`
- Spawns other agents via TerminalSpawner
- Session state persistence in `.aiox/bob-session/`

### Key Locations
- PRD: `docs/prd/` (sharded)
- Epics: `docs/stories/epics/`
- Templates: `.aiox-core/development/templates/`

## Patagang Epic & Requirements Patterns
<!-- Epic and PRD patterns specific to Patagang ecommerce (NuvemShop FTP theme) -->
<!-- Last Updated: 2026-03-20 -->

### Epic Structure for Patagang
**Standard Epic Template:**
```yaml
epic:
  id: "EPIC-01"
  title: "Design System & Styling"
  status: "active"
  description: "..."
  stories: []         # Populated as @sm creates stories
  constraints:        # FTP constraints from nuvemshop-patterns.yaml
    - "checkout_structure_locked"
    - "footer_attribution_required"
    - "form_field_integrity"
    - "css_size_limit_50kb"
  target_completion: "2026-04-30"
```

### Requirements Gathering Pattern
1. **Functional Requirements (FR-*):** What the system does
   - Example: "FR-001: Users can customize help sidebar button color"
2. **Non-Functional Requirements (NFR-*):** Performance, security, scalability
   - Example: "NFR-001: Page load < 3s (Core Web Vitals)"
3. **Constraints (CON-*):** FTP/Nuvemshop limitations
   - Example: "CON-001: Checkout form structure locked (TOS)"

### Spec Pipeline Ownership
- **Phase 1 (Gather):** @pm collects requirements
- **Phase 4 (Write Spec):** @pm writes spec.md from requirements + @analyst research
- **Article IV (No Invention):** Every statement must trace back to requirement or research finding

### Patagang Product Context
- **Goal:** E-commerce theme for Nuvemshop (Patagang brand store)
- **Constraints:** FTP-based deployment, theme structure locked by Nuvemshop
- **Quality:** Constitutional Article V (Quality First) + FTP validation gates
- **Versioning:** Auto-versioned on deploy (v{YYYY-MM-DD}-{iteration})

---

## Promotion Candidates
<!-- Patterns seen across 3+ agents — candidates for CLAUDE.md or .claude/rules/ -->
<!-- Format: - **{pattern}** | Source: {agent} | Detected: {YYYY-MM-DD} -->

## Archived
<!-- Patterns no longer relevant — kept for history -->
<!-- Format: - ~~{pattern}~~ | Archived: {YYYY-MM-DD} | Reason: {reason} -->

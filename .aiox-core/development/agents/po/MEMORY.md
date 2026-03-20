# PO Agent Memory (Pax)

## Active Patterns
<!-- Current, verified patterns used by this agent -->

### Responsibilities
- Story validation (`*validate-story-draft`) — 10-point checklist
- Backlog management and prioritization
- Story lifecycle: Draft → Ready transition (MUST update status)
- Epic context tracking

### Validation Checklist (10 Points)
1. Clear title
2. Complete description
3. Testable AC (Given/When/Then)
4. Defined scope (IN/OUT)
5. Dependencies mapped
6. Complexity estimate
7. Business value
8. Risks documented
9. Criteria of Done
10. PRD/Epic alignment

### Story File Permissions
- CAN edit: QA Results section (when reviewing)
- MUST update: Status field (Draft → Ready on GO)
- CANNOT modify: AC, Scope, Title, Dev Notes, Testing

### Delegation
- Story creation → @sm (`*draft`)
- Epic creation → @pm (`*create-epic`)
- Course correction → @aiox-master

### Key Locations
- Stories: `docs/stories/`
- Backlog: `docs/stories/backlog/`
- Templates: `.aiox-core/development/templates/story-tmpl.yaml`

## Patagang Story Validation Patterns
<!-- Story validation specific to NuvemShop FTP theme requirements -->
<!-- Last Updated: 2026-03-20 -->

### Patagang-Specific Validation Rules

**AC Testing for FTP Constraints:**
- [ ] Does AC mention checkout? → ENSURE: "No form structure changes" in AC
- [ ] Does AC mention footer? → ENSURE: "Attribution remains visible" in AC
- [ ] Does AC mention forms? → ENSURE: "Structure locked" in AC
- [ ] Does AC mention CSS? → ENSURE: "File size < 50 KB"

**Story Quality for Nuvemshop:**
- Acceptance criteria must be FTP-aware (constraint acknowledgment)
- Story scope must fit SDC phase (1 iteration)
- Dependencies on FTP constraints documented
- QA testing plan must include FTP validation checklist

### Story Acceptance Template
```markdown
## Acceptance Criteria
- [ ] AC 1: Feature works as designed (include FTP constraint awareness)
- [ ] AC 2: Code follows AIOX standards
- [ ] AC 3: Tests written and passing
- [ ] AC 4: FTP deployment validation checklist ✅

## FTP Constraints Check
- [ ] No checkout structure modifications
- [ ] Footer attribution not hidden
- [ ] Forms not structurally modified
- [ ] CSS < 50 KB
```

---

## Promotion Candidates
<!-- Patterns seen across 3+ agents — candidates for CLAUDE.md or .claude/rules/ -->
<!-- Format: - **{pattern}** | Source: {agent} | Detected: {YYYY-MM-DD} -->

## Archived
<!-- Patterns no longer relevant — kept for history -->
<!-- Format: - ~~{pattern}~~ | Archived: {YYYY-MM-DD} | Reason: {reason} -->

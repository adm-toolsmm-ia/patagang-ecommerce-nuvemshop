# Analyst Agent Memory (Atlas)

## Active Patterns
<!-- Current, verified patterns used by this agent -->

### Key Patterns
- CommonJS (`require`/`module.exports`), NOT ES Modules
- ES2022, Node.js 18+, 2-space indent, single quotes
- Absolute imports always (never relative `../`)
- kebab-case for files, PascalCase for components

### Project Structure
- `.aiox-core/core/` — Core modules (synapse, session, code-intel, orchestration)
- `.aiox-core/development/` — Agents, tasks, templates, scripts
- `docs/research/` — Research outputs (YYYY-MM-DD-slug format)
- `docs/stories/` — Story files (active development)

### Git Rules
- NEVER push — delegate to @devops
- Conventional commits: `feat:`, `fix:`, `docs:`, `test:`, `chore:`, `refactor:`

### Research Conventions
- Output dir: `docs/research/{YYYY-MM-DD}-{slug}/`
- Use tech-search skill for deep research
- Always include sources and methodology

## Patagang Research & Analysis Patterns
<!-- Research findings and analysis for NuvemShop FTP integration -->
<!-- Last Updated: 2026-03-20 -->

### Spec Pipeline Research (Phase 3)
- Input: Requirements from @pm (Phase 1)
- Task: Validate and research each requirement
- Output: research.json with findings + sources
- Constitutional Gate: Every research finding MUST have source/evidence (Article IV - No Invention)

### Nuvemshop Research Focus Areas
- **FTP Constraints:** Checkout, footer, form limitations (already well-documented)
- **Platform Capabilities:** Twig conditionals, CSS performance, image serving
- **Integration Patterns:** Nuvemshop API, webhook handlers, event system
- **Quality:** Compliance requirements, TOS implications

### Research Documentation
```markdown
# Research Finding: {Topic}

## Question
What is [topic]? Why does it matter?

## Findings
- Finding 1: [description] **SOURCE:** [link/reference]
- Finding 2: [description] **SOURCE:** [link/reference]

## Implications for Patagang
- Impact 1: How this affects Patagang development
- Impact 2: Constraints or opportunities

## Recommendations
- Action 1: Implement this pattern
- Action 2: Document this constraint
```

---

## Promotion Candidates
<!-- Patterns seen across 3+ agents — candidates for CLAUDE.md or .claude/rules/ -->
<!-- Format: - **{pattern}** | Source: {agent} | Detected: {YYYY-MM-DD} -->

## Archived
<!-- Patterns no longer relevant — kept for history -->
<!-- Format: - ~~{pattern}~~ | Archived: {YYYY-MM-DD} | Reason: {reason} -->

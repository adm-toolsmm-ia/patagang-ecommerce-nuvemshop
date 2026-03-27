# AIOX Quickstart — Development Methodology & Best Practices

**Type:** L2 Development Reference (NOT auto-loaded)
**Created:** 2026-03-28
**For:** Developers starting with AIOX framework

---

## Story-Driven Development (SDC)

### Workflow

1. **Work from stories** — All development starts with a story in `docs/stories/`
2. **Update progress** — Mark checkboxes: [ ] → [x]
3. **Track changes** — Maintain File List in story
4. **Follow criteria** — Implement exactly what acceptance criteria specify

### Code Standards

- Write clean, self-documenting code
- Follow existing patterns in codebase
- Comprehensive error handling (all paths)
- Unit tests for all new functionality
- TypeScript/JavaScript best practices

### Testing Requirements

- Run all tests before marking complete
- Linting: `npm run lint` (MUST PASS)
- Type checking: `npm run typecheck` (MUST PASS)
- Tests for new features + edge cases
- Zero console errors in browser

---

## Task Execution Pattern

1. Read complete task/workflow definition
2. Understand all elicitation points (interactive workflows)
3. Execute steps sequentially
4. Handle errors gracefully + provide context
5. Provide clear feedback on completion

### Interactive Workflows

Workflows with `elicit: true` require user input:
- Present options clearly
- Validate responses
- Provide helpful defaults
- Never skip elicitation for efficiency

---

## Best Practices

### When Implementing Features

- Check existing patterns first (reuse > invent)
- Reuse components and utilities
- Follow naming conventions (lowercase-hyphenated)
- Keep functions focused and testable
- Document complex logic (inline comments)

### When Working with Agents

- Respect agent boundaries (@agent for task)
- Use appropriate agent for each domain
- Follow agent communication patterns
- Maintain agent context during handoffs

### When Handling Errors

```javascript
try {
  // Operation
} catch (error) {
  console.error(`Error in ${operation}:`, error);
  throw new Error(`Failed to ${operation}: ${error.message}`);
}
```

Include context + recovery suggestions

---

## Git & GitHub Integration

### Commit Conventions

**Format:** `{type}: {description} [Story X.Y.Z]`
**Types:** feat, fix, docs, chore, refactor, test, style

**Example:**
```
feat: implement sidebar help button [Story 1.1.1]

Added help button with tooltip showing support link.
Positioned top-right, styled with primary color.

Constraints: ✅ Nuvemshop 8/8, CSS < 50KB

Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>
```

### GitHub CLI (via @devops)

- Verify auth: `gh auth status`
- Create PR: `gh pr create --title '...' --body '...'`
- Check status: `gh pr view 123`

**NOTE:** Only @devops pushes to remote (`git push` is exclusive)

---

## Environment Setup

**Required Tools:**
- Node.js 18+
- GitHub CLI
- Git
- npm/yarn/pnpm

**Config Files:**
- `.aiox/config.yaml` — Framework configuration
- `.env` — Environment variables
- `aiox.config.js` — Project-specific settings

### Enable Debug Mode

```bash
export AIOX_DEBUG=true              # Enable debug output
tail -f .aiox/logs/agent.log        # View agent logs
npm run trace -- workflow-name      # Trace workflow execution
```

---

## Workflow Execution (4 Primary Workflows)

### 1. Story Development Cycle (SDC)

**Primary workflow** for all development work.

```
@sm *create-next-story
  ↓ (Draft)
@po *validate-next-story
  ↓ (Validated)
@dev *develop-story
  ↓ (Ready → InProgress)
@qa *qa-gate
  ↓ (PASS / CONCERNS / FAIL)
DONE (InReview → Done)
```

**Inputs:** PRD sharded, epic context
**Outputs:** Story file, code changes, tests

---

### 2. QA Loop (Iterative Review)

**Automated review-fix cycle** after initial QA gate.

```
@qa review → verdict
  ↓
@dev fixes (if REJECT)
  ↓
Re-review (max 5 iterations)
```

**Verdicts:**
- APPROVE → Complete story
- REJECT → @dev fixes + re-review
- BLOCKED → Escalate to @architect

---

### 3. Spec Pipeline (Pre-Implementation)

**Transform requirements into executable spec** (6 phases).

| Phase | Agent | Output |
|-------|-------|--------|
| 1 | @pm | requirements.json |
| 2 | @architect | complexity.json |
| 3 | @analyst | research.json |
| 4 | @pm | spec.md |
| 5 | @qa | critique.json |
| 6 | @architect | implementation.yaml |

**Complexity Classes:**
- SIMPLE (≤8): gather → spec → critique
- STANDARD (9-15): all 6 phases
- COMPLEX (≥16): all 6 + revision cycle

---

### 4. Brownfield Discovery (Legacy Assessment)

**10-phase technical debt assessment** for existing codebases.

Phases 1-3: Data collection (architecture, schema, UX)
Phases 4-7: Draft & validation (debt assessment + QA gate)
Phases 8-10: Finalization (final assessment + report + epic)

---

## Troubleshooting

| Issue | Solution |
|-------|----------|
| Agent not responding | `@agent-name *help` to activate |
| Tests failing | Run locally: `npm test`, check output |
| Linting errors | `npm run lint -- --fix` to auto-fix |
| Type checking | `npm run typecheck` to verify |
| Git conflict | Resolve conflicts, `git add`, new commit |

---

## See Also

- **File Structure:** `.aiox-core/development/docs/FILE_STRUCTURE_EXTENDED_GUIDE.md`
- **Safe Deployment:** `.aiox-core/development/docs/SAFE_DEPLOYMENT_STANDARD.md`
- **Nuvemshop Constraints:** `.aiox-core/development/docs/NUVEMSHOP_FTP_REFERENCE.md`
- **Communication:** `.aiox-core/development/docs/COMMUNICATION_GUIDELINES.md`
- **Lessons Learned:** `.aiox-core/development/docs/LESSONS-LEARNED-SYNTHESIS.md`

---

**Version:** 2.0
**Type:** L2 Development Reference (on-demand loaded)

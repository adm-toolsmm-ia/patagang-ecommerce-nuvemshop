# QA Agent Memory (Quinn)

## Active Patterns
<!-- Current, verified patterns used by this agent -->

### Review Patterns
- ONLY update "QA Results" section in story files
- Gate decisions: PASS / CONCERNS / FAIL / WAIVED
- CodeRabbit self-healing: max 3 iterations, CRITICAL+HIGH auto-fix

### Test Infrastructure
- `npm test` — Jest 30.2.0
- `npm run lint` — ESLint
- Tests location: `tests/` directory, mirrors source structure
- Coverage: `npm run test:coverage`

### Quality Checks (7-point)
1. Code review (patterns, readability)
2. Unit tests (coverage, passing)
3. Acceptance criteria met
4. No regressions
5. Performance acceptable
6. Security (OWASP basics)
7. Documentation updated

### Common Issues
- Windows path separators in test assertions
- CodeRabbit WSL execution: `wsl bash -c 'cd /mnt/c/... && ~/.local/bin/coderabbit ...'`
- SYNAPSE metrics at `.synapse/metrics/`
- Pipeline benchmarks at `tests/synapse/benchmarks/`

### Git Rules
- Read-only: `git status`, `git log`, `git diff`
- NEVER commit or push

## Patagang Nuvemshop QA Patterns
<!-- FTP theme validation specific to Nuvemshop constraints -->
<!-- Last Updated: 2026-03-20 -->

### Gate Verdict Criteria (SDC Phase 4)

**PASS Verdict Requires:**
1. ✅ All checkboxes [x] marked in story
2. ✅ `npm test` passes (Jest)
3. ✅ `npm run lint` passes (no errors)
4. ✅ `npm run typecheck` passes
5. ✅ CodeRabbit auto-fix < 3 iterations, no CRITICAL issues
6. ✅ No regressions (previous tests still pass)
7. ✅ FTP deployment checklist passed: `.aiox-core/development/checklists/ftp-deploy-checklist.md`

**CONCERNS Verdict When:**
- Minor issues found (non-blocking)
- Rework needed but acceptable
- Recommendation: PASS with @dev follow-up

**FAIL Verdict When:**
- Any CRITICAL constraint violated (Article V Quality First)
- Nuvemshop FTP constraint broken (checkout, footer, forms)
- Tests fail
- Lint/typecheck errors
- CodeRabbit CRITICAL issues

### Patagang FTP Deployment Validation
**Checklist location:** `.aiox-core/development/checklists/ftp-deploy-checklist.md`

**Critical checks:**
- [ ] No checkout structure modified
- [ ] Footer attribution visible (must pass auto-detection)
- [ ] Form fields intact (contact, registration, newsletter)
- [ ] CSS file size < 50 KB (style-critical.tpl)
- [ ] No Nuvemshop global overrides in JS
- [ ] FTP version bumped (auto-tracked)

**Gate:** Reject if ANY critical check fails

---

## Promotion Candidates
<!-- Patterns seen across 3+ agents — candidates for CLAUDE.md or .claude/rules/ -->
<!-- Format: - **{pattern}** | Source: {agent} | Detected: {YYYY-MM-DD} -->

## Archived
<!-- Patterns no longer relevant — kept for history -->
<!-- Format: - ~~{pattern}~~ | Archived: {YYYY-MM-DD} | Reason: {reason} -->

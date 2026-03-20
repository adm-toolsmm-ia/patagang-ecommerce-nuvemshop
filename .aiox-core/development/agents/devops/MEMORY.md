# DevOps Agent Memory (Gage)

## Active Patterns
<!-- Current, verified patterns used by this agent -->

### Exclusive Authority
- ONLY agent authorized for `git push`, `gh pr create`, `gh pr merge`
- ONLY agent for MCP infrastructure management
- Pre-push quality gates are MANDATORY

### Quality Gates (Pre-Push)
1. `npm run lint` — ESLint must PASS
2. `npm test` — Jest must PASS
3. CodeRabbit review — 0 CRITICAL issues
4. Story status = "Done" or "Ready for Review"
5. No uncommitted changes, no merge conflicts

### Git Conventions
- Conventional Commits: `feat:`, `fix:`, `docs:`, `test:`, `chore:`
- Branch patterns: `feat/*`, `fix/*`, `docs/*`
- Semantic versioning: MAJOR.MINOR.PATCH

### MCP Infrastructure
- Docker MCP Gateway on port 8080
- Servers: context7, desktop-commander, playwright, exa
- Config: `~/.docker/mcp/catalogs/docker-mcp.yaml`
- Known bug: Docker MCP secrets don't interpolate (use hardcoded values)

### Repository Detection
- Uses `repository-detector.js` for dynamic context
- Framework-dev vs project-dev mode detection

## Patagang FTP Deployment Patterns
<!-- FTP push and release management for Nuvemshop theme -->
<!-- Last Updated: 2026-03-20 -->

### Pre-Push Checklist (Before `git push`)
**Critical:** All must PASS before @devops push

1. ✅ @dev provides validated code (story marked Done)
2. ✅ @qa provides PASS verdict (QA gate)
3. ✅ FTP deployment checklist passed: `.aiox-core/development/checklists/ftp-deploy-checklist.md`
4. ✅ No Nuvemshop constraint violations detected
5. ✅ PR description includes: story ID, AC checklist, file list

### FTP Deployment Flow
```
@dev local validation → @qa gate PASS → @devops push

1. Create PR:
   gh pr create --title "feat: [Story X.X] description" \
     --body "## AC\n- [x] AC 1\n\n## Files\n- theme-deploy-corrigido/..."

2. Verify PR:
   - CodeRabbit ✅ (auto-runs)
   - All checks ✅
   - No conflicts ✅

3. Deploy (if hotfix):
   - FTP push (auto-versioned)
   - Version tag: git tag v{date}-{iteration}
   - Backup created: backups/incremental/{date}/

4. Merge to main:
   - Squash + merge (atomic)
   - Close PR
```

### Version Tracking
- **Format**: Auto-generated on FTP deploy
- **Pattern**: `v{YYYY-MM-DD}-{iteration}`
- **Backup**: Latest backup in `backups/incremental/` (auto-tracked)
- **Rollback**: Manual FTP restore from backup if needed

### Release Checklist (Major Release)
- [ ] All stories merged to main
- [ ] Changelog updated (`.aiox-core/data/changelog.md`)
- [ ] Version bumped (MAJOR.MINOR.PATCH)
- [ ] Tag created: `git tag v{version}`
- [ ] Release notes prepared
- [ ] FTP backup verified (rollback-ready)

---

## Promotion Candidates
<!-- Patterns seen across 3+ agents — candidates for CLAUDE.md or .claude/rules/ -->
<!-- Format: - **{pattern}** | Source: {agent} | Detected: {YYYY-MM-DD} -->

## Archived
<!-- Patterns no longer relevant — kept for history -->
<!-- Format: - ~~{pattern}~~ | Archived: {YYYY-MM-DD} | Reason: {reason} -->

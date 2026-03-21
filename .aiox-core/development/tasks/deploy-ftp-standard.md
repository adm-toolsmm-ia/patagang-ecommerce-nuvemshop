---
name: Deploy FTP Standard (AIOX v2.0)
description: Sistema de versionamento e deploy automático para Nuvemshop
type: task
version: 2.0.0
framework: AIOX
category: DevOps / Deployment
---

# 🚀 Deploy FTP Standard Task — AIOX v2.0

## Overview

This task executes the **6-phase deployment workflow** for Patagang Nuvemshop theme via FTP.

**Execution Model:** CLI-first, developer-initiated
**Framework:** AIOX v2 (Story-Driven, No Invention, Quality First)
**Language:** Portuguese (user-facing), English (technical)

---

## Quick Reference

```bash
# Developer executes:
npm run deploy "Descrição da mudança"

# Task handles (6 phases):
0. Validação de contexto (story, credentials)
1. Detecção de arquivos (git diff)
2. Auto-increment de versão (patch/minor)
3. Git commit + tag + push
4. Backup incremental
5. Deploy para FTP
6. Validação pós-deploy
```

---

## Task Inputs

### Required
- **description** (string) — Deployment description (pt-BR)
  - Example: "Fix: Ajustar cores no botão help sidebar"

### Optional
- **--minor** (flag) — Increment minor version (1.1.8 → 1.2.0)
- **--dry-run** (flag) — Simulate without git operations
- **--force** (flag) — Skip confirmation prompts (CI/CD)

---

## Task Outputs

### Success (exit 0)
- ✅ Versão incrementada
- ✅ Files deployed to FTP
- ✅ Git: commit, tag, push
- ✅ Backup created
- ✅ Validation passed

### Failure (exit 1)
- ❌ Missing credentials
- ❌ No files to deploy
- ❌ FTP connection failed
- ❌ Validation failed

---

## 6 Execution Phases

### Phase 0️⃣ — Context Validation
- Detect story from branch
- Validate FTP credentials (.env)
- Verify git repository

### Phase 1️⃣ — Detect Modified Files
- `git diff --name-only HEAD -- theme-deploy-corrigido/`
- Include: version-info.js (auto-updated)
- Abort if no files

### Phase 2️⃣ — Auto-Increment Version
- Parse current from VERSION.json
- Increment: patch (default) or minor (--minor flag)
- Update VERSION.json + version-info.js

### Phase 3️⃣ — Git Commit + Tag + Push
- `git add` VERSION.json, version-info.js
- `git commit "chore: bump version to X.Y.Z"`
- `git tag vX.Y.Z`
- **Prompt for confirmation** before push
- `git push origin main --tags`

### Phase 4️⃣ — Incremental Backup
- Download each file from FTP
- Save to: backups/deployment-{version}/{timestamp}/
- Create _METADATA.json (hashes, timestamps)

### Phase 5️⃣ — Deploy to FTP
- Upload each file to remote path
- Timeout: 30 seconds/file
- Retry: 3 attempts if timeout

### Phase 6️⃣ — Post-Deploy Validation
- Re-download each file from FTP
- Verify size, existence
- Check version-info.js content

---

## Implementation

**Language:** Node.js + basic-ftp
**Location:** `ftp-deploy/deploy.js`
**Entry Point:** `npm run deploy` (in package.json)

**Dependencies:**
- basic-ftp (FTP client)
- dotenv (environment loading)
- readline (user prompts)

**Configuration:**
- FTP credentials: `ftp-deploy/.env` (via process.env)
- Paths: `ftp-deploy/config.js`

---

## Related Documents

- **User Guide:** `docs/guides/nuvemshop/deployment-workflow.md`
- **CLI Docs:** `ftp-deploy/README-DEPLOYMENT.md`
- **Constraints:** `.claude/rules/nuvemshop-ftp-constraints.md`
- **Workflow:** `.aiox-core/development/workflows/ftp-deployment.yaml`
- **Config:** `ftp-deploy/config.js`, `.env.example`

---

**Status:** ✅ Production Ready (v2.0.0)
**Framework:** AIOX v2
**Language:** Portuguese (user), English (technical)
**Last Updated:** 2026-03-21

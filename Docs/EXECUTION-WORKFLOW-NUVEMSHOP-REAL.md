# 🚀 EXECUTION WORKFLOW — Nuvemshop FTP Real (Incremental Validated)

**Realidade Nuvemshop:** Staging não existe como separado. Validação acontece EM PRODUÇÃO + backup para rollback.

**Abordagem:** Backup incremental → Deploy real FTP → Validar em produção (loja ativa) → Sua aprovação → Keep/Rollback

---

## 📋 PADRÃO DE CADA STORY (Real Nuvemshop)

```
┌──────────────────────────────────────────────────────────────────┐
│              STORY EXECUTION — NUVEMSHOP REAL                    │
├──────────────────────────────────────────────────────────────────┤
│                                                                   │
│  STEP 1: DEVELOPMENT & LOCAL VALIDATION (Orion — Autônomo)       │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │ □ Read story file + understand AC fully                      │ │
│  │ □ Create feature branch (feature/TDB-2026-...)               │ │
│  │ □ Implement story completely                                 │ │
│  │ □ Local testing (4 browsers: Chrome, Firefox, Safari, Edge)  │ │
│  │ □ npm run lint → PASS                                        │ │
│  │ □ npm run test (se aplicável) → PASS                         │ │
│  │ □ Manual validation checklist (20+ items local)              │ │
│  │ □ Create PR with full description                            │ │
│  │ □ Code review approval (2+ eyes)                             │ │
│  │                                                              │ │
│  │ DELIVERABLE: PR approved, code ready for production          │ │
│  └─────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  STEP 2: IDENTIFY FILES TO DEPLOY (Orion — Autônomo)             │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │ □ List all files that will be changed/added                 │ │
│  │ □ Size check: Verify reasonable (< 10MB total)              │ │
│  │ □ Path verification: Correct theme structure                │ │
│  │ □ Format check: CSS, HTML, JS (não banco de dados)          │ │
│  │ □ Document complete file manifest                           │ │
│  │                                                              │ │
│  │ Example (Story 1.1.1 Focus Indicators):                       │ │
│  │   Files to change:                                          │ │
│  │   - /theme/css/accessibility.css (NEW, 2.1 KB)              │ │
│  │   - /theme/layouts/layout.tpl (MODIFIED, link added)        │ │
│  │   Total impact: 2 files, 2.5 KB total                        │ │
│  │                                                              │ │
│  │ DELIVERABLE: File manifest + impact assessment              │ │
│  └─────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  STEP 3: CREATE INCREMENTAL BACKUP (Orion — Autônomo)            │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │ □ Connect to FTP (read-only backup mode)                    │ │
│  │ □ Download current versions of files to be changed          │ │
│  │ □ Create backup directory: backup/TDB-2026-001.1.1/         │ │
│  │ □ Store with timestamp: backup/...story-id/timestamp/       │ │
│  │ □ Verify all files backed up                                │ │
│  │ □ Document backup manifest with file hashes                 │ │
│  │ □ Prepare rollback script (shell commands ready)            │ │
│  │                                                              │ │
│  │ Example (Story 1.1.1):                                        │ │
│  │   Backup location: backup/001.1.1/2026-03-24-10-30/         │ │
│  │   Files backed up:                                          │ │
│  │   - accessibility.css (from previous version if exists)     │ │
│  │   - layout.tpl (current link references)                    │ │
│  │   Rollback script: restore.sh (ready to execute)            │ │
│  │   Hash verification: All files checksummed                  │ │
│  │                                                              │ │
│  │ DELIVERABLE: Incremental backup complete, rollback ready    │ │
│  │ SAFETY: Can rollback in < 2 minutes                          │ │
│  └─────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  STEP 4: DEPLOY TO PRODUCTION FTP (Orion — Autônomo)             │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │ □ Connect to FTP (production credentials)                   │ │
│  │ □ Upload all new/modified files                             │ │
│  │ □ Verify upload success (file size + timestamp match)       │ │
│  │ □ NO cache busting yet (wait for user validation)           │ │
│  │ □ Log deployment: timestamp, files, sizes                   │ │
│  │ □ Take production screenshot (before validation)            │ │
│  │                                                              │ │
│  │ ⚠️  IMPORTANT: Users may see cached old version             │ │
│  │           Cache clear will happen after approval             │ │
│  │                                                              │ │
│  │ DELIVERABLE: Files deployed, ready for user validation      │ │
│  │ PRODUCTION: Files are live (but cache may show old)          │ │
│  └─────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  STEP 5: PRODUCTION VALIDATION — USER TESTS LIVE STORE          │ │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │ 🎯 VOCÊ ENTRA AQUI — Validar na loja ATIVA (produção)        │ │
│  │                                                              │ │
│  │ What you need to test:                                      │ │
│  │ □ Verify files deployed (check FTP or code inspection)      │ │
│  │ □ Hard refresh (Ctrl+Shift+R) to bypass cache               │ │
│  │ □ Test on 4 browsers (Chrome, Firefox, Safari, Edge)        │ │
│  │ □ Test on mobile (iOS Safari, Android Chrome)               │ │
│  │ □ Follow complete validation checklist (20+ items)          │ │
│  │ □ Check Lighthouse/accessibility if relevant                │ │
│  │ □ Screenshot evidence (before/after, multiple pages)        │ │
│  │ □ Monitor error logs (browser console)                      │ │
│  │ □ Monitor store: Can users checkout? Browse products?       │ │
│  │                                                              │ │
│  │ Timeline: 15-30 minutes typical (depends on story)           │ │
│  │                                                              │ │
│  │ DELIVERABLE: Production validation report                   │ │
│  │ (screenshots, test results, any issues found)               │ │
│  └─────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  STEP 6: USER DECISION GATE ⛔ (VOCÊ — Crítica)                   │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │ PAUSA AQUI — Você decide baseado em validação REAL          │ │
│  │                                                              │ │
│  │ Você viu:                                                   │ │
│  │ ✅ Loja funcionando em produção (real users)                │ │
│  │ ✅ Alterações implementadas corretamente                    │ │
│  │ ✅ Zero console errors                                      │ │
│  │ ✅ Checkout funcionando                                     │ │
│  │ ✅ No visual regressions                                    │ │
│  │                                                              │ │
│  │ VOCÊ DECIDE:                                                │ │
│  │ ✅ APPROVE ("Confirma? Manter em produção")                 │ │
│  │    → Cache será limpo, alterações finalizadas               │ │
│  │    → Story = DONE                                           │ │
│  │                                                              │ │
│  │ ❌ REJECT ("Há problema. Voltar à versão anterior")        │ │
│  │    → Rollback automático (backup incremental)               │ │
│  │    → Orion ajusta + redeploy                                │ │
│  │    → Volta para validação em produção                       │ │
│  │                                                              │ │
│  │ ⏸️  HOLD ("Precisamos de mais tempo para testar")           │ │
│  │    → Story permanece em produção (pode haver cache)         │ │
│  │    → Aguarda sua decisão posterior                          │ │
│  │                                                              │ │
│  │ ❓ QUESTIONS ("Como funciona X? Teste Y.")                  │ │
│  │    → Orion testa e responde                                 │ │
│  │    → Volta para validação em produção                       │ │
│  │                                                              │ │
│  │ ⚠️  CRITICAL: Files are live (production). Decide quickly    │ │
│  │          (ideally within 1-2 hours)                         │ │
│  └─────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  STEP 7A: APPROVE → FINALIZE (Orion — se aprovado)               │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │ ✅ USER APPROVED                                             │ │
│  │                                                              │ │
│  │ □ Clear cache/bust version (Story 1.2 system)               │ │
│  │ □ Verify users see new version (refresh without cache)      │ │
│  │ □ Take production screenshot (final state)                  │ │
│  │ □ Merge PR to main (if not already merged)                  │ │
│  │ □ Update PROGRESS-TRACKER.md (Story = DONE) ✅               │ │
│  │ □ Document final state + metrics                            │ │
│  │ □ Delete backup (or archive after 7 days)                   │ │
│  │                                                              │ │
│  │ DELIVERABLE: Story complete in production ✅                 │ │
│  │ SAFETY: Backup retained for 7 days (can still rollback)      │ │
│  └─────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  STEP 7B: REJECT → ROLLBACK (Orion — se rejeitado)               │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │ ❌ USER REJECTED / Found problem                             │ │
│  │                                                              │ │
│  │ □ Execute rollback script (< 2 minutes)                     │ │
│  │ □ Restore files from incremental backup                     │ │
│  │ □ Clear cache (back to previous version)                    │ │
│  │ □ Verify production restored (screenshots)                  │ │
│  │ □ Confirm users see previous version                        │ │
│  │ □ Document rollback reason                                  │ │
│  │ □ Get feedback: "O que não funcionou?"                      │ │
│  │                                                              │ │
│  │ □ Make adjustments to code locally                          │ │
│  │ □ Test locally again (thoroughly)                           │ │
│  │ □ Re-deploy to production (new backup + deploy)             │ │
│  │ □ Back to STEP 5 (production validation again)              │ │
│  │                                                              │ │
│  │ MAX 2 ITERATIONS (then escalate for bigger fixes)           │ │
│  │                                                              │ │
│  │ DELIVERABLE: Production restored to safe state              │ │
│  │ SAFETY: Zero data loss, users unaffected                    │ │
│  └─────────────────────────────────────────────────────────────┘ │
│                                                                   │
│  STEP 8: MONITORING (Orion — Post-approval)                      │
│  ┌─────────────────────────────────────────────────────────────┐ │
│  │ □ Monitor production for 1-2 hours after approval           │ │
│  │ □ Watch browser console (any errors?)                       │ │
│  │ □ Monitor error logs (server errors?)                       │ │
│  │ □ Check user traffic (normal patterns?)                     │ │
│  │ □ Spot check 5-10 random users (report issues?)             │ │
│  │                                                              │ │
│  │ IF issue found during monitoring:                           │ │
│  │ → Notify you immediately                                    │ │
│  │ → Execute rollback                                          │ │
│  │ → Repeat adjustment cycle                                   │ │
│  │                                                              │ │
│  │ DELIVERABLE: Production stable ✅                            │ │
│  └─────────────────────────────────────────────────────────────┘ │
│                                                                   │
└──────────────────────────────────────────────────────────────────┘
```

---

## 🔄 TIMELINE PER STORY

```
STORY EXECUTION TIMELINE (Example: Story 1.1.1 — 2-4 hours effort)

DAY 1 (Sexta):
  09:00 - 13:00  DEVELOPMENT (Orion autônomo, 4 horas)
    └─ Code implement + local testing + PR creation
  14:00  CODE REVIEW (2+ team members)
    └─ PR approved ✅

DAY 2 (Sábado):
  10:00          BACKUP + DEPLOY (Orion autônomo, 15 min)
    └─ Incremental backup created
    └─ Files deployed to FTP
    └─ Production ready for validation

  10:15 - 11:30  PRODUCTION VALIDATION (YOU)
    └─ Test on 4 browsers
    └─ Verify all features work
    └─ Screenshots of validation

  11:30          DECISION GATE (You decide)
    ✅ APPROVE  → Story DONE (cache clear, finalized)
    ❌ REJECT   → Rollback, adjust, re-deploy (next 2 hours)
    ⏸️ HOLD     → Keep testing, decide later

  12:00 - 14:00  MONITORING (if approved)
    └─ Orion monitors production
    └─ User traffic normal
    └─ No errors in logs

TOTAL TIME: 24-30 hours calendar (1.5 days actual work)
USER TIME: 1-2 hours for production validation + decision
```

---

## 📊 COMMUNICATION — DAILY STATUS + APPROVAL GATE

### FORMAT 1: DAILY STATUS (Conciso)

```
═══════════════════════════════════════════════════════════
📅 DAILY STATUS — 2026-03-24 — Sprint 1.1
═══════════════════════════════════════════════════════════

🎯 TODAY'S PROGRESS:
  Story 1.1.1 (Focus Indicators):
    ✅ Development complete (3.2h actual)
    ✅ Local testing: 4 browsers PASS
    ✅ Code review: 2 approvals ✅
    ⏳ Creating incremental backup
    ⏳ Will deploy to FTP this afternoon

📊 FILES READY:
  • /theme/css/accessibility.css (NEW, 2.1 KB)
  • /theme/layouts/layout.tpl (MODIFIED, link added)
  • Total impact: 2 files, 2.5 KB

🎯 NEXT:
  • Complete backup (10 min)
  • Deploy to FTP (5 min)
  • AWAIT YOUR PRODUCTION VALIDATION (tomorrow ~10-15 min)
  • You'll test in live store, approve/reject

📌 YOUR ACTION:
  Tomorrow morning: Test story 1.1.1 in production
  Link: patagang.nuvemshop.com.br (your live store)
  Test: Tab through buttons/inputs → Should see #FF6B35 outline
  Decision: Approve / Reject / Hold / Questions

═══════════════════════════════════════════════════════════
```

### FORMAT 2: APPROVAL GATE — Production Ready

```
╔════════════════════════════════════════════════════════════╗
║        PRODUCTION DEPLOYMENT READY — AWAITING YOUR TEST    ║
║                                                            ║
║  Story ID: TDB-2026-001.1.1                                ║
║  Title: Implement Focus Indicators                         ║
║  Status: ✅ DEPLOYED TO PRODUCTION FTP                     ║
╚════════════════════════════════════════════════════════════╝

┌────────────────────────────────────────────────────────────┐
│ DEPLOYMENT DETAILS                                         │
├────────────────────────────────────────────────────────────┤
│                                                            │
│ Deployment Time: 2026-03-24 14:32 UTC                      │
│ Files Deployed: 2                                          │
│   • /theme/css/accessibility.css (NEW)                     │
│   • /theme/layouts/layout.tpl (LINK UPDATED)               │
│ Total Size: 2.5 KB                                         │
│ Backup Location: backup/001.1.1/2026-03-24-14-30/          │
│ Rollback Time: < 2 minutes (tested)                        │
│                                                            │
│ ⚠️  NOTE: Files deployed but users may see cached version  │
│         Hard refresh (Ctrl+Shift+R) shows new version      │
│         Cache will be cleared after your approval          │
│                                                            │
└────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────┐
│ HOW TO VALIDATE IN PRODUCTION                              │
├────────────────────────────────────────────────────────────┤
│                                                            │
│ STEP-BY-STEP TESTING:                                      │
│                                                            │
│ 1. Open your live store: patagang.nuvemshop.com.br         │
│                                                            │
│ 2. Hard refresh (bypass cache):                            │
│    Windows: Ctrl + Shift + R                               │
│    Mac: Cmd + Shift + R                                    │
│                                                            │
│ 3. Test on 4 browsers (if possible):                       │
│    Chrome → Tab through buttons → See #FF6B35 outline?     │
│    Firefox → Same test                                     │
│    Safari → Same test                                      │
│    Edge → Same test                                        │
│                                                            │
│ 4. Mobile test:                                            │
│    iPhone Safari → Hard refresh → Tab navigation visible?  │
│    Android Chrome → Hard refresh → Tab navigation visible? │
│                                                            │
│ 5. Checkout flow:                                          │
│    Can still add products? Yes ✅                           │
│    Can still checkout? Yes ✅                               │
│    No new errors? Yes ✅                                    │
│                                                            │
│ 6. Screenshots:                                            │
│    Take screenshot with focus on button (see outline)      │
│    Take screenshot with focus on input field               │
│    Take screenshot of checkout (confirm working)           │
│                                                            │
│ Expected Result:                                           │
│ ✅ When you Tab through page elements, clear #FF6B35       │
│    outline appears around buttons/inputs/links             │
│ ✅ Outline is 2px wide, 2px from element                   │
│ ✅ Store functionality unchanged                           │
│                                                            │
└────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────┐
│ ROLLBACK PROCEDURE (If issues found)                       │
├────────────────────────────────────────────────────────────┤
│                                                            │
│ IF YOU FIND PROBLEM:                                       │
│ Simply tell me: "Story 1.1.1 has issue with X"             │
│                                                            │
│ Orion will IMMEDIATELY:                                    │
│ 1. Execute rollback script (< 2 min)                       │
│ 2. Restore from backup                                     │
│ 3. Clear cache                                             │
│ 4. Users see previous version again                        │
│                                                            │
│ ZERO DATA LOSS — Story reverts as if never deployed        │
│                                                            │
│ Then Orion:                                                │
│ 1. Gets your feedback                                      │
│ 2. Fixes issue locally                                     │
│ 3. Re-deploys to production                                │
│ 4. You test again                                          │
│                                                            │
│ (Up to 2 iterations allowed)                               │
│                                                            │
└────────────────────────────────────────────────────────────┘

┌────────────────────────────────────────────────────────────┐
│ YOUR DECISION (After testing)                              │
├────────────────────────────────────────────────────────────┤
│                                                            │
│ PLEASE CHOOSE:                                             │
│                                                            │
│ ✅ APPROVE                                                 │
│    "Everything works! Keep in production"                  │
│    → Orion clears cache, finalizes story, moves to next    │
│                                                            │
│ ❌ REJECT                                                  │
│    "There's a problem: [describe]"                         │
│    → Orion rollbacks, fixes, re-deploys                    │
│                                                            │
│ ⏸️  HOLD                                                   │
│    "Need more time to test"                                │
│    → Story stays in production, you test more              │
│    → Come back with approval/rejection later               │
│                                                            │
│ ❓ QUESTIONS                                                │
│    "What if... Can you test... How does...?"               │
│    → Orion answers and tests, comes back with results      │
│                                                            │
├────────────────────────────────────────────────────────────┤
│                                                            │
│ WAITING FOR YOUR RESPONSE:                                 │
│ "Story 1.1.1: ✅ APPROVE / ❌ REJECT / ⏸️ HOLD / ❓ ?"     │
│                                                            │
└────────────────────────────────────────────────────────────┘

═══════════════════════════════════════════════════════════════
Orion — APPROVAL GATE (PRODUCTION READY)
Data: 2026-03-24 14:30
Aguardando sua validação em produção e decisão...
═══════════════════════════════════════════════════════════════
```

---

## ✅ NOVO WORKFLOW CONFIRMADO

```
╔════════════════════════════════════════════════════════════╗
║         EXECUTION WORKFLOW — NUVEMSHOP FTP REAL            ║
╠════════════════════════════════════════════════════════════╣
║                                                            ║
║  STEP 1: Development (Orion — autônomo)                    ║
║  STEP 2: Identify files (Orion — autônomo)                 ║
║  STEP 3: Create backup incremental (Orion — autônomo)      ║
║  STEP 4: Deploy to FTP produção (Orion — autônomo)         ║
║  STEP 5: Você testa na loja ATIVA/produção (YOU)           ║
║  STEP 6: Você aprova/rejeita/hold (YOU)                    ║
║  STEP 7: Finalize ou Rollback (Orion — baseado sua decisão)║
║  STEP 8: Monitor produção (Orion — 1-2 horas)              ║
║                                                            ║
║  SAFETY: Rollback < 2 min, zero data loss                  ║
║  TIMING: 1-2 horas por story (1h trabalho, 1h você testa) ║
║  FILES: Backup incremental mantido por 7 dias              ║
║                                                            ║
╚════════════════════════════════════════════════════════════╝
```

---

## 🎯 **PRONTO PARA COMEÇAR COM ESSE WORKFLOW REAL?**

Confirmando:

```
✅ NOVO WORKFLOW ENTENDIDO:
   1. Dev + local test (Orion autônomo)
   2. Create incremental backup (Orion autônomo)
   3. Deploy real FTP produção (Orion autônomo)
   4. VOCÊ valida na loja ATIVA em produção
   5. VOCÊ aprova/rejeita/hold
   6. Orion finaliza ou faz rollback baseado sua decisão
   7. Orion monitora

✅ COMMUNICATION PADRÃO:
   • Daily status conciso (quando há progresso)
   • Approval gate com instruções para testar em produção
   • Ready quando você der seu voto ✅/❌/⏸️

✅ SAFETY:
   • Backup incremental ANTES de cada deploy
   • Rollback < 2 minutes anytime
   • Zero data loss guaranteed
   • Files restored from backup instantly

PRONTO PARA COMEÇAR WEEK 0 COM ESSE WORKFLOW REAL?
```

— Orion, alinhado com a realidade Nuvemshop FTP 🎯
# Nuvemshop Production Safety Matrix

**Risk Assessment & Mitigation for Live Store (in production)**
**CRITICAL: Loja em produção = vendas impactadas por qualquer erro**

---

## Executive Summary

**Risk Level:** MEDIUM (manageable with proper safeguards)
**Key Constraint:** No automatic rollback (FTP manual only)
**Critical Window:** Peak hours = higher impact
**Recommendation:** Deploy during low-traffic windows

---

## Production Deployment Risk Matrix

### Critical Risks for Live Store

| Risk | Probability | Impact | Mitigation | Owner |
|------|-------------|--------|-----------|-------|
| CSS changes don't appear | Medium | Medium | Cache-buster strategy | Dev |
| JavaScript error breaks checkout | Low | Critical | Unit tests (SYS-7) + E2E tests (FE-12) | QA |
| Template change breaks product page | Low | Critical | Template testing + rollback ready | Dev |
| Performance degradation | Low | High | Lighthouse audit + monitoring | DevOps |
| FTP upload fails mid-way | Very Low | Medium | Retry logic + backup restore | DevOps |
| Customer data exposed | Very Low | Critical | NO data changes (read-only) | Arch |

---

## Phase-by-Phase Risk Assessment

### PHASE 1: Critical Foundation (Weeks 1-2)

#### Debt: SYS-1 (CSS Caching)

**Production Risk:** MEDIUM
```
Change Type:    CSS infrastructure
Impact Area:    Theme styling
Customer Risk:  CSS may not update without manual intervention
Financial Risk: Lost sales if site looks broken
Recovery Time:  5-30 minutes
```

**Safeguards:**
- ✅ Test in staging first (1-2 hours)
- ✅ Cache-buster in place before deploy
- ✅ Backup created before deploy
- ✅ Rollback plan documented
- ✅ Support team alerted

**Deployment Window:**
- Monday-Friday 14:00-16:00 (low traffic)
- NOT on weekends or peak hours
- Monitor for 2 hours post-deploy

---

#### Debt: FE-4 (Focus Indicators)

**Production Risk:** LOW ✅
```
Change Type:    CSS addition (no removal)
Impact Area:    Keyboard navigation styling
Customer Risk:  None (backward compatible, improves UX)
Financial Risk: None (positive impact)
Recovery Time:  2 minutes (revert if needed)
```

**Safeguards:**
- ✅ Pure CSS addition
- ✅ No behavior changes
- ✅ No JavaScript impact
- ✅ Can deploy anytime

**Deployment Window:**
- Anytime (no risk window)
- Preferably business hours (monitoring)

---

#### Debt: SYS-7 (Unit Tests)

**Production Risk:** NONE ✅
```
Change Type:    Development infrastructure
Impact Area:    Local testing only
Customer Risk:  None (zero production changes)
Financial Risk:  None
Recovery Time:   N/A (not deployed)
```

**Safeguards:**
- ✅ Local-only infrastructure
- ✅ No code deployed to production
- ✅ Optional for developers

**Deployment Window:**
- N/A (not deployed to production)

---

#### Debt: FE-5 (Alt Text)

**Production Risk:** LOW ✅
```
Change Type:    HTML content (alt text)
Impact Area:    Image accessibility
Customer Risk:  None (improves SEO + accessibility)
Financial Risk: Positive (SEO benefit)
Recovery Time:  5 minutes (revert if needed)
```

**Safeguards:**
- ✅ Backward compatible
- ✅ Improves search visibility
- ✅ Can deploy anytime

**Deployment Window:**
- Anytime (positive change)

---

#### Debt: FE-1 (CSS Variables)

**Production Risk:** LOW ✅
```
Change Type:    CSS refactoring
Impact Area:    CSS compilation
Customer Risk:  Low (fallback for old browsers)
Financial Risk:  None
Recovery Time:   5 minutes (revert if needed)
```

**Safeguards:**
- ✅ CSS custom properties have fallback
- ✅ Visual regression tested
- ✅ No behavior changes
- ✅ IE 11: fallback works (rare visitors)

**Deployment Window:**
- Business hours (monitor)
- Low-traffic time preferred

---

#### Debt: FE-6, FE-7, FE-13, FE-3 (Accessibility/CSS)

**Production Risk:** LOW ✅
```
Change Type:    HTML + CSS improvements
Impact Area:    Form accessibility, styling
Customer Risk:  None (backward compatible)
Financial Risk: Positive (better UX)
Recovery Time:  5 minutes each
```

**Safeguards:**
- ✅ All backward compatible
- ✅ Improve user experience
- ✅ Can deploy together

**Deployment Window:**
- Business hours
- After each other (grouped deployment)

---

### PHASE 2: Architecture (Weeks 3-4)

#### Debt: FE-2 (Component Library)

**Production Risk:** NONE ✅
```
Change Type:    Documentation (Storybook)
Impact Area:    Developer reference only
Customer Risk:  None (not deployed to production)
Financial Risk: None
Recovery Time:  N/A
```

**Deployment Window:**
- N/A (GitHub Pages deployment only)

---

#### Debt: FE-12 (E2E Tests)

**Production Risk:** NONE ✅
```
Change Type:    Testing infrastructure
Impact Area:    CI/CD only (read-only)
Customer Risk:  None (verification only)
Financial Risk: None
Recovery Time:  N/A
```

**Deployment Window:**
- N/A (CI/CD environment only)

---

#### Debt: SYS-2 (Build Pipeline)

**Production Risk:** MEDIUM
```
Change Type:    Build process change
Impact Area:    CSS/JS minification
Customer Risk:  Medium (if minified files break)
Financial Risk: High (site partially broken)
Recovery Time:  10 minutes (redeploy old files)
```

**Critical Safeguards:**
- ✅ Test minified files in staging (2+ hours)
- ✅ Visual regression testing (Percy)
- ✅ E2E tests on minified code
- ✅ Lighthouse audit passing
- ✅ Incremental rollout:
  - Stage 1: CSS minification only
  - Stage 2: JavaScript minification only
  - Stage 3: Combined (if stages 1-2 OK)

**Deployment Window:**
- Tuesday-Thursday 14:00-16:00 (medium traffic)
- NOT on Monday (team catch-up)
- NOT on Friday (no support coverage)
- Monitor for 3+ hours

**Rollback Procedure:**
```
If minified files cause issues:
1. Immediate: Revert deployment
   git checkout <previous-commit>
   npm run deploy:production

2. Diagnosis: What broke?
   - CSS: Check source maps in DevTools
   - JS: Check browser console
   - Build: Check webpack output

3. Fix locally, test thoroughly, redeploy
```

---

#### Debt: SYS-3 (CI/CD Pipeline)

**Production Risk:** MEDIUM
```
Change Type:    Deployment automation
Impact Area:    Deploy process
Customer Risk:  Medium (if automation breaks deploys)
Financial Risk: Medium (slower to fix issues)
Recovery Time:  15 minutes (manual fallback)
```

**Safeguards:**
- ✅ Manual approval gate required
- ✅ No automatic push (human reviews)
- ✅ Slack notifications on status
- ✅ Fallback to manual deploy script
- ✅ Dry-run successful before production

**Deployment Window:**
- Business hours (support available)
- After testing with 1+ manual deploys
- Test first deploy on staging

---

#### Debt: SYS-4 (Design System)

**Production Risk:** MEDIUM-HIGH
```
Change Type:    Component consolidation
Impact Area:    Template structure
Customer Risk:  High (consolidation can break pages)
Financial Risk: High (multiple pages affected)
Recovery Time:  20 minutes (restore backup)
```

**Critical Safeguards:**
- ✅ Phased approach (one component at a time)
- ✅ Old components stay during migration
- ✅ Heavy testing (visual + functional)
- ✅ Full backup before each migration
- ✅ Staging validation (2+ days per component)
- ✅ Incremental rollout by page type:
  - Week 1: Product cards
  - Week 2: Navigation
  - Week 3: Forms
  - Week 4: Remaining

**Deployment Window:**
- Tuesday-Thursday 10:00-12:00 (low traffic)
- 1 component per week
- Monitor 4+ hours per deploy

**Rollback Procedure:**
```
If consolidation breaks templates:
1. Immediate: Restore from backup
   npm run rollback [TIMESTAMP]

2. Keep old templates in place
3. Fix consolidation offline
4. Run full regression testing
5. Re-attempt with more testing
```

---

### PHASE 3: Optimization (Weeks 5-6)

#### Debt: FE-9 (Image Optimization)

**Production Risk:** LOW ✅
```
Change Type:    Image format upgrade (WebP)
Impact Area:    Image delivery
Customer Risk:  Low (fallback to JPG)
Financial Risk: Positive (faster load)
Recovery Time:  5 minutes
```

**Safeguards:**
- ✅ `<picture>` tag with fallback
- ✅ Browser support verified
- ✅ IE 11 falls back to JPG
- ✅ Lighthouse improvement verified

**Deployment Window:**
- Anytime (positive change)
- Preferably business hours (monitor)

---

#### Debt: FE-11 (Lighthouse 85+)

**Production Risk:** LOW ✅
```
Change Type:    Performance optimization
Impact Area:    Page load speed
Customer Risk:  None (faster = better)
Financial Risk: Positive (improved conversions)
Recovery Time:  N/A (improvements only)
```

**Safeguards:**
- ✅ Incremental optimizations
- ✅ Lighthouse tracked per change
- ✅ No removal of functionality
- ✅ Core Web Vitals monitored

**Deployment Window:**
- Anytime
- Preferably business hours

---

### PHASE 4: Polish (Weeks 7-8)

#### Debt: FE-8, FE-10, SYS-5, SYS-8

**Production Risk:** LOW ✅
```
Change Type:    Polish and minor improvements
Impact Area:    Minor UX/DX
Customer Risk:  None (enhancements only)
Financial Risk: Positive (better UX)
Recovery Time:  5 minutes
```

**Deployment Window:**
- Anytime (all low-risk)

---

## Pre-Production Deployment Checklist

### 48 Hours Before Deploy

```
Code Preparation:
  [ ] All changes committed and pushed to GitHub
  [ ] PR reviewed and approved
  [ ] All tests passing (lint, unit, E2E)
  [ ] Lighthouse score acceptable
  [ ] Accessibility audit passing

Team Coordination:
  [ ] Scheduled deploy time confirmed with team
  [ ] Support team notified (48h notice)
  [ ] On-call engineer confirmed
  [ ] Escalation contact available

Backup & Rollback:
  [ ] Backup script tested (backup-full-ftp.js)
  [ ] Rollback procedure documented in Slack
  [ ] Rollback tested in staging (dry run)

Staging Validation:
  [ ] Code deployed to staging Nuvemshop
  [ ] All tests passed on staging
  [ ] Manual testing completed (2+ hours)
  [ ] Mobile testing completed (iOS + Android)
  [ ] Payment flow tested (sandbox)
```

### 24 Hours Before Deploy

```
Final Verification:
  [ ] Staging still passing all tests
  [ ] No new commits since staging validation
  [ ] Performance stable
  [ ] No accessibility regressions
  [ ] Support team ready

Monitoring Setup:
  [ ] Error log monitoring ready
  [ ] Slack notifications configured
  [ ] Lighthouse CI setup
  [ ] Health check URL identified
```

### 1 Hour Before Deploy

```
Final Checks:
  [ ] git status clean
  [ ] All commits to main branch
  [ ] No pending changes
  [ ] Team ready (chat open, monitoring ready)

Risk Assessment:
  [ ] Confirmed low-traffic window
  [ ] No concurrent maintenance
  [ ] CDN cache behavior understood
  [ ] Rollback contact confirmed
```

### Deploy Time (30 minutes)

```
Before Push:
  [ ] Create full backup: npm run backup
  [ ] Announce in Slack: Deploy starting
  [ ] Start monitoring dashboard
  [ ] Check error logs (baseline)

During Deploy:
  [ ] npm run deploy:production
  [ ] Monitor FTP upload progress
  [ ] Wait for deployment completion
  [ ] Verify files on FTP (spot check)

Post-Deploy (immediately):
  [ ] Site loads successfully (homepage)
  [ ] No JavaScript errors (DevTools console)
  [ ] Images load correctly
  [ ] Styling applied correctly
  [ ] Mobile responsive
  [ ] Forms functional

Post-Deploy (15 minutes):
  [ ] Run Lighthouse audit
  [ ] Check error logs (compare baseline)
  [ ] Monitor support tickets
  [ ] Social media mentions (Twitter/Facebook)
  [ ] Customer complaints check

Post-Deploy (1 hour):
  [ ] Still stable? Great!
  [ ] Any issues appearing? Start rollback

Post-Deploy (2+ hours):
  [ ] Checkout flow tested (real transaction?)
  [ ] Search function working
  [ ] Filters functional
  [ ] All major pages tested
  [ ] Announce success in Slack
```

### Rollback Decision Tree

```
Is site broken?
├─ YES: Cart not working or JS errors blocking checkout
│  └─ ROLLBACK IMMEDIATELY (see below)
│
├─ MAYBE: CSS looks odd or slow
│  ├─ Wait 5-10 minutes (could be cache clearing)
│  ├─ Try hard refresh (Ctrl+Shift+R)
│  ├─ Still broken? ROLLBACK
│  └─ Working? Continue monitoring
│
└─ NO: Everything working fine
   └─ Continue monitoring for 2+ hours
```

### Emergency Rollback Procedure

```
⚠️ IF SITE IS DOWN OR CHECKOUT BROKEN:

IMMEDIATE (< 2 minutes):
1. Announce in Slack: "ROLLBACK IN PROGRESS"
2. Run rollback: npm run rollback [TIMESTAMP]
   (See ftp-deploy/rollback-incremental.js)
3. Clear cache: Dashboard → Settings → Clear Cache
4. Verify site works: Load homepage in incognito
5. Monitor error logs

VALIDATION (2-5 minutes):
[ ] Site loads
[ ] No JavaScript errors
[ ] Cart works
[ ] Checkout flows
[ ] Mobile works

POST-ROLLBACK (30+ minutes):
1. Document what happened
2. Root cause analysis
3. Fix issue offline
4. Test in staging again
5. Plan second attempt (different day if major)

COMMUNICATION:
- Announce successful rollback
- Estimated RTO (Time to Recovery)
- When will retry
- Investigation findings (if obvious)
```

---

## Monitoring During & After Deploy

### Real-Time Monitoring

```
Error Logs:
- Watch Nuvemshop dashboard
- Check for JavaScript errors
- Monitor 404s (missing files)
- Alert on 500 errors

Performance:
- Lighthouse score maintained?
- Load time increased?
- FCP/LCP worse?

User Impact:
- Support tickets spiking?
- Social media mentions?
- Cart abandonment up?
```

### 24-Hour Post-Deploy

```
Stability Check:
- [ ] No increased error rates
- [ ] Performance stable
- [ ] Support tickets normal
- [ ] Customer feedback positive

Metrics Baseline:
- [ ] Conversion rate (unchanged or up)
- [ ] Cart abandonment (unchanged or down)
- [ ] Average order value (unchanged or up)
- [ ] Load time (same or faster)
```

---

## Risk Mitigation by Deployment Type

### Low-Risk Deploys (CSS/HTML additions)
- **Time Required:** 5-10 minutes
- **Monitoring:** 30 minutes
- **Rollback Time:** 2 minutes
- **Deploy Window:** Flexible (anytime)
- **Approval:** Tech lead sign-off
- **Examples:** FE-4, FE-5, FE-6, FE-7, FE-13

### Medium-Risk Deploys (Build changes, CSS refactor)
- **Time Required:** 15-30 minutes
- **Monitoring:** 2+ hours
- **Rollback Time:** 10 minutes
- **Deploy Window:** Business hours, low-traffic
- **Approval:** QA + Tech lead + DevOps
- **Examples:** SYS-2, SYS-1, FE-11

### High-Risk Deploys (Template consolidation)
- **Time Required:** 20+ minutes
- **Monitoring:** 4+ hours
- **Rollback Time:** 15+ minutes
- **Deploy Window:** Scheduled, low-traffic
- **Approval:** Full team + stakeholders
- **Examples:** SYS-4, SYS-8
- **Strategy:** Phased rollout (1 component/week)

### No-Risk Deploys (Infrastructure/tests)
- **Time Required:** N/A (local only)
- **Monitoring:** N/A
- **Rollback Time:** N/A
- **Deploy Window:** Anytime
- **Approval:** Tech lead
- **Examples:** SYS-7, FE-2, FE-12, SYS-3 (CI setup)

---

## Nuvemshop-Specific Production Risks

### Risk 1: CSS Cache Doesn't Clear

**Symptom:** Deploy CSS change, but old CSS still showing
**Root Cause:** Nuvemshop server-side caching + browser cache
**Impact:** Customer sees broken styling
**Recovery Time:** 5-30 minutes

**Mitigation:**
- ✅ Implement cache-buster version ID
- ✅ Monitor for cache issues in first 10 minutes
- ✅ Have manual cache-clear procedure documented
- ✅ Educate support team on workaround (hard refresh)

**If Happens:**
```
1. Confirm issue: Load in incognito window
2. If still broken: Cache-buster not working
3. Use layout.tpl override with inline CSS
4. Alert support: "Tell customers: Ctrl+Shift+R"
5. Document for next deploy
```

---

### Risk 2: FTP Upload Interrupted

**Symptom:** Deploy starts but FTP connection lost mid-way
**Root Cause:** Network issue or timeout
**Impact:** Site may have partial files (broken state)
**Recovery Time:** 10 minutes (restore backup)

**Mitigation:**
- ✅ Use basic-ftp with retry logic
- ✅ Create backup before deploy
- ✅ Validate deploy completion
- ✅ Check critical files received

**If Happens:**
```
1. Check FTP connection status
2. If interrupted: Restore from backup
   npm run rollback [TIMESTAMP]
3. Wait 2 minutes, retry deploy
4. Monitor carefully second time
```

---

### Risk 3: Nuvemshop API Rate Limit

**Symptom:** Deployment script times out waiting for API
**Root Cause:** Too many theme updates in short time
**Impact:** Deploy doesn't complete
**Recovery Time:** 5 minutes (wait + retry)

**Mitigation:**
- ✅ Don't deploy too frequently (1-2x per day max)
- ✅ Wait 5 minutes between deploys
- ✅ Use exponential backoff in retry logic

**If Happens:**
```
1. Wait 5 minutes
2. Retry deployment
3. If still failing: Contact Nuvemshop support
4. Consider deploying later
```

---

### Risk 4: Template Variable Undefined

**Symptom:** Product pages show blank or error
**Root Cause:** Liquid template references unavailable variable
**Impact:** Product pages broken
**Recovery Time:** 15 minutes (rollback)

**Mitigation:**
- ✅ Test in staging (with real products)
- ✅ Verify Nuvemshop variable availability
- ✅ Use fallback filters in Liquid
- ✅ E2E tests verify page rendering

**If Happens:**
```
1. Identify broken template
2. Rollback: npm run rollback [TIMESTAMP]
3. Fix template locally
4. Add E2E test to catch next time
5. Redeploy
```

---

## Production Support Emergency Contacts

```
On-Call Engineer:
- Name: [Name]
- Phone: [Phone]
- Slack: @[handle]
- Available: 24/7 for critical issues

Tech Lead:
- Name: [Name]
- Phone: [Phone]
- Slack: @[handle]
- Available: Business hours + on-call schedule

Support Manager:
- Name: [Name]
- Slack: @[handle]
- Available: Business hours

Escalation Path:
1. On-call engineer (immediate)
2. Tech lead (10 min response)
3. Nuvemshop support (if platform issue)
```

---

## Post-Deploy Follow-Up

### Day 1 Post-Deploy
```
[ ] Monitor error logs all day
[ ] Check Lighthouse scores
[ ] Customer feedback review
[ ] Team debrief (if any issues)
```

### 1 Week Post-Deploy
```
[ ] Verify no regressions
[ ] Check conversion metrics stable
[ ] Performance metrics stable
[ ] Support ticket volume normal
```

---

## Communication Templates

### Pre-Deploy Announcement
```
🚀 DEPLOY SCHEDULED

Timing: [Date] [Time] (30 min window)
Changes: [Brief summary of what's being deployed]
Risk Level: [Low/Medium/High]
Rollback: Possible (< 10 min)

Impact: [Users may see brief moment of old/new styling]
Support: Please monitor chat during deployment

---
Deployed by: @[Name]
Questions? Ask in #tech-deployments
```

### Post-Deploy Success
```
✅ DEPLOYMENT SUCCESSFUL

Completed: [Time]
Changes Live: Yes
Monitoring: All systems green
Status: Stable

Metrics:
- Lighthouse: [Score]
- Error Rate: [%]
- Load Time: [ms]

Next: Monitoring for 2+ hours
Questions? Ask in #tech-deployments
```

### Rollback Announcement
```
⏮️ ROLLBACK IN PROGRESS

Issue: [What was broken]
Status: Rolling back to previous version
ETA: 10 minutes to resolution

You may see:
- Brief styling changes
- Page refresh
- Brief loading message

Impact: Minimal (rolling back non-critical changes)
Support: Standing by

---
Rolled back by: @[Name]
Will retry: [When, after investigation]
```

---

## Document Control

| Field | Value |
|-------|-------|
| **Created** | 2026-03-15 |
| **Purpose** | Production safety during implementation |
| **Audience** | Developers, DevOps, Tech Leads, Support |
| **Status** | ACTIVE - Use for ALL production deploys |
| **Review** | Monthly risk assessment |

---

**Remember:** Production store = real money = real customers = real risk.
Test thoroughly. Rollback quickly. Communicate clearly.


# 🔍 ARCHITECTURE REVIEW: Nuvemshop Context & Agent Integration
## AIOX 10/10 Compliance Analysis

**Date:** 2026-03-20
**Reviewer:** Orion (@aiox-master)
**Status:** 6 CRITICAL ISSUES FOUND + REFACTORING REQUIRED
**Severity:** Architecture Debt (must fix before production use)

---

## EXECUTIVE SUMMARY

Current implementation has **solid domain knowledge** (constraints are accurate) but **poor agent integration** and **unclear advisory vs blocking semantics**. The rule is written for **humans**, not for **AI agents**.

**Key Issues:**
1. ❌ Rule uses imperative language ("Do NOT") but is actually advisory (non-blocking)
2. ❌ Nuvemshop constraints mixed with project guidelines (no separation)
3. ❌ Context not structured for agent consumption (no machine-readable metadata)
4. ❌ Override mechanism not formalized (unclear escalation path)
5. ❌ "Severity: CRITICAL" misleading (sounds like blocking, is actually advisory)
6. ❌ No agent-specific instructions (each agent needs different context)

**Overall Assessment:** **Architecture needs refactoring before production** (60% ready → 100% with fixes)

---

## ISSUE #1: Imperative Language vs Advisory Semantics ⚠️

### Problem

**Current (WRONG):**
```markdown
**Rule:** Do NOT modify checkout page structure, form fields, or layout.
```

**Issue:**
- "Do NOT" is imperative → suggests BLOCKING
- But implementation is advisory (no auto-block)
- Creates cognitive dissonance: "Don't do X" but system allows X
- Agent @dev reads this and gets confused: "Is this blocking or not?"

### Correct AIOX 10/10 Pattern

Advisory rules should use:
```markdown
**Guidance:** Avoid modifying checkout page structure without @architect review.
**Rationale:** Nuvemshop platform handles checkout backend. Structural changes risk breaking payment processing.
**Severity Level:** CRITICAL PLATFORM CONSTRAINT (cannot be violated, escalate to @architect)
```

**Key Distinction:**
- "Do NOT" = Blocking, will fail at enforcement gate
- "Avoid" + rationale = Advisory, contextual, agent-guided
- "Severity Level" = Impact if violated (separate from enforcement mode)

### Fix Required

Replace all imperative "Do NOT" with advisory "Avoid" or "Guidelines"

---

## ISSUE #2: No Separation of Concerns ⚠️

### Problem

**Current:**
```markdown
## About This Rule

You are editing **Nuvemshop FTP theme files**. This rule enforces critical
constraints documented in `NUVEMSHOP_FTP_STANDARDS.md`...
```

**Mixed Layers:**
- Nuvemshop official constraints (immutable)
- Patagang project guidelines (mutable)
- Developer best practices (context-dependent)

**No clear indication of:**
- What's a Nuvemshop hard limit vs Patagang preference
- What can be overridden vs what cannot
- What's technical vs what's organizational

### AIOX 10/10 Pattern

```markdown
## PLATFORM CONSTRAINTS (Nuvemshop - Immutable)

These are official Nuvemshop platform restrictions. Cannot be overridden.
Source: https://atendimento.nuvemshop.com.br/pt_BR/codigo-fonte-ftp/...

- ❌ Checkout structure modifications
- ❌ Footer attribution removal
- ❌ Form field backend integration changes

## PROJECT GUIDELINES (Patagang - Mutable)

These are Patagang best practices. Can be modified with @architect approval.

- 🟡 Performance budget (CSS < 50KB) — Can be increased if necessary
- 🟡 JavaScript scoping patterns — Can use alternatives if justified

## AGENT DECISION FRAMEWORK

For @dev:
- Platform constraints → MUST comply, escalate to @architect if unclear
- Project guidelines → Follow unless justified override
- Best practices → Use if applicable, modify if better solution exists
```

### Fix Required

Separate constraints into 2 sections with explicit mutability levels

---

## ISSUE #3: Context Not Structured for Agent Consumption ⚠️

### Problem

**Current:**
```markdown
**Trigger Pattern:**
```
File: **/checkout.tpl OR
Content:
  - Form field removals: <input removed from form context
  - Form reordering: form element position changed
```

**Issues:**
- Written for human readers (natural language descriptions)
- No machine-readable metadata
- Each agent (@dev, @qa, @devops) needs DIFFERENT context
- No agent-specific decision trees
- No structured data for automation

### AIOX 10/10 Pattern

```yaml
# AGENT-CONSUMABLE METADATA

constraint:
  id: "nuvemshop_checkout_structure"
  platform: "nuvemshop"

  platform_source:
    title: "Checkout Structure Lock"
    url: "https://atendimento.nuvemshop.com.br/pt_BR/codigo-fonte-ftp/..."
    excerpt: "Checkout is handled by platform backend"

  enforcement:
    level: "CRITICAL_PLATFORM_CONSTRAINT"
    can_override: false
    escalation_agent: "@architect"

  agent_instructions:
    "@dev":
      mode: "ADVISORY"
      action: "Warn if checkout structure changes detected. Suggest reverting."
      escalation: "If override needed, request @architect approval with justification"

    "@qa":
      mode: "VERIFY"
      checklist_items:
        - "Checkout form structure unchanged from baseline"
        - "Only colors/fonts modified, not structure"
        - "No form field additions/removals"

    "@devops":
      mode: "VALIDATE"
      post_deploy_checks:
        - "Checkout loads without errors"
        - "Payment form renders correctly"
        - "Test transaction completes"

  patterns:
    violation_indicators:
      - pattern: '<\/form>[\s\S]*?<form'
        severity: "CRITICAL"
        message: "Checkout form structure may have been modified"
      - pattern: '<!--\s*removed.*?field'
        severity: "CRITICAL"
        message: "Form field appears to have been removed"

  remediation:
    steps:
      - "git checkout -- theme-deploy-corrigido/layouts/checkout.tpl"
      - "Review changes: git diff HEAD"
      - "If override needed: @architect review"
    recovery_time_minutes: 5
```

### Fix Required

Restructure constraints as YAML/JSON with agent-specific instructions

---

## ISSUE #4: Override Mechanism Not Formalized ⚠️

### Problem

**Current:**
```markdown
**Violation Fix:**
- Undo checkout structural changes
- Revert to `checkout.tpl` from version control
- Ask @architect if styling-only changes needed
```

**Issues:**
- "Ask @architect if" is vague, not a process
- No formal override approval workflow
- No documentation/audit trail
- No escalation SLA or criteria
- Agent doesn't know: "When can I override?" "How do I request?" "Who has authority?"

### AIOX 10/10 Pattern

```markdown
## OVERRIDE PROCEDURE (Formal Escalation)

### When Override Is Possible

**Platform Constraints (CANNOT override):**
- Checkout structure modifications
- Footer attribution removal
- Form field backend changes

**Severity: CRITICAL** — Overrides not permitted. Violate Nuvemshop TOS.

---

**Project Guidelines (CAN override):**
- Performance budget (CSS < 50KB)
- JavaScript patterns (IIFE scoping)
- Cache clearing procedures

**Severity: HIGH/MEDIUM** — Overrides permitted with justification.

### Override Request Process

**Step 1: Document Justification**
```
// @architect-override-request
// Reason: [specific business reason]
// Constraint: [which constraint]
// Risk assessment: [what could go wrong]
// Mitigation: [how will we prevent issues]
```

**Step 2: Request Review**
- Commit with `// @architect-review` flag
- @architect reviews in PR
- Decision: APPROVED / NEEDS_DISCUSSION / REJECTED

**Step 3: Approval & Documentation**
- Approval comment in PR
- Record decision in CHANGELOG
- Ensure @qa tests extra thoroughly

**Step 4: Implementation & Monitoring**
- Proceed with override
- Enhanced QA testing
- Monitor for issues in first week
```

### Fix Required

Add formal "Override Procedure" section with decision tree

---

## ISSUE #5: Misleading "Severity" Field ⚠️

### Problem

**Current:**
```markdown
**Rule Type:** Contextual Auto-Load
**Severity:** CRITICAL
```

**Issue:**
- In AIOX, "Severity" typically means "blocking/enforcement level"
- This rule is **advisory** (not blocking), but marked **CRITICAL**
- Agent @dev reads "CRITICAL" and thinks "this will block my commit"
- But it doesn't! Causes confusion and trust loss

### Correct AIOX 10/10 Semantics

```markdown
**Rule Type:** Contextual Auto-Load
**Enforcement Mode:** ADVISORY (non-blocking, context-providing)
**Guidance Level:** CRITICAL (severe consequences if violated)
**Escalation Authority:** @architect
```

**Semantics:**
- Enforcement Mode: How the system responds (BLOCKING vs ADVISORY)
- Guidance Level: How important it is (CRITICAL vs HIGH vs MEDIUM)
- These are INDEPENDENT (can be ADVISORY + CRITICAL)

### Fix Required

Rename "Severity: CRITICAL" to "Guidance Level: CRITICAL, Enforcement Mode: ADVISORY"

---

## ISSUE #6: No Agent-Specific Instructions ⚠️

### Problem

**Current:**
- Single rule document for all agents
- No differentiation between @dev, @qa, @devops roles
- Each agent has different responsibilities but gets same context
- Agents forced to extract their own responsibilities

**Example - How each agent should use this context:**

**@dev (Implementation):**
- Should see: "Guidelines for what to avoid"
- Needs: "How to revert if I make a mistake"
- Action: "Keep this in mind while coding"

**@qa (Quality Gate):**
- Should see: "Specific checklist items to verify"
- Needs: "How to identify violations"
- Action: "Use this checklist during review"

**@devops (Deployment):**
- Should see: "Post-deployment validation"
- Needs: "What to test after deployment"
- Action: "Run these tests after FTP sync"

### AIOX 10/10 Pattern

```markdown
## AGENT-SPECIFIC INSTRUCTIONS

### For @dev (Implementation)

**When you edit theme files:**
1. Be aware of Nuvemshop constraints (section above)
2. Focus on: Colors, fonts, spacing, layout improvements
3. Avoid without justification: Structural changes to checkout/forms
4. If you need to change restricted areas: Describe use case to @architect first

**How this guide helps:**
- Review constraint examples before and after editing
- If Claude warns you of violation: Check "Violation Fix" section
- If you want to override: Follow "Override Procedure" section

---

### For @qa (Quality Review)

**When reviewing for FTP deployment:**
1. Use the Checklist: `.aiox-core/development/checklists/nuvemshop-ftp-constraints.md`
2. Verify each constraint in "CONSTRAINT PATTERNS" section
3. Ask developer: "Is this change within allowed scope?"
4. If violation found:
   - If CRITICAL platform constraint → REJECT (no override)
   - If project guideline → Request justification
5. Sign off only after all checks pass

**Reference this rule for:**
- What to look for (patterns section)
- How to explain violations to developers
- Escalation path if unclear

---

### For @devops (Deployment)

**After FTP deployment:**
1. Run post-deployment validation (Gate 4)
2. Test specific constraints affected by changes
3. Monitor for issues in first 24 hours
4. If violation emerges: Follow recovery procedure

**Reference this rule for:**
- Post-deployment test cases
- Recovery procedures (if something breaks)
- Rollback decision criteria
```

### Fix Required

Add "AGENT-SPECIFIC INSTRUCTIONS" section for each key agent

---

## ARCHITECTURE COMPARISON: CURRENT vs AIOX 10/10 COMPLIANT

| Aspect | Current ❌ | AIOX 10/10 ✅ |
|--------|-----------|--------------|
| **Semantics Clarity** | "Severity: CRITICAL" (confusing) | "Guidance: CRITICAL, Mode: ADVISORY" (clear) |
| **Constraint Separation** | Mixed (Nuvemshop + Patagang) | Separate sections with mutability levels |
| **Agent Awareness** | Generic (all agents same view) | Agent-specific instructions for @dev, @qa, @devops |
| **Override Process** | Vague ("ask @architect") | Formal procedure with approval workflow |
| **Machine Readability** | Natural language only | Structured YAML/JSON metadata |
| **Automation Support** | Manual pattern matching | Patterns in structured registry |
| **Decision Framework** | Implicit | Explicit decision trees per agent |
| **Escalation Path** | Unclear | Defined authority & SLA |

---

## REFACTORING ROADMAP

### Phase 1: Fix Semantics (1 hour)
- [ ] Rename "Severity" → "Enforcement Mode + Guidance Level"
- [ ] Change "Do NOT" → "Avoid"/"Guidelines"
- [ ] Add "ADVISORY (non-blocking)" notice at top

### Phase 2: Separate Concerns (2 hours)
- [ ] Create "PLATFORM CONSTRAINTS" section (immutable)
- [ ] Create "PROJECT GUIDELINES" section (mutable)
- [ ] Add mutability indicators to each constraint

### Phase 3: Agent Integration (3 hours)
- [ ] Add "AGENT-SPECIFIC INSTRUCTIONS" for @dev, @qa, @devops
- [ ] Create decision trees for each agent
- [ ] Add agent-readable metadata section

### Phase 4: Formalize Overrides (1 hour)
- [ ] Add "OVERRIDE PROCEDURE" section
- [ ] Document approval workflow
- [ ] Create override request template

### Phase 5: Automation Support (2 hours)
- [ ] Convert patterns to structured YAML
- [ ] Add machine-readable constraint metadata
- [ ] Document integration with validation script

**Total Effort:** ~9 hours
**Priority:** HIGH (must complete before production)

---

## CURRENT STATE vs PRODUCTION READINESS

| Criterion | Score | Status | Impact |
|-----------|-------|--------|--------|
| **Domain Knowledge** | 95% | ✅ GOOD | Constraints accurate |
| **Agent Integration** | 40% | ❌ POOR | Agents confused about usage |
| **Semantics Clarity** | 30% | ❌ POOR | Conflicting signals |
| **Override Support** | 20% | ❌ POOR | No formal escalation |
| **Automation Support** | 50% | ⚠️ PARTIAL | Patterns work, but not agent-aware |
| **Human Usability** | 70% | ⚠️ OK | Developers understand, but not agents |
| **AIOX 10/10 Compliance** | 45% | ❌ FAIL | Needs refactoring |

**Production Readiness: 40% → Target 90% after refactoring**

---

## ACTIONABLE RECOMMENDATIONS

### MUST DO (Blocking)
1. **Fix semantics:** Separate "Enforcement Mode" from "Guidance Level"
2. **Add agent instructions:** Explicit directions for @dev, @qa, @devops
3. **Formalize overrides:** Create approval workflow

### SHOULD DO (Recommended)
4. **Separate concerns:** Split platform constraints from project guidelines
5. **Add structured metadata:** YAML for machine-readable patterns
6. **Clarify decision framework:** When to escalate, when to proceed

### NICE TO HAVE (Future)
7. **Automation:** Integrate structured metadata with validation script
8. **Versioning:** Track constraint updates over time
9. **Reporting:** Generate compliance reports

---

## ROOT CAUSE ANALYSIS

**Why these issues exist:**

1. **Rule written for humans, not agents** — AIOX design assumes agent-centric architecture
2. **Mixed terminology** — "Severity" overloaded with multiple meanings
3. **No agent specifications** — System doesn't define how agents consume rules
4. **Missing escalation model** — No formal override/exception process
5. **Incomplete AIOX pattern adoption** — Rule created before understanding agent integration needs

---

## CONCLUSION

Current implementation is **60% of the way to AIOX 10/10 compliance**. Domain knowledge is excellent, but architecture for agent consumption is lacking.

**Key insight:** The rule works for humans, but **AI agents need more structure** — explicit decision points, agent-specific instructions, and clear escalation paths.

**Recommendation:**
- ✅ Keep domain knowledge (constraints are accurate)
- ❌ Refactor architecture (agent integration, semantics, overrides)
- Timeline: Complete by end of week before production rollout

---

## APPENDIX: REFACTORED RULE STRUCTURE (TEMPLATE)

```markdown
# Nuvemshop FTP Constraints — Contextual Guidance Rule

## RULE METADATA (Machine-Readable)

**Rule ID:** nuvemshop-ftp-constraints-001
**Type:** Contextual Advisory Rule
**Enforcement Mode:** ADVISORY (non-blocking, context-providing)
**Guidance Level:** CRITICAL (severe impact if violated)
**Escalation Authority:** @architect
**Apply To:** theme-deploy-corrigido/**/*.{tpl,scss,js}

---

## OVERVIEW FOR ALL AGENTS

You are editing Nuvemshop FTP theme files. This guide provides context on
what works and what doesn't in Nuvemshop's platform. **This is advisory** —
you can proceed with changes, but be aware of the implications.

---

## PLATFORM CONSTRAINTS (Nuvemshop - IMMUTABLE)

**Source:** Official Nuvemshop Documentation
**Status:** Cannot be violated or overridden (TOS/Technical requirement)

### Constraint: Checkout Structure
- **Description:** Checkout page structure is handled by Nuvemshop backend
- **What you cannot do:** Modify form structure, remove fields, change layout
- **Why:** Backend integration will break, payment processing fails
- **Impact if violated:** CRITICAL — store cannot complete transactions

[... etc for each constraint ...]

---

## PROJECT GUIDELINES (Patagang - MUTABLE)

**Source:** Patagang Team Decisions
**Status:** Can be modified with justification and @architect approval

### Guideline: Performance Budget
- **Description:** Keep critical CSS under 50KB
- **Why:** Improves page load, better Core Web Vitals
- **Can override?:** Yes, with business justification
- **Escalation:** Request @architect approval

[... etc for each guideline ...]

---

## AGENT-SPECIFIC INSTRUCTIONS

### For @dev (Implementation)

**Your role:** Make the code changes

**What to do:**
1. Review "Platform Constraints" section for hard limits
2. Review "Project Guidelines" for best practices
3. Implement changes within these boundaries
4. If you need to violate a guideline: Document why in commit message

**How to proceed:**
- ✅ Proceed if change respects all constraints and guidelines
- ⚠️ Document justification if overriding a guideline
- ❌ Escalate to @architect if violating a platform constraint

**Escalation path:**
```
// @architect-override-request
// Constraint: [which guideline]
// Reason: [business justification]
// Risk: [what could go wrong]
// Mitigation: [how will you prevent issues]
```

---

### For @qa (Quality Review)

**Your role:** Verify changes are safe before deployment

**Checklist (reference: .aiox-core/development/checklists/nuvemshop-ftp-constraints.md):**
1. All platform constraints respected (use patterns section)
2. Project guidelines followed (or with documented justification)
3. Developer escalations approved by @architect
4. Post-deployment testing plan documented

**Decision criteria:**
- Platform constraint violated? → REJECT (non-negotiable)
- Guideline violated? → REJECT unless @architect approved
- All checks pass? → APPROVE for deployment

---

### For @devops (Deployment)

**Your role:** Deploy safely and validate post-deployment

**Pre-deployment:**
1. Verify @qa has approved
2. Ensure rollback procedure documented
3. Alert team: deployment starting

**Post-deployment:**
1. Run validation checks (Gate 4)
2. Test affected constraints directly
3. Monitor for issues (24 hours)
4. If violation detected: Execute rollback procedure

---

## PATTERNS & DETECTION

### Checkout Constraint Violations

**File:** **/checkout.tpl
**Indicators:**
- Form structure changed
- Form fields removed
- Form method modified
- Display set to none

---

## OVERRIDE PROCEDURE

### Guideline Override (Can override)

1. Developer documents justification in commit message
2. @qa flags for review (not automatic reject)
3. @architect reviews and approves/rejects
4. If approved: Proceed with enhanced testing
5. Record decision in CHANGELOG

### Platform Constraint Violation (Cannot override)

Escalate immediately to @architect and @pm. These are TOS violations.

---

## ESCALATION & SUPPORT

**Questions about constraints?** → Check NUVEMSHOP_FTP_STANDARDS.md

**Need to override a guideline?** → Follow "Override Procedure" above

**Platform constraint unclear?** → Ask @architect (response SLA: 4 hours)

**Violation already deployed?** → See NUVEMSHOP_FTP_VIOLATION_RECOVERY.md
```

---

**Report Generated:** 2026-03-20
**Architecture Review By:** Orion (@aiox-master)
**Status:** REQUIRES REFACTORING BEFORE PRODUCTION

👑 Orion, ensuring AIOX 10/10 compliance 🎯

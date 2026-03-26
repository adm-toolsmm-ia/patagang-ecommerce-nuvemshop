# 🏗️ Structural Refinement Roadmap — Patagang Ecommerce v1.5.93+

**Purpose:** Refine project architecture systematically for better maintainability, safety, and future frontend improvements.

**Approach:** Safe, progressive, stage-by-stage with Gabriel validation at each milestone.

**Timeline:** 4-6 weeks (parallel with frontend refinement planning)

---

## 📊 Current State Analysis (v1.5.93)

### ✅ What's Working
- Cart functionality (with known issues deferred)
- Core purchasing flow
- Design token system (partial)
- Module extraction (Phase 1: notifications, forms, footer, utilities)
- FTP deployment pipeline

### ⚠️ Known Issues (Deferred for Later)
- Frontend UI refinements
- Menu responsiveness (header categories)
- Password toggle visibility
- CSS performance optimizations

### 🎯 Structural Improvements Needed
- **JavaScript:** Consolidate cart logic, continue modularization, remove dead code
- **CSS:** Design system consolidation, token centralization
- **Dependencies:** Identify and remove unused libraries (Swiper?)
- **Code Organization:** Clear separation of concerns, consistent naming

---

## 🗺️ REFINEMENT ROADMAP (4 Stages)

### **STAGE 1: Dependency Audit & Cleanup** (Week 1)
**Goal:** Understand and optimize external dependencies

#### 1.1 Review Swiper Usage (Priority 4)
- **Risk Level:** 🟢 LOW
- **Impact:** Remove unused carousel library or consolidate usage
- **Timeline:** 2-3 hours
- **Steps:**
  1. Audit: Where is Swiper used in templates?
  2. Count: How many carousels on site?
  3. Decide: Keep Swiper or replace with native CSS?
  4. If remove: Test all carousels still work
  5. Deploy: v1.5.94
  6. **Gabriel validation:** Check all product carousels

#### 1.2 Audit External.js Dependencies
- **Risk Level:** 🟡 MEDIUM
- **Impact:** Identify if Pinterest, YouTube embeds are critical
- **Timeline:** 1-2 hours
- **Steps:**
  1. List all external libs in external.js.tpl
  2. Categorize: Critical vs Optional
  3. Identify which are lazy-loadable
  4. Document findings
  5. **Gabriel validation:** Confirm which libraries are truly needed

#### 1.3 Document External Dependencies
- **Deliverable:** `docs/architecture/DEPENDENCIES-AUDIT.md`
- **Contents:**
  - Swiper (carousel library)
  - Pinterest Pin button
  - YouTube/Vimeo embeds
  - Google Analytics
  - Others
  - Dependency map (what breaks if removed?)

---

### **STAGE 2: JavaScript Consolidation** (Week 2-3)
**Goal:** Clean up and consolidate JavaScript into logical modules

#### 2.1 Continue Priority 2 Phase 2 (Modularize store.js)
- **Risk Level:** 🟡 MEDIUM
- **Impact:** Reduce store.js.tpl further, improve maintainability
- **Current:** store.js.tpl = 121 KB (after Phase 1)
- **Target:** 90-100 KB (after Phase 2)
- **Timeline:** 4-6 hours
- **Steps:**
  1. Extract product-functions.js (~12-15K)
     - Variants, installments, quick view
  2. Extract shipping-functions.js (~8-10K)
     - CEP calculator, shipping selection
  3. Extract header-functions.js (~5-7K)
     - Menu logic, search
  4. Update layout.tpl load order
  5. Test all functionality
  6. Deploy: v1.5.95
  7. **Gabriel validation:** Test product page, shipping, cart

#### 2.2 Consolidate Cart Logic (Priority 3)
- **Risk Level:** 🟡 MEDIUM
- **Impact:** Simplify cart updates, reduce redundant code
- **Files:** cart-utils.js.tpl + cart-drawer.js.tpl
- **Current:** 40 KB combined
- **Target:** 30 KB (consolidate, remove redundancy)
- **Timeline:** 2-3 hours
- **Steps:**
  1. Audit: What does cart-utils do vs cart-drawer?
  2. Identify: Duplicate functions
  3. Consolidate: Single source of truth for quantity updates
  4. Refactor: Cleaner debounce logic
  5. Test: Quantity changes, updates
  6. Deploy: v1.5.96
  7. **Gabriel validation:** Add/remove products, change quantity rapidly

#### 2.3 Create JavaScript Architecture Documentation
- **Deliverable:** `docs/architecture/JAVASCRIPT-ARCHITECTURE.md`
- **Contents:**
  - Module dependency graph
  - Data flow (LS global → modules → DOM)
  - Initialization order
  - Critical vs non-critical code
  - Testing checklist for each module

---

### **STAGE 3: CSS & Design System Refinement** (Week 3-4)
**Goal:** Consolidate CSS, centralize design tokens, prepare for future frontend work

#### 3.1 Consolidate Design Tokens
- **Risk Level:** 🟡 MEDIUM
- **Impact:** Single source of truth for colors, spacing, typography
- **Timeline:** 2-3 hours
- **Current Files:**
  - style-colors.scss.tpl (25 KB)
  - style-tokens.tpl (39 KB)
  - Individual CSS files with hardcoded values
- **Steps:**
  1. Audit: List all colors in use
  2. Audit: List all spacing values
  3. Audit: List all typography scales
  4. Consolidate: Create central token file
  5. Replace: All CSS files reference tokens
  6. Test: All pages look same
  7. Deploy: v1.5.97
  8. **Gabriel validation:** Visual check (colors, spacing, fonts)

#### 3.2 Remove !important Declarations (Story 8.3)
- **Risk Level:** 🟡 MEDIUM
- **Impact:** Simpler CSS cascade, easier to override
- **Timeline:** 3-4 hours
- **Current:** ~150+ !important declarations
- **Target:** < 10 (only where absolutely necessary)
- **Steps:**
  1. Audit: Where is !important used?
  2. Analyze: Why is it needed?
  3. Refactor: Increase specificity instead
  4. Test: All styling works without !important
  5. Deploy: v1.5.98
  6. **Gabriel validation:** Test all pages, responsiveness

#### 3.3 CSS Performance Audit
- **Risk Level:** 🟢 LOW
- **Impact:** Reduce CSS size, maintain performance
- **Files:**
  - style-critical.tpl (164 KB)
  - style-async.scss.tpl (168 KB)
- **Steps:**
  1. Audit: Identify unused CSS rules
  2. Measure: Critical vs non-critical
  3. Report: Size breakdown by section
  4. Recommend: What can be removed/consolidated
  5. Document: `docs/architecture/CSS-AUDIT.md`

#### 3.4 Create CSS Architecture Documentation
- **Deliverable:** `docs/architecture/CSS-ARCHITECTURE.md`
- **Contents:**
  - Design token system (colors, spacing, typography)
  - CSS file organization
  - Critical vs async CSS
  - Component structure
  - Responsive breakpoints
  - Browser compatibility notes

---

### **STAGE 4: Testing & Documentation** (Week 4-6)
**Goal:** Ensure all changes are safe, document architecture for future work

#### 4.1 Comprehensive Testing Plan
- **Risk Level:** 🟢 LOW
- **Deliverable:** `docs/reviews/STRUCTURAL-REFINEMENT-QA.md`
- **Test Scenarios:**
  1. Add product to cart (simple, with variants)
  2. Change quantity multiple times rapidly
  3. Apply cupom, select ONG
  4. Calculate shipping (different CEPs)
  5. Mobile responsiveness (3 breakpoints)
  6. All carousels function
  7. Forms validate correctly
  8. Chat/Help sidebar load properly
  9. No JavaScript console errors
  10. Performance: PageSpeed > 85 mobile

#### 4.2 Architecture Documentation Complete
- **Deliverable:** `docs/architecture/COMPLETE-ARCHITECTURE.md`
- **Sections:**
  - System overview (box diagram)
  - JavaScript architecture (module dependency graph)
  - CSS architecture (token system + organization)
  - Data flow (how data moves through app)
  - Critical vs non-critical code
  - Testing strategy
  - Deployment checklist
  - Future roadmap (frontend refinements)

#### 4.3 Create Frontend Refinement Roadmap
- **Deliverable:** `docs/guides/FRONTEND-REFINEMENT-PLAN.md`
- **Contents:**
  - Design system implementation
  - UI component library
  - Responsive design improvements
  - Accessibility audit
  - Performance optimization
  - User experience enhancements
  - Timeline and priorities

#### 4.4 Update Project State
- **File:** `.aiox-core/data/patagang-project-state.yaml`
- **Update:**
  - Current version: v1.5.99 (after all refinements)
  - Structural refinement: COMPLETE
  - Ready for: Frontend refinement phase
  - Next phase: Story X.1 — Design System Implementation

---

## 📋 VALIDATION CHECKLIST (Per Stage)

### After STAGE 1
```
☐ Swiper usage documented
☐ External.js dependencies audited
☐ Decisions made (keep/remove/optimize)
☐ Gabriel approved changes
☐ v1.5.94 deployed and validated
```

### After STAGE 2
```
☐ Product functions extracted (Phase 2)
☐ Shipping functions extracted
☐ Header functions extracted
☐ Cart logic consolidated
☐ All modules tested independently
☐ store.js.tpl reduced to target size
☐ Gabriel validated all functionality
☐ v1.5.96 deployed and stable
```

### After STAGE 3
```
☐ Design tokens consolidated
☐ !important declarations removed
☐ CSS audit complete
☐ No visual regressions
☐ Performance maintained or improved
☐ Gabriel validated all pages
☐ v1.5.98 deployed and validated
```

### After STAGE 4
```
☐ All testing checklist passed
☐ Architecture documentation complete
☐ Frontend refinement roadmap created
☐ Project state updated
☐ Ready for next phase
```

---

## 🎯 Success Metrics

| Metric | Current | Target | Why |
|--------|---------|--------|-----|
| **store.js.tpl size** | 121 KB | 90 KB | Easier to maintain |
| **Total JS bundle** | ~250 KB | 190 KB | Performance |
| **CSS !important count** | 150+ | < 10 | Simpler cascade |
| **Unused dependencies** | 3-5 (estimated) | 0 | Clean codebase |
| **Code duplication** | ~15% | < 5% | Maintainability |
| **Test coverage** | 0% | 100% (manual checklist) | Confidence |
| **Documentation** | Scattered | Complete | Future work |

---

## 🚀 Next Immediate Action

**We are here:** v1.5.93 (structure, core functionality working)

**STAGE 1 — Dependency Audit & Cleanup**

### STEP 1: Swiper Usage Audit (2-3 hours)

**What I will do:**
1. Find ALL templates using Swiper
2. List ALL carousels on site
3. Document: Is Swiper critical?
4. Propose: Keep, replace, or optimize?

**What I need from you:**
- ✅ Confirm you want to proceed with STAGE 1
- ✅ Approve: Spend time auditing Swiper first
- ✅ Tell me: Any concerns about removing Swiper?

**Then:**
- I'll create audit report
- Show you findings
- Propose: Action plan for Swiper
- **You validate:** Before any code changes

---

## 📚 Related Documentation

- Current: `.aiox-core/data/patagang-project-state.yaml`
- Architecture Analysis: (Generated from exploration)
- FTP Constraints: `.claude/rules/nuvemshop-ftp-constraints.md`
- Deployment Workflow: `.claude/rules/devops-epic8-standard-workflow.md`

---

**Version:** 1.0 (Initial Roadmap)
**Created:** 2026-03-24
**Status:** READY FOR STAGE 1
**Owner:** Gabriel Cristofolini (CTO) + @aiox-master (Orchestration)

🏗️ **Ready to refine the structure systematically. Where should we start?**

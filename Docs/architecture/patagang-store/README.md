# Patagang Store Architecture — Complete Technical Documentation

**Status:** ✅ Complete & Current | **Last Updated:** 2026-03-24 | **Maintained by:** @architect

---

## 📋 Quick Navigation

This documentation maps the complete Patagang ecommerce store structure (theme-deploy-corrigido/) for quick understanding and context-aware development.

### **Guides** (Read First)
- **[01. Store Overview](01-STORE-OVERVIEW.md)** — High-level architecture, tech stack, key metrics
- **[02. Page Structure](02-PAGE-STRUCTURE.md)** — All 12 pages, layouts, and components used
- **[03. Component Inventory](03-COMPONENT-INVENTORY.md)** — 41 snipplets, detailed inventory

### **Technical Details**
- **[04. CSS Architecture](04-CSS-ARCHITECTURE.md)** — Style organization, critical/async split, budget status
- **[05. JavaScript Modules](05-JAVASCRIPT-MODULES.md)** — Core modules, dependencies, optimization priorities
- **[06. File Dependency Tree](06-FILE-DEPENDENCY-TREE.md)** — Visual maps of what depends on what

### **Constraints & Operations**
- **[07. Nuvemshop Constraints](07-NUVEMSHOP-CONSTRAINTS.md)** — 8 critical restrictions, what's forbidden
- **[08. Deployment Artifacts](08-DEPLOYMENT-ARTIFACTS.md)** — Versioning, FTP, rollback, CI/CD

---

## 🎯 Use Cases

### "I need to modify CSS for [page]"
1. Go to **[02. Page Structure](02-PAGE-STRUCTURE.md)**
2. Find your page, note which CSS files it uses
3. Check **[04. CSS Architecture](04-CSS-ARCHITECTURE.md)** for file locations
4. Review **[07. Nuvemshop Constraints](07-NUVEMSHOP-CONSTRAINTS.md)** for restrictions

### "I need to understand which components depend on [file]"
1. Check **[06. File Dependency Tree](06-FILE-DEPENDENCY-TREE.md)** for visual map
2. Or search `.aiox-core/data/patagang-component-dependency-map.yaml` (machine-readable index)

### "I need to add new functionality to [page]"
1. Go to **[02. Page Structure](02-PAGE-STRUCTURE.md)** → find page sections
2. Check **[03. Component Inventory](03-COMPONENT-INVENTORY.md)** → find related components
3. Review **[05. JavaScript Modules](05-JAVASCRIPT-MODULES.md)** → understand JS dependencies
4. Check **[07. Nuvemshop Constraints](07-NUVEMSHOP-CONSTRAINTS.md)** → verify what's allowed

### "I'm implementing Priority 2: Modularize store.js"
1. Go to **[05. JavaScript Modules](05-JAVASCRIPT-MODULES.md)** → `store.js.tpl` details
2. Check **[06. File Dependency Tree](06-FILE-DEPENDENCY-TREE.md)** → what components use it
3. Review `.aiox-core/data/patagang-component-dependency-map.yaml` → impact analysis
4. Plan refactoring strategy based on dependencies

---

## 📊 At a Glance

| Metric | Value | Status |
|--------|-------|--------|
| **Pages** | 12 main templates | ✅ Documented |
| **Components** | 41 snipplets | ✅ Documented |
| **CSS Files** | 15 | ⚠️ Critical oversized |
| **JS Files** | 6 core modules | ✅ Optimized (partial) |
| **Current Version** | v1.5.93 | ✅ Production |
| **Critical CSS Size** | 163KB (limit: 50KB) | 🔴 3.26x over |
| **Async CSS Size** | 164KB (limit: 200KB) | ✅ OK |
| **Store.js Size** | 125KB | ⏳ Priority 2 |
| **External.js Size** | 106KB | ✅ Optimized (v1.5.74) |

---

## 🔄 Data Sources

This documentation is backed by **two machine-readable registries** in `.aiox-core/data/`:

### **1. Store Catalog (patagang-store-catalog.yaml)**
Quick-lookup index of:
- All 12 pages with routing, sections, components
- 41 snipplets with categories and usage
- CSS files with sizes and purposes
- JS modules with dependencies
- All 8 Nuvemshop constraints

**Use this for:** Agent context lookups, automated analysis, quick reference

### **2. Component Dependency Map (patagang-component-dependency-map.yaml)**
Graph structure showing:
- Component relationships (provides/depends_on/used_by)
- Impact levels and risk assessment
- Optimization candidates with priorities
- Breaking change analysis

**Use this for:** Impact analysis, dependency traversal, refactoring planning

---

## 🎓 Architecture Principles

### **Layer Model (AIOX L1-L4)**

| Layer | Location | Mutability | Purpose |
|-------|----------|-----------|---------|
| **L3** | `.aiox-core/data/` | Mutable | Machine-readable registries |
| **L4** | `docs/architecture/` | Mutable | Human-readable technical docs |
| **L4** | `theme-deploy-corrigido/` | Mutable | Actual store code |

### **Design Principles**

1. **No Invention** — Documents ACTUAL structure, not imagined features
2. **Source of Truth** — YAML registries are authoritative, markdown is explanatory
3. **Navigation First** — Every document links to related docs
4. **Constraint-Aware** — All changes must respect Nuvemshop restrictions
5. **Impact-Driven** — Changes planned with dependency analysis

---

## ⚠️ Critical Alerts

### 🔴 **CSS Performance Budget EXCEEDED**

| File | Size | Limit | Status |
|------|------|-------|--------|
| style-critical.tpl | 163KB | 50KB | **3.26x OVER** |

**Action Required:** Story 8.2 goal is to reduce to 50KB through consolidation and optimization.

### 🟡 **JavaScript Optimization Ongoing**

| Priority | File | Size | Goal | Status |
|----------|------|------|------|--------|
| ✅ 1 | external.js | 106KB | Lazy-load Olark | COMPLETE (v1.5.74) |
| ⏳ 2 | store.js | 125KB | Modularize | PLANNED (v1.5.75) |
| ⏳ 3 | cart-drawer.js | 25KB | Consolidate | PLANNED (v1.5.76) |
| ⏳ 4 | Swiper usage | — | Audit | PLANNED (v1.5.77) |

---

## 🔗 Related Resources

- **AIOX Registry System:** `.aiox-core/data/`
- **Nuvemshop Constraint Rules:** `.claude/rules/nuvemshop-ftp-constraints.md`
- **FTP Deployment Standard:** `.claude/rules/patagang-ftp-production-standard.md`
- **Project State:** `.aiox-core/data/patagang-project-state.yaml`
- **Learned Patterns:** `.aiox-core/data/patagang-learned-patterns.yaml`

---

## 📝 Documentation Index

| File | Purpose | Read Time |
|------|---------|-----------|
| [01-STORE-OVERVIEW.md](01-STORE-OVERVIEW.md) | Architecture overview, tech stack, structure | 5 min |
| [02-PAGE-STRUCTURE.md](02-PAGE-STRUCTURE.md) | All 12 pages with layouts and components | 10 min |
| [03-COMPONENT-INVENTORY.md](03-COMPONENT-INVENTORY.md) | Complete snipplet inventory (41 components) | 12 min |
| [04-CSS-ARCHITECTURE.md](04-CSS-ARCHITECTURE.md) | Style files, critical/async split, optimization | 8 min |
| [05-JAVASCRIPT-MODULES.md](05-JAVASCRIPT-MODULES.md) | JS modules, libraries, dependencies | 8 min |
| [06-FILE-DEPENDENCY-TREE.md](06-FILE-DEPENDENCY-TREE.md) | Visual dependency maps | 6 min |
| [07-NUVEMSHOP-CONSTRAINTS.md](07-NUVEMSHOP-CONSTRAINTS.md) | 8 critical restrictions and what's forbidden | 7 min |
| [08-DEPLOYMENT-ARTIFACTS.md](08-DEPLOYMENT-ARTIFACTS.md) | Versioning, FTP, rollback, releases | 6 min |

**Total Read Time: ~60 minutes for complete understanding**

---

## 🚀 Quick Start for Agents

### For @dev (Implementation)
1. Read **[02. Page Structure](02-PAGE-STRUCTURE.md)** — understand where you're working
2. Check **[03. Component Inventory](03-COMPONENT-INVENTORY.md)** — find components to modify
3. Review **[05. JavaScript Modules](05-JAVASCRIPT-MODULES.md)** — understand JS dependencies
4. Verify **[07. Nuvemshop Constraints](07-NUVEMSHOP-CONSTRAINTS.md)** — check what's forbidden

### For @qa (Testing)
1. Review **[02. Page Structure](02-PAGE-STRUCTURE.md)** — understand pages affected
2. Check **[07. Nuvemshop Constraints](07-NUVEMSHOP-CONSTRAINTS.md)** — verify constraints met
3. Use **[08. Deployment Artifacts](08-DEPLOYMENT-ARTIFACTS.md)** — understand deployment process

### For @architect (Design)
1. Read **[01. Store Overview](01-STORE-OVERVIEW.md)** — architecture landscape
2. Check **[06. File Dependency Tree](06-FILE-DEPENDENCY-TREE.md)** — impact analysis
3. Review **[04. CSS Architecture](04-CSS-ARCHITECTURE.md)** — performance budget status
4. Consult **[05. JavaScript Modules](05-JAVASCRIPT-MODULES.md)** — optimization opportunities

---

## 📊 Performance Metrics

| Metric | Value | Target | Status |
|--------|-------|--------|--------|
| **Critical CSS** | 163KB | < 50KB | 🔴 Over |
| **Async CSS** | 164KB | < 200KB | ✅ OK |
| **Total JS** | ~266KB | < 400KB | ✅ OK |
| **LCP (Home)** | ~1.2s | < 2.5s | ✅ Good |
| **Core Web Vitals** | 92/100 | > 90 | ✅ Good |

---

## 🤝 Maintenance

- **Reviewed:** Quarterly (end of each epic)
- **Updated:** Continuously as code changes
- **Maintained by:** @architect
- **YAML Registries:** Auto-validated on deploy
- **Markdown Docs:** Manual review, cross-referenced

---

## ❓ Questions?

- **Architecture questions?** → See [01-STORE-OVERVIEW.md](01-STORE-OVERVIEW.md)
- **Component location?** → See [03-COMPONENT-INVENTORY.md](03-COMPONENT-INVENTORY.md)
- **Impact analysis?** → Check `.aiox-core/data/patagang-component-dependency-map.yaml`
- **Constraint violations?** → See [07-NUVEMSHOP-CONSTRAINTS.md](07-NUVEMSHOP-CONSTRAINTS.md)
- **Deployment steps?** → See [08-DEPLOYMENT-ARTIFACTS.md](08-DEPLOYMENT-ARTIFACTS.md)

---

**Document Version:** 1.0.0 | **AIOX L4 Documentation** | **Maintained by:** @architect
*Part of Patagang Ecommerce Architecture Documentation (2026-03-24)*

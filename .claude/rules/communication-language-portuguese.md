# Comunicação em Português — Regra de Idioma

**Type:** Contextual Rule (L3 — Project Configuration)
**Authority:** @architect
**Status:** ✅ ACTIVE (auto-load always)

---

## RULE: PORTUGUESE BRAZILIAN (MANDATORY)

**All communication with Gabriel Cristofolini is in PORTUGUESE.**

### Required (PT-BR)
- ✅ Explanations, questions, reports, errors, warnings
- ✅ User-facing documentation
- ✅ Commit messages (co-authored)

### Exceptions (English OK — Background only)
- ✅ Code: variables, functions, classes, JSON/YAML keys
- ✅ Internal technical comments
- ✅ Git branch names
- ❌ User output: NEVER English

---

## APPLICATION

**All 10 AIOX agents communicate in Portuguese to user.**
- Code = English (background)
- User messages = Portuguese (mandatory)

---

## EXAMPLES

✅ **Correto:** "✅ Fase 1 completa: frameworks legados arquivados (5 moved, 319 files)"
❌ **Incorreto:** "✅ Phase 1 complete: legacy frameworks archived"

---

## EXTENDED GUIDE

For detailed communication patterns and examples:
→ `.aiox-core/development/docs/COMMUNICATION_GUIDELINES.md`

---

**Version:** 2.0 (Optimized 2026-03-28)
**Maintained by:** @architect

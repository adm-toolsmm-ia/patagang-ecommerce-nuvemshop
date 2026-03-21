# 🚀 PLANO DE OTIMIZAÇÃO CSS — Story 7.1

## Status Atual
- **CSS Crítico:** 204 KB (7,072 linhas)
- **Limite:** 50 KB
- **Excesso:** 155 KB (312%)
- **Media Queries:** 60 (duplicadas?)
- **Seletores:** 886

---

## Estratégia de Redução

### FASE 1: Análise Imediata (30 min)
```
1. [ ] Executar PurgeCSS para remover classes não usadas
2. [ ] Identificar media queries duplicadas
3. [ ] Minificar CSS (remove espaços/comentários)
4. [ ] Remover @charset "UTF-8" (1 linha)
5. [ ] Consolidar seletores duplicados
```

**Meta:** 204 KB → ~120 KB (40% redução)

### FASE 2: Refatoração (2h)
```
3. [ ] Mover estilos não-críticos para style-async.css
4. [ ] Remover media queries > 1024px (não são críticas)
5. [ ] Consolidar regras de margin/padding duplicadas
6. [ ] Remover cores/fontes não utilizadas
```

**Meta:** 120 KB → ~65 KB (67% redução do original)

### FASE 3: Compressão Final (1h)
```
7. [ ] Implementar minificação automática
8. [ ] Gzip compression (servidor)
9. [ ] Critical CSS prioritization (CSSO)
```

**Meta:** 65 KB → ~45 KB (78% redução do original)

---

## Arquivos Recomendados Para Mover

### Para `style-async.css` (não-crítico):
- Estilos de hover (`:hover`, `:focus`)
- Animações (3+ segundos de delay aceitável)
- Media queries para tablets/mobile (> 768px)
- Estilos de página específica (blog, contact, etc.)
- Transições suaves (não afetam CLS)

### Manter em `style-critical.tpl` (crítico):
- Layout (grid, flexbox)
- Typography (fonte, tamanho, altura de linha)
- Cores principais (backgrounds, textos)
- Product detail page (PDP)
- Acima da dobra (above the fold)

---

## Ações Imediatas

### 1️⃣ Remover Media Queries Não-Críticas
```css
/* REMOVER: Media queries > 1024px */
@media (min-width: 1024px) { /* Mover para async */ }

/* MANTER: Apenas mobile/tablet críticas */
@media (min-width: 768px) { /* Layout essencial */ }
```

### 2️⃣ Consolidar Regras Duplicadas
```css
/* ANTES: 3 regras separadas */
.element { margin: 10px; }
.element { padding: 10px; }
.element { color: #333; }

/* DEPOIS: 1 regra consolidada */
.element { margin: 10px; padding: 10px; color: #333; }
```

### 3️⃣ Minificação Automática
```bash
npm install -g csso-cli
csso style-critical.tpl -o style-critical.min.tpl
```

---

## Timeline Recomendado

| Fase | Duração | Redução | Resultado |
|------|---------|---------|-----------|
| Current | — | — | 204 KB |
| Phase 1 | 30 min | 40% | ~120 KB |
| Phase 2 | 2h | 27% | ~65 KB ⚠️ Ainda acima |
| Phase 3 | 1h | 30% | ~45 KB ✅ OK |

---

## Próximos Commits

```
commit 1: refactor: remove unused CSS classes (PurgeCSS)
commit 2: refactor: move non-critical styles to async.css
commit 3: chore: minify CSS, reduce size 204KB → 45KB [Story 7.1]
```

---

## ROI (Return on Investment)

- **Melhoria de Performance:**
  - First Contentful Paint (FCP): ↓ 30%
  - Largest Contentful Paint (LCP): ↓ 40%
  - Core Web Vitals Score: ↑ 15-20 pontos

- **SEO Benefit:**
  - Google PageSpeed ↑ 20-25 pontos
  - Mobile Lighthouse ↑ 15-20 pontos
  - Ranking improvement ↑ (size factor)


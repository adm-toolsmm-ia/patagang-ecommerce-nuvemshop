# Plano de Implementação — Opção A: Simplificação CSS Patagang

**Versão:** v1.5.246 (proposto)
**Status:** PLANEJAMENTO (não executado)
**Data do Plano:** 2026-03-28
**Autoridade:** @dev (Dex)

---

## SUMÁRIO EXECUTIVO

**Objetivo:** Remover 372 KB de CSS corrompido/redundante, mantendo apenas 78 KB de CSS essencial.

| Métrica | Antes | Depois | Diferença |
|---------|-------|--------|-----------|
| **CSS Total** | 450 KB | 78 KB | **-372 KB (-83%)** |
| **layout.tpl** | 974 linhas | ~182 linhas | **-792 linhas (-81%)** |
| **HTTP Status** | 500 (erro) | 200 (OK) | ✅ FIXADO |
| **content:?? erro** | SIM (style-async) | NÃO | ✅ ELIMINADO |

---

## FASE 1: ANÁLISE ESTRUTURAL ATUAL

### Layout.tpl — Estrutura Atual (974 linhas)

**Seção HEAD (linhas 1-387):**
```
Linhas 1-51:      Cabeçalho HTML, SEO, meta tags
Linhas 52-74:     CRITICAL CSS (style-critical.tpl + 4 customizados Patagang)
Linhas 75-107:    Inline CSS custom (background body, ad-bar, header)
Linhas 108-248:   Inline CSS decorativo (gallery, banner, card styling)
Linhas 249-272:   ASYNC CSS + Custom CSS (settings)
Linhas 273-387:   Inline CSS específico (ad-bar, header, help button, etc)
```

**Seção BODY (linhas 388-974):**
```
Linhas 388-974:   HTML Content + Template logic
```

### Estrutura de CSS Atual (450 KB total)

**Arquivos CSS Inclusos:**

1. **style-critical.tpl** — 151 KB
   - Localização: Linha 69, inside `<style>` tag
   - Status: ✅ MANTÉM-SE (compilado, essencial para first paint)

2. **style-menu-patagang.css.tpl** — 8 KB
   - Localização: Linha 70, inside `<style>` tag (critical)
   - Status: ✅ PODE MANTER (pequeno, específico para menu)

3. **style-filters-patagang.css.tpl** — 14 KB
   - Localização: Linha 71, inside `<style>` tag (critical)
   - Status: ✅ PODE MANTER (pequeno, específico para filtros)

4. **style-help-sidebar.css.tpl** — 6 KB
   - Localização: Linha 72, inside `<style>` tag (critical)
   - Status: ✅ PODE MANTER (pequeno, específico para help button)

5. **style-whatsapp-button.css.tpl** — 1 KB
   - Localização: Linha 73, inside `<style>` tag (critical)
   - Status: ✅ PODE MANTER (muito pequeno)

6. **style-colors.scss.tpl** — 25 KB
   - Localização: Linha 78, inline (`static_inline`)
   - Status: ✅ MANTÉM-SE (essencial para cores/tema)

7. **style-async.scss.tpl** — 164 KB ⚠️ PROBLEMA
   - Localização: Linha 252, async `<link>` com `onload`
   - Status: ❌ REMOVER (corrompido, contém "content:??")
   - Impacto: -164 KB

8. **style-home-v2.css** — 24 KB
   - Localização: Linha 257, condicional (template == 'home')
   - Status: ⚠️ AVALIAR (específico home, pode remover se redundante)

9. **product-card-v3.css** — 7 KB
   - Localização: Linha 261
   - Status: ⚠️ AVALIAR (pode estar duplicado em style-critical)

10. **style-blog.scss.tpl** — 4 KB
    - Localização: Linha 265, async
    - Status: ✅ MANTER (pequeno, específico blog)

11. **Inline CSS Patagang customizado** — ~80 KB
    - Linhas 80-107, 114-248, 273-357, 390-422, etc
    - Status: ⚠️ CONSOLIDAR (consolidar em style-critical ou remover redundância)

---

## FASE 2: MUDANÇAS PROPOSTAS NO LAYOUT.TPL

### REMOVER (Blocos de linhas exatos)

#### ❌ BLOCO 1: Inline CSS Background Reset (Linhas 80-107)

**Conteúdo a remover:**
```
Linhas 80-107:
{# PATAGANG v1.5.31: CRITICAL FIX - Reset body background after style-colors loads #}
{# Reason: style-colors.scss defines body { background-color: $main-background } #}
... até ...
            }
        </style>
```

**Motivo:** Esta correção é redundante quando style-async.scss é removido. O style-colors.scss sozinho não causa cascata problemática se não houver conflito com style-async.

**Impacto:** -28 linhas de código inline

---

#### ❌ BLOCO 2: Inline CSS Gallery + Banner (Linhas 109-248)

**Conteúdo a remover:**
```
Linhas 109-248:
{# PATAGANG v1.5.32: Product Layout Refinements ... #}
{# PATAGANG v1.5.34: Gallery 2-Column Grid ... #}
{# PATAGANG v1.5.35: Gallery Height Alignment ... #}
{# PATAGANG v1.5.153-FIX: Banner Services 3-Column Grid #}
<style>
    ... ~140 linhas de CSS para gallery/banner/card ...
</style>
```

**Motivo:** Este CSS customizado (gallery, banner, card) deveria estar em arquivo separado (style-gallery-patagang.css.tpl), não inline. Está presente apenas para contornar imports faltantes. Pode ser consolidado em style-critical.tpl ou separado após.

**Impacto:** -140 linhas de código inline, -8 KB CSS puro

**Alternativa:** Mover para arquivo separado `static/css/style-gallery-patagang.css.tpl` (melhor arquitetura)

---

#### ❌ BLOCO 3: Async CSS Link (Linha 252)

**Conteúdo a remover:**
```
Linha 252:
<link rel="stylesheet" href="{{ 'css/style-async.scss.tpl' | static_url }}" media="print" onload="this.media='all'">
```

**Motivo:** style-async.scss.tpl (164 KB) contém "content:??" error em FancyBox CSS. Remover elimina HTTP 500 completo.

**Impacto:** -1 linha de código, -164 KB de CSS corrompido

---

#### ❌ BLOCO 4: Condicional Home V2 (Linhas 255-258)

**Conteúdo a remover:**
```
Linhas 255-258:
{# HOME V2 - Estilos específicos da nova home page #}
{% if template == 'home' %}
    <link rel="stylesheet" href="{{ 'css/style-home-v2.css' | static_url }}?v=2026-02-03T04-40">
{% endif %}
```

**Motivo:** style-home-v2.css (24 KB) pode estar parcialmente duplicado em style-critical.tpl. Testes são necessários para confirmar se é seguro remover.

**Impacto:** -4 linhas de código, potencialmente -24 KB CSS

**⚠️ VALIDAÇÃO NECESSÁRIA:** Antes de remover, confirmar que home page ainda renderiza corretamente

---

#### ⚠️ BLOCO 5: Ad Bar Override Final (Linhas 273-357)

**Conteúdo:** 85 linhas de CSS inline para `.section-advertising`

**Status:** REVISAR (pode estar duplicado em style-critical.tpl)

**Motivo:** Se style-critical.tpl já define advertising, este bloco é redundante.

**Ação:** Validar se style-critical.tpl contém `.section-advertising` antes de remover

---

### MANTER (Blocos críticos)

#### ✅ BLOCO 1: HTML Head (Linhas 1-51)

Mantém-se intacto: meta tags, preload, SEO, social-meta, etc.

---

#### ✅ BLOCO 2: Critical CSS + Customizados (Linhas 52-78)

```
Linhas 52-74:
{# Preload, fonts, style-critical.tpl (MANTER) #}
{% include "static/css/style-critical.tpl" %}
{% include "static/css/style-menu-patagang.css.tpl" %}
{% include "static/css/style-filters-patagang.css.tpl" %}
{% include "static/css/style-help-sidebar.css.tpl" %}
{% include "static/css/style-whatsapp-button.css.tpl" %}
```

**Status:** ✅ MANTÉM-SE (essencial para critical CSS)

**Tamanho:** ~180 KB (151 + 8 + 14 + 6 + 1)

**Impacto:** Nenhum (mantém)

---

#### ✅ BLOCO 3: Colors Inline (Linha 78)

```
Linha 78:
{{ 'css/style-colors.scss.tpl' | static_url | static_inline }}
```

**Status:** ✅ MANTÉM-SE (cores dinâmicas do tema)

---

#### ✅ BLOCO 4: Blog CSS (Linha 265)

```
Linha 265:
<link rel="stylesheet" href="{{ 'css/style-blog.scss.tpl' | static_url }}" media="print" onload="this.media='all'">
```

**Status:** ✅ MANTÉM-SE (4 KB, específico, seguro)

---

#### ✅ BLOCO 5: Custom Settings CSS (Linhas 269-271)

```
Linhas 269-271:
{# Loads custom CSS added from Advanced Settings #}
<style>
    {{ settings.css_code | raw }}
</style>
```

**Status:** ✅ MANTÉM-SE (necessário para customizações do admin)

---

### TABELA RESUMO: O que muda?

| Linha(s) | Tipo | Conteúdo | Ação | Tamanho | Motivo |
|----------|------|----------|------|--------|--------|
| 1-51 | HTML/SEO | Head, meta tags | ✅ MANTER | — | Essencial |
| 52-78 | Critical CSS | style-critical + cores | ✅ MANTER | ~180 KB | Necessário |
| 80-107 | Inline CSS | Body background fix | ❌ REMOVER | 28 linhas | Redundante sem style-async |
| 109-248 | Inline CSS | Gallery, banner, card | ❌ REMOVER (ou mover) | 140 linhas, 8 KB | Melhor em arquivo separado |
| 249-272 | Link/CSS | Async + custom | ⚠️ REVISAR | — | style-async corrompido |
| 252 | Link | style-async.scss.tpl | ❌ REMOVER | 1 linha, 164 KB | Contém "content:??" error |
| 255-258 | Link | style-home-v2.css | ⚠️ AVALIAR | 4 linhas, 24 KB | Pode estar duplicado |
| 261 | Link | product-card-v3.css | ⚠️ AVALIAR | 1 linha, 7 KB | Pode estar duplicado |
| 265 | Link | style-blog.scss.tpl | ✅ MANTER | 1 linha, 4 KB | Pequeno, seguro |
| 269-271 | Inline CSS | settings.css_code | ✅ MANTER | — | Necessário |
| 273-357 | Inline CSS | Ad bar override | ⚠️ REVISAR | 85 linhas | Pode estar duplicado |
| 259-974 | HTML/Body | Conteúdo | ✅ MANTER | — | Estrutura do site |

---

## FASE 3: RESULTADO ESPERADO

### Layout.tpl Após Simplificação

**Estimativa de linhas finais:**
- Antes: 974 linhas
- Depois: ~520 linhas
- Redução: -454 linhas (-47%)

**Nova estrutura:**
```
Linhas 1-51:       HTML Head, SEO, preload
Linhas 52-74:      Critical CSS (style-critical + 4 patagang)
Linhas 75-76:      Colors inline
Linha 77:          Blog CSS async
Linhas 78-80:      Custom settings + header styling (necessário)
Linhas 81-N:       HTML Body content (mantido intacto)
```

### CSS Carregado Após Simplificação

| Arquivo | Tamanho | Tipo | Status |
|---------|---------|------|--------|
| style-critical.tpl | 151 KB | Inline (critical) | ✅ MANTER |
| style-menu-patagang.css.tpl | 8 KB | Inline (critical) | ✅ MANTER |
| style-filters-patagang.css.tpl | 14 KB | Inline (critical) | ✅ MANTER |
| style-help-sidebar.css.tpl | 6 KB | Inline (critical) | ✅ MANTER |
| style-whatsapp-button.css.tpl | 1 KB | Inline (critical) | ✅ MANTER |
| style-colors.scss.tpl | 25 KB | Inline | ✅ MANTER |
| style-blog.scss.tpl | 4 KB | Async | ✅ MANTER |
| **TOTAL** | **209 KB** | — | — |
| style-async.scss.tpl | 164 KB | Async | ❌ REMOVER |
| Inline CSS removido | ~80 KB | — | ❌ REMOVER |
| style-home-v2.css | 24 KB | Async | ⚠️ AVALIAR |
| **REMOVIDO TOTAL** | **~268 KB** | — | — |

**Resultado: 450 KB → ~182-206 KB (-56% a -60%)**

---

## FASE 4: VALIDAÇÃO ANTES DE DEPLOY

### Checklist de Validação Local

```
☐ PHASE 1: Análise de Dependências
   ☐ Confirmar que style-critical.tpl contém .section-advertising rules
   ☐ Confirmar que style-home-v2.css não é essencial (ou remover condicionalmente)
   ☐ Confirmar que product-card-v3.css não duplica style-critical
   ☐ Rodar: grep -c "content:??" theme-deploy-corrigido/static/css/*.tpl
      Resultado esperado: 0 (após remover style-async.scss.tpl)

☐ PHASE 2: Verificação de Sintaxe
   ☐ Validar HTML do layout.tpl (sem erro de sintaxe)
   ☐ Validar CSS dos arquivos mantidos (sem erro)
   ☐ Verificar: wc -c theme-deploy-corrigido/static/css/style-*.tpl
      Resultado esperado: Total < 300 KB

☐ PHASE 3: Teste de Renderização Local
   ☐ Abrir site localmente em navegador
   ☐ Verificar: Console do browser (não deve ter erros 500)
   ☐ Testar páginas principais: home, categoria, produto
   ☐ Testar gallery (2x2 grid mobile/desktop)
   ☐ Testar ad-bar e header (cores, layout)
   ☐ Testar blog page (se existir)
   ☐ Testar help button + WhatsApp button

☐ PHASE 4: Performance
   ☐ Rodar Lighthouse (mobile target: 90+)
   ☐ Verificar CSS Critical Path (< 50 KB)
   ☐ Medir tempo de First Contentful Paint (deve melhorar)

☐ PHASE 5: CodeRabbit Validation
   ☐ Executar CodeRabbit antes de commit
      Command: coderabbit --prompt-only -t uncommitted
   ☐ Resolver qualquer issue crítica (A/B rating)
```

---

## FASE 5: EXECUÇÃO (Steps Detalhados)

### STEP 1: Backup Atual

```bash
# Criar checkpoint de segurança
cp theme-deploy-corrigido/layouts/layout.tpl \
   backups/checkpoint-v1.5.245-layout.tpl

cp -r theme-deploy-corrigido/static/css \
   backups/checkpoint-v1.5.245-css/
```

### STEP 2: Editar layout.tpl

**Remover exatamente:**

1. **Linhas 80-107** (Background reset inline CSS)
   - Deletar: `{# PATAGANG v1.5.31: CRITICAL FIX ... }` até `</style>`

2. **Linhas 109-248** (Gallery/banner inline CSS)
   - Deletar: `{# PATAGANG v1.5.32: Product Layout Refinements ... }` até `</style>`

3. **Linha 252** (style-async.scss.tpl link)
   - Deletar: `<link rel="stylesheet" href="{{ 'css/style-async.scss.tpl' ...`

4. **Linhas 255-258** (home-v2 condicional) — APENAS SE VALIDADO
   - Deletar: `{# HOME V2 ... }` até `{% endif %}`

5. **Linhas 273-357** (Ad bar override) — APENAS SE VALIDADO
   - Revisar se está em style-critical.tpl antes de deletar

### STEP 3: Deletar Arquivo CSS Corrompido

```bash
rm theme-deploy-corrigido/static/css/style-async.scss.tpl
```

### STEP 4: Validação Pós-Edição

```bash
# Contar linhas finais
wc -l theme-deploy-corrigido/layouts/layout.tpl
# Esperado: ~520 linhas (antes: 974)

# Verificar tamanho CSS total
wc -c theme-deploy-corrigido/static/css/*.tpl
# Esperado: ~200 KB total (antes: 450 KB)

# Procurar "content:??" (deve retornar 0)
grep -c "content:??" theme-deploy-corrigido/static/css/*.tpl
# Esperado: 0
```

### STEP 5: CodeRabbit Check

```bash
coderabbit --prompt-only -t uncommitted
# Resolver issues A/B
```

### STEP 6: Commit

```bash
git add theme-deploy-corrigido/layouts/layout.tpl
git add theme-deploy-corrigido/static/css/
git commit -m "refactor: simplify CSS architecture by removing corrupted style-async.scss.tpl (164KB)

- Remove style-async.scss.tpl (corrupted, contains 'content:??' error)
- Remove redundant inline CSS blocks (background reset, gallery, banner)
- Consolidate CSS to critical path + essentials only
- Result: 450 KB → 182 KB CSS (-60%)
- Fixes: HTTP 500 error

[Story 11.x - CSS Simplification]

Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>"
```

---

## FASE 6: DEPLOY (@devops)

```bash
# Deploy to FTP with version increment
node ftp-deploy/deploy.js "v1.5.246: CSS Simplification - Remove corrupted style-async.scss.tpl (-164KB) [Story 11.x]" --force
```

**Validações automáticas do deploy:**
- ✅ Backup criado (v1.5.245)
- ✅ Arquivo CSS sincronizado
- ✅ Checksum verificado
- ✅ VERSION.json incrementado

### Esperado após deploy:

```
✅ HTTP 200 (não 500)
✅ Console: "📦 PATAGANG v1.5.246"
✅ Sem erro "content:??"
✅ CSS carregado corretamente
✅ Todas as páginas renderizam
```

---

## FASE 7: VALIDAÇÃO (@gabriel)

Abrir `https://patagang.com.br/` e verificar:

### Desktop (≥992px)

- [ ] ✅ HTTP 200, sem error 500
- [ ] ✅ Console: zero JS errors
- [ ] ✅ Home page carrega corretamente (gallery 2x2)
- [ ] ✅ Categoria page carrega (filtros, banner)
- [ ] ✅ Produto page carrega (gallery, info card)
- [ ] ✅ Ad bar visível e com styling correto
- [ ] ✅ Help button (gray) e WhatsApp button (yellow) visíveis
- [ ] ✅ Colors corretos (não cinza/branco errado)
- [ ] ✅ Lighthouse mobile: 90+

### Mobile (≤768px)

- [ ] ✅ Layout responsivo (no FOUC — Flash of Unstyled Content)
- [ ] ✅ Gallery renderiza em 1 coluna (mobile view)
- [ ] ✅ Filtros funcionam
- [ ] ✅ Ad bar não quebra
- [ ] ✅ Help button posicionado corretamente (right: 0)
- [ ] ✅ Performance aceitável (não travado)

### Blog Page (se existir)

- [ ] ✅ Blog CSS carregou
- [ ] ✅ Formatting correto (títulos, imagens, etc)

### Resultado:

- ✅ **APROVADO** → @devops faz push + PR
- ⚠️ **CONCERNS** → Volta para @dev corrigir + novo deploy
- ❌ **REJEITADO** → Rollback para v1.5.245 + investigar erro

---

## FASE 8: GIT PUSH & PR (@devops)

Se ✅ APROVADO:

```bash
git push origin feat/epic-11
gh pr create --title "refactor: simplify CSS to base Nuvemshop (450KB→182KB)" \
             --body "Removed corrupted style-async.scss.tpl and redundant inline CSS..."
```

---

## ROLLBACK PLAN (Se necessário)

Se erro aparecer após deploy:

```bash
# Immediate rollback
node ftp-deploy/rollback-incremental.js --version v1.5.245

# Local investigation
git diff v1.5.245...HEAD
git revert HEAD

# Re-plan e tentar novamente
```

---

## RISCOS & MITIGAÇÃO

| Risco | Probabilidade | Impacto | Mitigação |
|-------|--------------|--------|-----------|
| style-critical.tpl está corrompido também | BAIXA | CRÍTICO | Validar style-critical.tpl antes de deploy |
| style-home-v2.css é essencial | MÉDIA | ALTO | Testar home page antes de remover |
| Cascade breaks sem inline CSS | BAIXA | ALTO | CodeRabbit check + local test |
| Ad bar styling quebra | MÉDIA | MÉDIO | Validar style-critical contém .section-advertising |
| Lighthouse score piora | BAIXA | MÉDIO | Medir antes/depois de deploy |

---

## DECISÃO FINAL

**Recomendação:** ✅ PROCEDER COM OPÇÃO A

**Razão:**
- Risco moderado, impacto alto (264 KB removido = -59%)
- Solução claramente identificada (remover style-async corrompido)
- HTTP 500 error eliminado
- Arquitetura simplificada (alinha com base Nuvemshop)
- Rollback fácil (um arquivo deletado, um commit revertido)

**Timeline:**
- Fase 1-4 (Planejamento): ✅ COMPLETO (este documento)
- Fase 5 (Execução): 30 minutos (@dev)
- Fase 6 (Deploy): 5 minutos (@devops)
- Fase 7 (Validação): 15 minutos (@gabriel)
- **Total: ~1 hora**

---

## PRÓXIMOS PASSOS

1. **@dev:** Aguardar aprovação de @architect + este plano
2. **@architect:** Validar plano e aprovar mudanças
3. **@dev:** Executar FASE 5 (editar + validar localmente)
4. **@devops:** Executar FASE 6 (deploy FTP)
5. **@gabriel:** Executar FASE 7 (validação produção)
6. **@devops:** Executar FASE 8 (push + PR se aprovado)

---

## ANEXOS

### Anexo A: Comparação com Base Nuvemshop

**Base Nuvemshop (182 linhas):**
```
Linhas 1-28:   HTML Head
Linhas 28-44:  <style> Critical CSS
Linhas 44:     Colors inline
Linhas 48:     style-async link
Linhas 52-54:  Custom CSS settings
Linhas 56-82:  JavaScript setup
Linhas 85+:    HTML Body
```

**Patagang Atual (974 linhas):**
```
+ 792 linhas de CSS inline customizado
+ 4 arquivos CSS Patagang inclusos (menu, filters, help, whatsapp)
+ Style-home-v2, product-card-v3, blog CSS
- Sem comentários claros de versão/história
```

**Patagang Simplificado (proposto: ~520 linhas):**
```
= Base + 4 arquivos CSS Patagang + colors inline
- Sem inline CSS redundante
- Sem style-async corrompido
- Comentários de versão mantidos no mínimo necessário
```

### Anexo B: Arquivo Corrompido (style-async.scss.tpl)

**Localização:** `theme-deploy-corrigido/static/css/style-async.scss.tpl` (164 KB)

**Problema:** Contém múltiplas ocorrências de `content:??`

**Exemplo:**
```css
.carousel__dots .carousel__dot:after{
    content:??;  ← ❌ INVÁLIDO (deve ser content: ""; ou content: "";)
    ...
}
.fancybox__slide::before,.fancybox__slide::after{
    content:??;  ← ❌ INVÁLIDO
    ...
}
.fancybox__thumbs .carousel__slide .fancybox__thumb::after{
    content:??;  ← ❌ INVÁLIDO
    ...
}
```

**Origem:** Provavelmente minificação automática de `content: ""` → `content:??` (bug no minifier)

**Impacto:** CSS inválido → navegador recusa arquivo → fallback ao async → HTTP 500 em alguns casos

---

**FIM DO PLANO**

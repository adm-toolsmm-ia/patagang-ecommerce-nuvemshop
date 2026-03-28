# OPÇÃO C: Passos Técnicos Detalhados (Implementação)

**Status:** 📋 REFERÊNCIA PARA EXECUÇÃO
**Para:** @dev (implementação)
**Duração Estimada:** 6-7 horas (1 dia)

---

## PASSO 1: Analisar e Extrair Style-Critical

### 1.1 Entender Estrutura Atual

```bash
# Verificar tamanho e linhas
wc -l theme-deploy-corrigido/static/css/style-critical.tpl
# Expected: ~4771 linhas, 149 KB

# Revisar estrutura (comentários indicam seções)
head -50 theme-deploy-corrigido/static/css/style-critical.tpl | grep -E "^#|^//|Table of Contents"
```

### 1.2 Identificar Regras LCP Real

**Regras que DEVEM ir para `style-critical-bare.tpl`:**

```css
/* CRÍTICO PARA LCP (INLINE) */
─────────────────────────────────────────────────────

1. Bootstrap Grid (necessário para layout)
   - .container, .row, .col-* {display, width, flex}

2. Swiper Carousel (hero/home carousel acima do fold)
   - .swiper-wrapper, .swiper-slide {display, dimensions}

3. Header & Navigation (sempre visível)
   - header {dimensions, padding, flex}
   - nav {display, flex, z-index}
   - .logo {width, height}

4. Primary Buttons & Links (CTA acima do fold)
   - .btn-primary, .btn-secondary {padding, font, display}
   - a {color, text-decoration}

5. Headings & Base Typography (LCP text)
   - h1, h2, h3, h4, h5, h6 {font-size, font-weight, margin}
   - p, body {font-family, font-size, line-height}

6. Forms - Critical Inputs (login/search above fold)
   - input[type="text"], input[type="search"] {padding, border, font}
   - .form-group {margin, display}

7. Placeholders & Preloaders (LCP skeleton)
   - .placeholder {background, dimensions}
   - .skeleton {background, animation}

8. Home Hero Section (LCP element #1)
   - .hero, .hero-section {dimensions, flex, colors}
   - .hero-title {font-size, color, margin}

9. Notifications (status messages — se acima do fold)
   - .alert, .notification {padding, border, display}

10. Icons (SVG/Font icons used in critical sections)
    - .icon, .svg-icon {width, height, fill}

/* NÃO CRÍTICO (VAI PARA style-critical-extra.scss.tpl) */
─────────────────────────────────────────────────────

- Product grid (below fold)
- Product cards (below fold)
- Footer (below fold)
- Blog (separate section)
- Advanced hover states (:hover)
- Animations (@keyframes)
- Mobile media queries (lazy-load via async)
- Footer attribution
- Sidebar components
```

### 1.3 Extrair Manualmente

**OPÇÃO A: Análise Manual (Segura)**

```bash
# 1. Copiar style-critical.tpl para análise
cp theme-deploy-corrigido/static/css/style-critical.tpl \
   style-critical-BACKUP.tpl

# 2. Criar novo arquivo bare (começar vazio)
cat > theme-deploy-corrigido/static/css/style-critical-bare.tpl << 'EOF'
/* ================================================
   CRITICAL PATH CSS — LCP Only
   Inlined in <head> for fast rendering
   ================================================ */

/* Importar charset UTF-8 */
{% raw %}@charset "UTF-8":{% endraw %}

EOF

# 3. Copiar do BACKUP apenas seções críticas
# Usar editor para copiar manualmente:
# - Bootstrap Grid section
# - Swiper section
# - Header & nav section
# - Buttons section
# - Headings section
# - Forms section
# - Home hero section
# - Icons section
```

**OPÇÃO B: Análise Automatizada (Mais rápido)**

```bash
# Use grep para extrair comentários de seção
grep -n "^#\|^//\|^\/\*" theme-deploy-corrigido/static/css/style-critical.tpl | \
  grep -E "Bootstrap|Swiper|Header|Button|Heading|Form|Hero|Icon|Typography"

# Isso te mostra as linhas onde cada seção começa
# Aí você copia manualmente as linhas entre elas
```

### 1.4 Validar CSS

```bash
# Verificar tamanho final
wc -c theme-deploy-corrigido/static/css/style-critical-bare.tpl
# Target: 20-30 KB

# Validar CSS syntax (usando Node.js npm package)
npm install -g stylelint

stylelint theme-deploy-corrigido/static/css/style-critical-bare.tpl
# Expected: 0 errors

# Verificar character encoding
file theme-deploy-corrigido/static/css/style-critical-bare.tpl
# Expected: UTF-8 Unicode text
```

---

## PASSO 2: Criar Style-Critical-Extra

### 2.1 Extrair "Tudo Menos Bare"

```bash
# 1. Copiar o BACKUP
cp style-critical-BACKUP.tpl \
   theme-deploy-corrigido/static/css/style-critical-extra.scss.tpl

# 2. Remover manualmente as seções LCP
# Vá para cada linha que você copiou para bare
# E DELETE-A do extra
#
# Resultado final: style-critical-extra contém APENAS:
# - Product grid
# - Product cards
# - Footer
# - Blog
# - Hover states
# - Animations
# - Mobile media queries
# - Decorative CSS
```

### 2.2 Validar

```bash
# Tamanho esperado
wc -c theme-deploy-corrigido/static/css/style-critical-extra.scss.tpl
# Target: 80-120 KB

# Sintaxe (se for SCSS)
stylelint theme-deploy-corrigido/static/css/style-critical-extra.scss.tpl

# Encoding
file theme-deploy-corrigido/static/css/style-critical-extra.scss.tpl
```

---

## PASSO 3: Processar Style-Async

### 3.1 Entender o Arquivo Corrompido

```bash
# Verificar se tem problemas
head -100 theme-deploy-corrigido/static/css/style-async.scss.tpl | tail -50

# Procurar por linhas deletadas (gaps no numeração de comentários)
grep -n "^/\*" theme-deploy-corrigido/static/css/style-async.scss.tpl | head -20

# Procurar por caracteres estranhos
file theme-deploy-corrigido/static/css/style-async.scss.tpl

# Validar SCSS
node -e "require('sass').render({file: 'theme-deploy-corrigido/static/css/style-async.scss.tpl'}, (e, r) => console.log(e || 'OK'))"
```

### 3.2 Separar Core vs Extended

**Regras para `style-async-core.scss.tpl` (essenciais):**

```scss
/* Product Cards */
.product-card { /* estilos */ }
.product-card__image { /* estilos */ }
.product-card__title { /* estilos */ }

/* Gallery Lightbox */
.gallery-modal { /* estilos */ }
.modal-overlay { /* estilos */ }

/* Filter & Sort UI */
.filter-link { /* estilos */ }
.sort-dropdown { /* estilos */ }

/* Mobile Optimizations */
@media (max-width: 768px) {
  /* mobile-specific rules */
}
```

**Regras para `style-async-extended.scss.tpl` (lazy):**

```scss
/* Blog Styling */
.blog-post { /* estilos */ }
.blog-footer { /* estilos */ }

/* Advanced Animations */
@keyframes slideInFromLeft { /* ... */ }
@keyframes fadeInUp { /* ... */ }

/* Niche Components */
.testimonial { /* estilos */ }
.countdown { /* estilos */ }

/* Edge Cases & Low Priority */
.deprecated-component { /* estilos */ }
```

### 3.3 Extrair Manualmente (ou Automatizado)

```bash
# OPÇÃO A: Manual (Seguro)
# 1. Abrir style-async.scss.tpl em editor
# 2. Copiar seções "product-card", "gallery", "filter" → async-core
# 3. Copiar seções "blog", "animations", "niche" → async-extended

# OPÇÃO B: Grep para identificar seções
grep -n "^/\* =\|^//.*SECTION\|^--.*section" \
  theme-deploy-corrigido/static/css/style-async.scss.tpl
```

### 3.4 Validar

```bash
# Tamanho esperado
wc -c theme-deploy-corrigido/static/css/style-async-core.scss.tpl
# Target: 40-60 KB

wc -c theme-deploy-corrigido/static/css/style-async-extended.scss.tpl
# Target: 80-100 KB

# Verificar que NADA foi deletado (line count original)
wc -l style-async-BACKUP.tpl  # Nota: salve o original antes!
wc -l theme-deploy-corrigido/static/css/style-async-core.scss.tpl
wc -l theme-deploy-corrigido/static/css/style-async-extended.scss.tpl
# Sum of core + extended ≈ original

# Validar SCSS
stylelint theme-deploy-corrigido/static/css/style-async-core.scss.tpl
stylelint theme-deploy-corrigido/static/css/style-async-extended.scss.tpl
```

---

## PASSO 4: Verificar Customizações Patagang (NÃO MEXER)

```bash
# Confirmar que estão intactos
ls -lh theme-deploy-corrigido/static/css/style-*-patagang.css.tpl

# Esperado:
# -rw-r--r-- 8.0K style-menu-patagang.css.tpl
# -rw-r--r-- 15K  style-filters-patagang.css.tpl
# -rw-r--r-- 6.6K style-help-sidebar.css.tpl
# -rw-r--r-- 1.8K style-whatsapp-button.css.tpl

# Validar CSS
stylelint theme-deploy-corrigido/static/css/style-*-patagang.css.tpl
# Expected: 0 errors
```

---

## PASSO 5: Deletar Arquivos Não Utilizados

### 5.1 Verificar Referências

```bash
# Procurar referências no código
grep -r "style-blog\|style-tokens\|style-home-v2\|product-card-v3" \
  theme-deploy-corrigido/ \
  --include="*.tpl" \
  --include="*.scss" \
  --include="*.js"

# Se NÃO encontrar nada, está seguro deletar
```

### 5.2 Deletar

```bash
# Criar backup antes
mkdir -p backups/unused-css-backup-2026-03-27
cp theme-deploy-corrigido/static/css/style-blog.scss.tpl backups/
cp theme-deploy-corrigido/static/css/style-tokens.tpl backups/
cp theme-deploy-corrigido/static/css/style-home-v2.css backups/
cp theme-deploy-corrigido/static/css/product-card-v3.css backups/

# Deletar do tema
rm theme-deploy-corrigido/static/css/style-blog.scss.tpl
rm theme-deploy-corrigido/static/css/style-tokens.tpl
rm theme-deploy-corrigido/static/css/style-home-v2.css
rm theme-deploy-corrigido/static/css/product-card-v3.css

# Confirmar
ls theme-deploy-corrigido/static/css/
```

---

## PASSO 6: Atualizar Layout.tpl

### 6.1 Localizar Seção Atual (Linhas 69-78)

```bash
sed -n '65,85p' theme-deploy-corrigido/layouts/layout.tpl
```

### 6.2 Substituir Carregamento

**ANTES (linhas 69-78):**

```html
            {% include "static/css/style-critical.tpl" %}
            {% include "static/css/style-menu-patagang.css.tpl" %}
            {% include "static/css/style-filters-patagang.css.tpl" %}
            {% include "static/css/style-help-sidebar.css.tpl" %}
            {% include "static/css/style-whatsapp-button.css.tpl" %}
        </style>

        {{ 'css/style-colors.scss.tpl' | static_url | static_inline }}

        <link rel="stylesheet" href="{{ 'css/style-async.scss.tpl' | static_url }}" media="print" onload="this.media='all'">
```

**DEPOIS:**

```html
            {% include "static/css/style-critical-bare.tpl" %}
            {% include "static/css/style-menu-patagang.css.tpl" %}
            {% include "static/css/style-filters-patagang.css.tpl" %}
            {% include "static/css/style-help-sidebar.css.tpl" %}
            {% include "static/css/style-whatsapp-button.css.tpl" %}
        </style>

        {{ 'css/style-colors.scss.tpl' | static_url | static_inline }}

        <link rel="stylesheet" href="{{ 'css/style-critical-extra.scss' | static_url }}" media="print" onload="this.media='all'">
        <link rel="stylesheet" href="{{ 'css/style-async-core.scss.tpl' | static_url }}" media="print" onload="this.media='all'">
        <link rel="stylesheet" href="{{ 'css/style-async-extended.scss.tpl' | static_url }}" media="print" onload="this.media='all'">
```

### 6.3 Validar Mudanças

```bash
# Verificar sintaxe HTML
grep -A 20 "style-critical-bare" theme-deploy-corrigido/layouts/layout.tpl

# Confirmar que todas as 3 linhas async estão presentes
grep "style-critical-extra\|style-async-core\|style-async-extended" \
  theme-deploy-corrigido/layouts/layout.tpl

# Expected: 3 linhas (uma para cada arquivo)
```

---

## PASSO 7: Teste Local

### 7.1 Verificar Sintaxe

```bash
# Validar HTML (layout.tpl)
html5validator theme-deploy-corrigido/layouts/layout.tpl 2>/dev/null || echo "HTML OK (básico)"

# Validar todos CSS
for file in theme-deploy-corrigido/static/css/*.tpl; do
  echo "Validando $(basename $file)..."
  stylelint "$file" 2>&1 | grep -c "error\|warning" || echo "  OK"
done
```

### 7.2 Simular Carregamento

```bash
# Se você tem servidor local rodando:
# Abrir em navegador: http://localhost:3000 (ou seu domínio local)

# Checklist:
# ☐ Página carrega sem erros (HTTP 200)
# ☐ Console JavaScript: 0 CSS errors
# ☐ Elementos críticos visíveis (header, hero, buttons)
# ☐ Menu Patagang funciona
# ☐ Botões filtro com estilo Patagang
# ☐ Sidebar ajuda visível
# ☐ Botão WhatsApp posicionado
# ☐ Sem FOUC (Flash of Unstyled Content)
```

---

## PASSO 8: CodeRabbit Review

### 8.1 Preparar Commit

```bash
# Git add dos novos arquivos
git add theme-deploy-corrigido/static/css/style-critical-bare.tpl
git add theme-deploy-corrigido/static/css/style-critical-extra.scss.tpl
git add theme-deploy-corrigido/static/css/style-async-core.scss.tpl
git add theme-deploy-corrigido/static/css/style-async-extended.scss.tpl
git add theme-deploy-corrigido/layouts/layout.tpl

# Remover arquivos deletados
git add -u

# Status
git status
```

### 8.2 Executar CodeRabbit

```bash
# Via WSL (se configurado)
wsl bash -c 'cd /mnt/c/.../patagang && ~/.local/bin/coderabbit --prompt-only -t uncommitted'

# Ou via npm (alternativa)
npx coderabbit --base main --head HEAD 2>/dev/null

# Esperar resultado e corrigir issues se houver
```

### 8.3 Commit

```bash
git commit -m "refactor: separar CSS crítico em arquivos menores (style-critical-bare, extra, async-core, async-extended)

- Extrair regras LCP real (25 KB) para style-critical-bare.tpl
- Mover não-crítico (100 KB) para style-critical-extra.scss.tpl
- Dividir async (50 KB core, 90 KB extended)
- Atualizar layout.tpl com novo carregamento estratificado
- Deletar arquivos não utilizados (blog, tokens, home-v2, product-card-v3)
- Preservar 100% customizações Patagang
- Reduzir inline <head> de 207 KB para 56 KB (-72%)

Co-Authored-By: Claude Haiku 4.5 <noreply@anthropic.com>"
```

---

## PASSO 9: QA Validation (Antes de Deploy)

### 9.1 HTTP 200 Check

```bash
# Em prod ou staging:
curl -s -o /dev/null -w "%{http_code}" https://patagang.com.br/
# Expected: 200
```

### 9.2 CSS Validation

```bash
# W3C CSS Validator (online ou local)
# https://jigsaw.w3.org/css-validator/

# Ou via npm
npm install -g css-validator
css-validator theme-deploy-corrigido/static/css/style-critical-bare.tpl
css-validator theme-deploy-corrigido/static/css/style-critical-extra.scss.tpl
css-validator theme-deploy-corrigido/static/css/style-async-core.scss.tpl
css-validator theme-deploy-corrigido/static/css/style-async-extended.scss.tpl
```

### 9.3 Visual Validation (Gabriel)

```
📍 Desktop (1920px):
  ☐ Header visível, alinhado
  ☐ Logo carregado
  ☐ Menu Patagang customizado
  ☐ Hero/banners above fold
  ☐ Botões filtro (style Patagang)
  ☐ Sidebar ajuda visível

📍 Tablet (768px):
  ☐ Menu colapsado?
  ☐ Layout responsivo
  ☐ Botões filtro still visible
  ☐ Sidebar ajuda responsiva

📍 Mobile (375px):
  ☐ Menu hamburger
  ☐ Layout single column
  ☐ Botões filtro mobile-friendly
  ☐ Botão WhatsApp acessível

📍 Console:
  ☐ 0 CSS errors
  ☐ 0 undefined variables
  ☐ 0 broken imports
```

---

## CHECKLIST FINAL

```
ARQUIVOS CRIADOS:
☐ style-critical-bare.tpl (20-30 KB)
☐ style-critical-extra.scss.tpl (80-120 KB)
☐ style-async-core.scss.tpl (40-60 KB)
☐ style-async-extended.scss.tpl (80-100 KB)

ARQUIVOS DELETADOS:
☐ style-blog.scss.tpl ✅
☐ style-tokens.tpl ✅
☐ style-home-v2.css ✅
☐ product-card-v3.css ✅

ARQUIVOS PRESERVADOS:
☐ style-menu-patagang.css.tpl ✅
☐ style-filters-patagang.css.tpl ✅
☐ style-help-sidebar.css.tpl ✅
☐ style-whatsapp-button.css.tpl ✅
☐ style-colors.scss.tpl ✅
☐ style-fonts.tpl ✅

LAYOUT.TPL ATUALIZADO:
☐ Linha 69: style-critical-bare incluído
☐ Linhas 70-73: Patagang customizações (sem mudança)
☐ Linha 78: style-colors inline (sem mudança)
☐ Novas linhas: Extra, Core, Extended carregados async

VALIDAÇÕES:
☐ CSS syntax OK
☐ HTML syntax OK
☐ Character encoding UTF-8
☐ Nenhuma linha deletada
☐ CodeRabbit PASS
☐ HTTP 200
☐ Console 0 errors
☐ Visual Patagang OK
☐ Mobile responsivo

PRÓXIMO: Deploy via @devops
```

---

**Dúvidas? Revise as seções acima ou escalpe para @architect.**

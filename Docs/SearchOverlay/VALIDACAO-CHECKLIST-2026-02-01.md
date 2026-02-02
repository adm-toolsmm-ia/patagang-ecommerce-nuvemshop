# ✅ Checklist de Validação - Search Overlay 01/02/2026

**Versão:** `2026-02-01T22-51-09-B374798F`
**Data Validação:** ___/___/2026
**Validador:** ___________________

---

## 📋 PRÉ-VALIDAÇÃO

### Sistema
- [ ] Acesso ao painel admin Nuvemshop: https://www.nuvemshop.com.br/admin
- [ ] Acesso via FTP: ftp.nuvemshop.com.br (usuário: patagang)
- [ ] Versão atual visível: `2026-02-01T22-51-09-B374798F`
- [ ] Browser atualizado (Chrome 120+, Firefox 121+, Safari 17+)
- [ ] Cache do navegador limpo (Ctrl+Shift+Delete)

---

## 🖥️ VALIDAÇÃO DESKTOP (> 1024px)

### Header & Trigger
- [ ] Ícone 🔍 visível no header (lado direito das ações)
- [ ] Ícone tem mesmo tamanho dos ícones perfil/sacola
- [ ] Hover no ícone muda cor/opacidade
- [ ] Cursor muda para "pointer" ao passar mouse

### Overlay Abrir
- [ ] Clicar ícone 🔍 → overlay abre
- [ ] Overlay tem backdrop semi-transparente (rgba 0,0,0,0.4)
- [ ] Animação slide-down suave (~250ms)
- [ ] Input focado automaticamente
- [ ] Teclado aparece com cursor no input

### Overlay Layout
- [ ] Topbar com botão "Fechar" e X
- [ ] Input search centralizado com ícone 🔍 no final
- [ ] **2 colunas visíveis lado a lado:**
  - Esquerda: "LANÇAMENTOS" (tags/categorias)
  - Direita: "DESTAQUES" (carrossel produtos)
- [ ] Sem scroll horizontal indesejado
- [ ] Sem overlap de elementos

### Seção "LANÇAMENTOS"
- [ ] Título "LANÇAMENTOS" em uppercase
- [ ] Se houver produtos com tag "lançamento":
  - [ ] Mostra lista clicável dos produtos
  - [ ] Nomes truncados em ~30 caracteres
  - [ ] Hover: muda cor/opacidade
- [ ] Se NÃO houver tag "lançamento":
  - [ ] Mostra categorias fallback (chips):
    - Novidades
    - Em Alta
    - Exclusivos
    - Ofertas do Mês
    - Trending Now
    - Best Sellers
  - [ ] Chips têm border e background semi-transparente
  - [ ] Hover: muda background color
- [ ] Clickável: ao clicar → preenche input + dispara busca AJAX

### Seção "DESTAQUES"
- [ ] Título "DESTAQUES" em uppercase
- [ ] Carrossel horizontal com scroll-snap
- [ ] Até 8 produtos (max)
- [ ] Cada card tem:
  - [ ] Imagem (160x160px)
  - [ ] Nome do produto (2 linhas max)
  - [ ] Preço formatado (R$ X.XX)
  - [ ] Hover: elevação (+2px translateY)
- [ ] Se vazio: mensagem "Produtos em breve..."
- [ ] Scroll mouse wheel: carrossel desce/sobe
- [ ] Touch/touchpad: carrossel desliza

### Busca AJAX
- [ ] Digitar "coleira" → sugestões aparecem em < 500ms
- [ ] Sugestões substituem "LANÇAMENTOS" + "DESTAQUES"
- [ ] Cada sugestão mostra:
  - [ ] Imagem do produto (48x48px)
  - [ ] Nome destacado com termo buscado em bold
  - [ ] Preço
  - [ ] Ícone chevron-right
- [ ] "Ver todos os resultados" link no final
- [ ] Clicar produto sugestão → vai para PDP

### Busca Limpar
- [ ] Apagar texto input → sugestões desaparecem
- [ ] Volta "LANÇAMENTOS" + "DESTAQUES"
- [ ] Sem lag ou delay

### Fechar Overlay
- [ ] Clicar botão "Fechar" → overlay fecha
- [ ] Clicar backdrop (área escura) → overlay fecha
- [ ] Pressionar ESC → overlay fecha
- [ ] Após fechar:
  - [ ] Input vazio
  - [ ] Body sem scroll-lock
  - [ ] Focus volta para ícone 🔍 (ou body)

### Acessibilidade Desktop
- [ ] Tab navigation funciona
- [ ] Input tem aria-label
- [ ] Botão fechar tem aria-label
- [ ] Overlay tem role="dialog"
- [ ] Esc fecha (esperado em dialogs)

---

## 📱 VALIDAÇÃO MOBILE (< 768px)

### Header & Trigger
- [ ] Ícone 🔍 visível em mobile
- [ ] Ícone tem altura mínima 44px (toque confortável)
- [ ] Touch feedback visível

### Overlay Mobile Abrir
- [ ] Toque ícone 🔍 → overlay abre fullscreen
- [ ] Ocupa 100% da viewport (altura, largura)
- [ ] Input focado automaticamente
- [ ] Teclado virtual aparece (móvel real)

### Overlay Mobile Layout
- [ ] Topbar: X grande no topo direito
- [ ] Input search ocupa largura com padding confortável
- [ ] Conteúdo faz scroll vertical (não horizontal)
- [ ] Sem overlap com teclado virtual

### Seção "LANÇAMENTOS" (Mobile)
- [ ] Título "LANÇAMENTOS"
- [ ] Tags/categorias em **chips horizontais scrolláveis**
  - [ ] Cada chip: border + background
  - [ ] Padding confortável (8px 16px)
  - [ ] Scroll horizontal smooth
  - [ ] Scrollbar hidden
- [ ] Clicável
- [ ] Cabe 2-3 chips por linha

### Seção "DESTAQUES" (Mobile)
- [ ] Carrossel vertical scroll (não horizontal)
- [ ] Imagem 130x130px (menor que desktop)
- [ ] Nome + preço legíveis
- [ ] Carrossel scrollável com dedo
- [ ] Sem scroll horizontal

### Busca AJAX (Mobile)
- [ ] Digitar → sugestões AJAX aparecem
- [ ] Sugestões full-width
- [ ] Scrollável verticalmente
- [ ] Elementos clicáveis com touch-target > 44px

### Fechar Overlay (Mobile)
- [ ] Toque X → fecha
- [ ] Swipe down → fecha (opcional, não testado)
- [ ] ESC → fecha
- [ ] Body volta ao normal

### Responsividade Intermediária (Tablet ~1024px)
- [ ] Transição suave entre desktop (2 col) e mobile (stack)
- [ ] Breakpoint em 768px funciona corretamente
- [ ] Layout não quebra em tamanhos intermediários

---

## 🎨 VISUAL & DESIGN

### Cores & Tipografia
- [ ] Fundo overlay: #E2E2E2 (cinza claro)
- [ ] Título "LANÇAMENTOS" / "DESTAQUES": uppercase, bold
- [ ] Input placeholder: "O que você procura?"
- [ ] Fonte: Familjen Grotesk (ou fallback sans-serif)

### Espaçamento & Padding
- [ ] Form wrapper: padding simétrico
- [ ] Tags: gap 4px (desktop) ou 8px (mobile)
- [ ] Produtos carousel: gap 16px
- [ ] Topbar: padding confortável

### Imagens
- [ ] Produtos: carregam com "lazy loading"
- [ ] Alt tags presentes (acessibilidade)
- [ ] Nenhuma imagem quebrada (404)
- [ ] Proporção 1:1 mantida (quadradas)

### Animações
- [ ] Slide-down ao abrir: suave, ~250ms
- [ ] Hover em tags: opacity/color change
- [ ] Hover em products: slight lift (+2px)
- [ ] Sem jank/lag visível

---

## ⚡ PERFORMANCE

### Carregamento
- [ ] Overlay abre em < 200ms
- [ ] AJAX sugestões em < 500ms
- [ ] Sem congelamento de tela

### Console (F12 → Console)
- [ ] Sem erros vermelhos
- [ ] Sem warnings amarelos (tolerar warnings do Nuvemshop)
- [ ] Sem uncaught promises

### Network (F12 → Network)
- [ ] Nenhuma requisição falhada (404)
- [ ] Sem requisições desnecessárias
- [ ] Tamanho do overlay < 50KB

### Memoria (F12 → Memory)
- [ ] Abrir/fechar overlay 5x
- [ ] Memoria não cresce indefinidamente
- [ ] Sem memory leaks visíveis

---

## 🔗 INTEGRAÇÃO NUVEMSHOP

### Dados Dinâmicos - Destaques
- [ ] Produtos vêm de "Seções → Produtos em Destaque" do admin
- [ ] Se nenhum configurado: mostra "Produtos em breve..."
- [ ] Se > 8 produtos: mostra apenas 8
- [ ] Imagens carregam corretamente
- [ ] Links produto funcionam (→ PDP)

### Dados Dinâmicos - Lançamentos
- [ ] ✅ Se houver produtos com tag "lançamento":
  - [ ] Mostra produtos tagueados
  - [ ] Nomes e links corretos
- [ ] ✅ Se NÃO houver tag "lançamento":
  - [ ] Fallback automático mostra categorias
  - [ ] Clique categoria → vai para busca: store.search_url?q=categoria

### AJAX Search (LS.search)
- [ ] Suggestões carregam do template correto
- [ ] Sugestões renderizam com classe correta
- [ ] "Ver todos os resultados" funciona
- [ ] Highlight do termo buscado aparece

### Tradução (i18n)
- [ ] "Buscar" em português (do | translate)
- [ ] Placeholder "O que você procura?"
- [ ] "Ver todos os resultados" em português

---

## 🔐 SEGURANÇA & XSS

- [ ] Inputs sanitizados (url_encode)
- [ ] Nomes de produtos truncados (truncate)
- [ ] Alt tags escapados (img_tag)
- [ ] Sem inline scripts perigosos
- [ ] Sem SQL injection risk (template)

---

## 🌐 CROSS-BROWSER

### Desktop
- [ ] Chrome 120+ ✅
- [ ] Firefox 121+ ✅
- [ ] Safari 17+ ✅
- [ ] Edge 120+ ✅

### Mobile
- [ ] iOS Safari 17+ ✅
- [ ] Chrome Mobile ✅
- [ ] Firefox Mobile ✅
- [ ] Samsung Internet ✅

---

## 🐛 EDGE CASES

### Casos Extremos a Testar
- [ ] Muito poucos produtos (0-1): ok
- [ ] Muitos produtos (100+): performance ok
- [ ] Nomes muito longos: truncate funciona
- [ ] Preços com muitos decimais: formata bem
- [ ] Produtos sem imagem: fallback funciona
- [ ] Seção vazia: "Produtos em breve..." mostra
- [ ] Tag "lançamento" inválida/não existe: fallback mostra

### Comportamentos Especiais
- [ ] Offline: overlay abre, busca falha gracefully
- [ ] Zoom 200%: ainda funciona
- [ ] Landscape mobile: layout adapta
- [ ] Dark mode (se aplicável): contraste ok

---

## 📊 ANALYTICS (Opcional)

- [ ] Google Analytics rastreia cliques em overlay
- [ ] Eventos de busca registrados
- [ ] CTR "Destaques" vs "Lançamentos" visível

---

## 🚀 RESULTADO FINAL

**Data Validação:** ___/___/2026
**Testador:** ___________________
**Total Checklist:** ___ / ___ itens ✅

### Status
- [ ] ✅ PASSOU (todos itens com check)
- [ ] ⚠️ PASSOU COM RESSALVAS (alguns itens, descrever abaixo)
- [ ] ❌ FALHOU (muitos itens sem check, não deploy)

### Ressalvas / Problemas Encontrados
```
_________________________________________________________________________

_________________________________________________________________________

_________________________________________________________________________
```

### Próximos Passos
1. [ ] Se ✅ PASSOU: liberar para produção
2. [ ] Se ⚠️: documentar e criar ticket para ajustes
3. [ ] Se ❌: fazer rollback e investigar

### Rollback (se necessário)
```bash
cd ftp-deploy/
node rollback-incremental.js 2026-02-01T22-50-59
```

---

**Validação Concluída! 🎉**

Versão: `2026-02-01T22-51-09-B374798F`

# 📋 Validação ETAPA 1 — Story 8.2 (v1.5.100)

**Data Deploy:** 2026-03-25
**Versão:** v1.5.100
**Story:** 8.2 — Critical CSS Reduction
**ETAPA:** 1 — Gallery Modal CSS → Async
**O que mudou:** CSS do modal de galeria foi movido de critical para async (não bloqueia render inicial)

---

## ✅ **Checklist de Validação**

Siga os passos abaixo para validar a ETAPA 1. Tudo deve passar ✅.

### **1️⃣ Verificar Versão em Produção** (1 min)

1. Abra **https://patagang.com.br/** no navegador
2. Abra o **Console** (F12 ou Cmd+Option+J)
3. Procure pela mensagem: **`📦 PATAGANG v1.5.100`**
4. ✅ Se a mensagem aparecer = versão correct ✅

**Se não aparecer:**
- Limpe cache forçadamente: `Ctrl+Shift+Delete` (Windows) ou `Cmd+Option+E` (Mac)
- Feche completamente o navegador e reabra
- Se persistir: rollback (instruções no final)

---

### **2️⃣ Testar Gallery Modal — Desktop** (3 min)

#### Passo 1: Navegar até uma página de produto
1. Vá para: https://patagang.com.br/
2. Procure por qualquer produto na home (pode ser qualquer um)
3. Clique em um produto para abrir a **PDP (Product Detail Page)**

#### Passo 2: Abrir a galeria modal
1. Na PDP, **clique em qualquer foto do produto** (thumbnail)
2. ✅ **Esperado:** O modal da galeria abre com:
   - Fundo escuro (overlay preto) em toda a tela
   - Imagem grande do produto no centro
   - **Sidebar esquerda** com thumbnails pequenas (80px)
   - Botões **prev/next** (setas) dos dois lados
   - Botão **close** (X) no canto superior direito
   - Contador de imagens (ex: "1/4") na base

3. ❌ **Se não funcionar:** Não toque! Vá para rollback (final)

#### Passo 3: Testar interações do modal
1. **Clique em uma thumbnail** na sidebar → imagem principal muda ✅
2. **Clique em prev** (seta esquerda) → volta para imagem anterior ✅
3. **Clique em next** (seta direita) → avança para próxima imagem ✅
4. **Clique no X** (close button) → modal fecha ✅
5. **Clique no fundo escuro** (overlay) → modal fecha ✅

**Resultado esperado:** Tudo funciona suavemente, sem bugs

---

### **3️⃣ Testar Gallery Modal — Mobile** (3 min)

#### Passo 1: Redimensionar para mobile
1. **F12** (Developer Tools)
2. Clique em **Toggle Device Toolbar** (ícone de celular) ou `Ctrl+Shift+M`
3. Selecione **iPhone 12** ou **Pixel 5** (tamanho típico mobile: ~375px)

#### Passo 2: Navegar até PDP em mobile
1. Na home (mobile view): procure por um produto
2. Clique para abrir PDP em mobile

#### Passo 3: Verificar galeria em mobile
1. **Clique em uma foto** → modal abre ✅
2. **Em mobile:** Esperado:
   - **Sidebar desaparece** (não visível em mobile)
   - Imagem ocupa tela inteira (com espaço para close button)
   - Botões prev/next menores (32px vs 36px desktop)
   - Tudo toca bem (no overlap de elementos)

3. ✅ **Testar:** prev, next, close button funcionam ✅

#### Passo 4: Testar Swiper (carrossel)
- Em mobile, gallery modal não deveria ser usada normalmente (Swiper é principal)
- Mas se usuário clicar em foto na Swiper, modal abre ✅

---

### **4️⃣ Visual - Sem Flashing (FOUC Check)** (2 min)

1. Recarregue a página: **F5** (normal reload) OU **Ctrl+Shift+R** (hard reload)
2. Observe a página carregando
3. ✅ **Esperado:**
   - Nenhum flashing de layout
   - Galeria não aparece/desaparece abruptamente
   - Imagens das fotos carregam suavemente
   - Texts e buttons já estilizados desde o início

4. ❌ **Se houver flashing ou FOUC:**
   - Modal gallery layout aparecendo/desaparecendo abruptamente
   - Imagens sem estilo enquanto carregam
   - Buttons desalinhados no início
   - → Indica que CSS async NÃO carregou corretamente → rollback

---

### **5️⃣ Console — Zero Erros** (1 min)

1. Abra **Developer Tools: Console** (F12)
2. Procure por **erros vermelhos** ou **warnings amarelos** relacionados a CSS
3. ✅ Esperado: **Zero erros CSS** relacionados a `pg-modal-*`, `pg-gallery-*`, `pg-nav-btn`

**Possível warnings (OK):**
- Loaded from browser cache (normal)
- Mixed content (se HTTP vs HTTPS)
- Unrelated deprecated API warnings

**NÃO OK — Erros que indicam problema:**
- `Cannot find rule .pg-modal-*`
- `Unknown CSS property in modal`
- `CSS parsing error`

---

### **6️⃣ Performance — Lighthouse** (2 min - OPCIONAL)

1. **F12** → **Lighthouse** tab
2. Selecione: **Mobile** (ou Desktop)
3. Clique **Analyze page load**
4. Aguarde ~30 segundos

**Esperado:**
- Performance score **SAME ou BETTER** que antes (não piora)
- LCP (Largest Contentful Paint) < 3 segundos

**Se piorar muito (>5% de degradação):**
- CSS async não carregou a tempo
- → Rollback

---

## 📊 **Resultado Final**

### ✅ **Se TODOS os testes passarem:**

1. Abra a story: `docs/stories/8.2-critical-css-reduction.story.md`
2. Comenta ou envie mensagem confirmando:
   - **"✅ v1.5.100 validado em produção — galeria modal funciona perfeito"**

3. Dev continuará com **ETAPA 2** (Filters/Sort CSS → async, deploy v1.5.101)

### ⚠️ **Se ALGUM teste falhar:**

**Opção A — Rollback Rápido (SEGURO):**
```bash
# Execute este comando para voltar à versão anterior (v1.5.99)
node ftp-deploy/rollback-incremental.js --version v1.5.99
```

**Depois:**
1. Confirme em produção: **📦 PATAGANG v1.5.99** aparece no console
2. Teste novamente → galeria deve funcionar como antes
3. Avise ao dev: "v1.5.100 teve problema em [X] — rollback feito"
4. Dev investigará root cause

---

## 🔍 **FAQ de Validação**

### P: "Modal não abre quando clico na foto"
**R:** Pode ser JavaScript desabilitado ou CSS não carregou. Verifique:
1. Console (F12) → há erros?
2. Limpe cache forçadamente: Ctrl+Shift+Delete
3. Se persistir → rollback

### P: "Sidebar (thumbnails) não aparece no desktop"
**R:** Esperado! Sidebar só aparece em breakpoint 768px+. Testar:
1. Redimensione janela para >768px
2. Reload (F5)
3. Clique em foto novamente → sidebar deveria aparecer

### P: "Imagens carregam lentas no modal"
**R:** É esperado que imagens levem um tempo (são pesadas). Checklist:
1. Isso é esperado? (comparar com v1.5.99)
2. Se piorou muito → pode ser CSS loading delay → rollback
3. Se igual → OK, não é problema do deploy

### P: "Mobile Swiper carrossel não funciona"
**R:** Swiper é código JavaScript separado, não afetado por ETAPA 1 (CSS gallery). Se quebrou:
1. Provavelmente não relacionado ao deploy ETAPA 1
2. Verifique console para erros JavaScript
3. Rollback se suspeita

### P: "Console mostra aviso sobre CSS cache"
**R:** Normal. Browser cache é esperado. Limpar cache:
- Windows: Ctrl+Shift+Delete
- Mac: Cmd+Shift+Delete
- Ou: DevTools → Settings → Cache disabled (enquanto open)

---

## 📞 **Se Precisar de Ajuda**

1. **Não claro o que testar?** → Releia "Checklist de Validação" acima
2. **Encontrou bug?** → Use rollback (acima) e avise dev
3. **Tudo OK?** → Confirme no story e prosseguir para ETAPA 2

---

## 🚀 **Resumo Executivo**

| Item | Status |
|------|--------|
| Versão | v1.5.100 |
| O que mudou | Gallery Modal CSS moved to async |
| Onde testar | https://patagang.com.br/ (qualquer PDP) |
| Tempo de validação | ~15 min total |
| Risco | MUITO BAIXO (CSS apenas, zero JavaScript changes) |
| Rollback | Sempre disponível via `rollback-incremental.js` |

---

**✅ Pronto para validar? Comece pelo Passo 1 acima!**

— Dex, sempre construindo 🔨

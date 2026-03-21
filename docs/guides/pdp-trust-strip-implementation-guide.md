# Guia Prático — Implementação Trust-Strip PDP
**Para:** @dev (Dex)
**Duração:** 45-60 minutos
**Dificuldade:** ⭐ Muito fácil (copiar/colar + testar)

---

## 🎯 O Que Fazer

Adicionar a seção **product-trust-strip** (4 itens de confiança) que está **faltando** em `product.tpl`.

### Resultado Final:
```
[HEADER]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎁 3% DOADO | 🚚 FRETE GRÁTIS | 🛡️ SEGURO | ↩️ 30 DIAS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
[IMAGEM DO PRODUTO | PREÇO/TAMANHO/BOTÃO]
```

---

## 📋 Passo 1: Abrir Arquivo

```bash
# Navegar até o projeto
cd ~/documents/solucoessistemas/patagang-ecommerce-nuvemshop

# Abrir arquivo
code theme-deploy-corrigido/templates/product.tpl

# OU usar seu editor preferido (VS Code, Sublime, etc)
```

---

## 📝 Passo 2: Localizar Ponto de Inserção

Procure por esta linha:
```tpl
<div class="row section-single-product g-0">
```

### Usando VS Code:
```
Ctrl+F (ou Cmd+F no Mac)
Procurar: "section-single-product"
Enter
```

**Você deve encontrar:**
```tpl
{# Informative Banner #}
{% include 'snipplets/product/product-informative-banner.tpl' %}

<div class="row section-single-product g-0">    ← VOCÊ ESTÁ AQUI
    <div class="col-12 col-lg-7 pg-pdp-image-col">
        ...
```

---

## ✂️ Passo 3: Copiar HTML da Trust-Strip

Copie TODO este bloco (exatamente como está):

```tpl
{# ===== TRUST STRIP (4 itens de confiança) ===== #}
<div class="pg-trust-strip">
    <div class="pg-trust-strip__content">
        <span class="pg-trust-strip__item">
            🎁 3% DO PEDIDO DOADO PARA EDUCAÇÃO
        </span>
        <span class="pg-trust-strip__item">
            🚚 FRETE GRÁTIS ACIMA DE R$250
        </span>
        <span class="pg-trust-strip__item">
            🛡️ SEGURO COMPRADOR 100%
        </span>
        <span class="pg-trust-strip__item">
            ↩️ 30 DIAS PARA TROCA
        </span>
    </div>
</div>
{# ===== FIM TRUST STRIP ===== #}
```

---

## 🔧 Passo 4: Colar no Arquivo

**IMPORTANTE:** Colar **ANTES** da linha `<div class="row section-single-product g-0">`

Seu arquivo deve ficar assim:

```tpl
{# Informative Banner #}
{% include 'snipplets/product/product-informative-banner.tpl' %}

{# ===== TRUST STRIP (4 itens de confiança) ===== #}
<div class="pg-trust-strip">
    <div class="pg-trust-strip__content">
        <span class="pg-trust-strip__item">
            🎁 3% DO PEDIDO DOADO PARA EDUCAÇÃO
        </span>
        <span class="pg-trust-strip__item">
            🚚 FRETE GRÁTIS ACIMA DE R$250
        </span>
        <span class="pg-trust-strip__item">
            🛡️ SEGURO COMPRADOR 100%
        </span>
        <span class="pg-trust-strip__item">
            ↩️ 30 DIAS PARA TROCA
        </span>
    </div>
</div>
{# ===== FIM TRUST STRIP ===== #}

<div class="row section-single-product g-0">
    <div class="col-12 col-lg-7 pg-pdp-image-col">
        ...
```

**Salvar arquivo:** `Ctrl+S`

---

## 🧪 Passo 5: Testar em Browser

### 5.1 Build (se necessário)
```bash
# Se seu tema usa build/webpack:
npm run build

# Esperar build terminar (será rápido)
```

### 5.2 Abrir Página
```
https://www.patagang.com.br/produtos/patagang-jui-street-camiseta-protetores/
(ou qualquer página de produto)
```

### 5.3 Validar Visualmente

**Desktop (1920px+):**
```
Procurar por:
  ✅ Linha com 4 itens lado-a-lado?
  ✅ "3% DO PEDIDO DOADO" aparece?
  ✅ "FRETE GRÁTIS" aparece?
  ✅ "SEGURO COMPRADOR" aparece?
  ✅ "30 DIAS" aparece?
  ✅ Entre o header e a imagem do produto?
  ✅ Com linha horizontal acima e abaixo?
```

**Mobile (< 600px):**
```
DevTools > Responsive Design Mode (Ctrl+Shift+M)
Procurar por:
  ✅ Grid 2x2 (2 colunas)?
    Coluna esquerda: 3% DOADO | FRETE GRÁTIS
    Coluna direita: SEGURO | 30 DIAS
  ✅ Sem overflow/truncamento?
  ✅ Legível no tamanho pequeno?
```

### 5.4 Verificar CSS no Console

```javascript
// Abrir DevTools (F12)
// Aba Console
// Colar e executar:

const stripe = document.querySelector('.pg-trust-strip');
console.log('Trust-strip existe?', !!stripe);
console.log('Trust-strip visível?', window.getComputedStyle(stripe).display);
console.log('Items:', document.querySelectorAll('.pg-trust-strip__item').length);

// Esperado:
// Trust-strip existe? true
// Trust-strip visível? block
// Items: 4
```

---

## 🎨 Customizar Conteúdo (Opcional)

Se quiser mudar os textos dos 4 items:

**Opção 1: Sem emojis (minimalista)**
```tpl
<span class="pg-trust-strip__item">3% DOADO PARA EDUCAÇÃO</span>
<span class="pg-trust-strip__item">FRETE GRÁTIS EM PEDIDOS ACIMA DE R$250</span>
<span class="pg-trust-strip__item">SEGURO COMPRADOR 100%</span>
<span class="pg-trust-strip__item">30 DIAS PARA TROCAR</span>
```

**Opção 2: Com emojis (mais visual)**
```tpl
<span class="pg-trust-strip__item">🎁 3% DOADO PARA EDUCAÇÃO</span>
<span class="pg-trust-strip__item">🚚 FRETE GRÁTIS ACIMA DE R$250</span>
<span class="pg-trust-strip__item">🛡️ SEGURO COMPRADOR 100%</span>
<span class="pg-trust-strip__item">↩️ 30 DIAS PARA TROCAR</span>
```

**Opção 3: Com badges HTML**
```tpl
<span class="pg-trust-strip__item">
  <span class="badge">3%</span> DOADO PARA EDUCAÇÃO
</span>
```

**CSS já está pronto para qualquer conteúdo!**

---

## ✅ Checklist de Validação

- [ ] Arquivo aberto: `product.tpl`
- [ ] HTML trust-strip localizado (antes de `section-single-product`)
- [ ] Arquivo salvo (`Ctrl+S`)
- [ ] Build executado (se necessário)
- [ ] Página recarregada no browser
- [ ] Desktop: 4 items lado-a-lado ✅
- [ ] Mobile: grid 2x2 ✅
- [ ] Espaço vazio à direita desapareceu ✅
- [ ] Header não invade mais ✅
- [ ] Nenhum erro no console ✅

---

## 🐛 Solução de Problemas

### Problema: "Trust-strip não aparece"
**Solução:**
1. Verificar se HTML foi colado **ANTES** de `<div class="row section-single-product">`
2. Verificar se arquivo foi **SALVO** (icon branco em VS Code = não salvo)
3. Browser cache: `Ctrl+Shift+R` (força reload sem cache)
4. Build pode estar desatualizado: `npm run build` novamente

---

### Problema: "Trust-strip aparece mas muito pequeno/ilegível"
**Solução:**
CSS está definido com `font-size: 11px` — é intencional (minimalista).

Se quiser aumentar:
```css
.pg-trust-strip__item {
    font-size: 13px; /* ao invés de 11px */
}
```

Mas provavelmente está OK como está!

---

### Problema: "Emojis aparecem estranho"
**Solução:**
Remover emojis, usar versão sem:
```tpl
<span class="pg-trust-strip__item">3% DOADO</span>
```

---

### Problema: "Layout mobile não é grid 2x2"
**Solução:**
CSS mobile está em `style-critical.tpl` (linhas 4945-4974).

Verificar que browser está em modo mobile:
```
DevTools > Toggle Device Toolbar (Ctrl+Shift+M)
Recarregar página (Ctrl+R)
```

Se ainda não funcionar, CSS pode estar sobrescrito. Procurar em `product-styles.css` por:
```css
.pg-trust-strip__content {
    display: flex !important; /* Este !important pode estar errado */
}
```

Se encontrar, remover o `!important` da media query.

---

## 📊 Antes vs. Depois

### ANTES (Quebrado)
```
┌─ HEADER ─────────────────────────────────────┐
│                                               │
└───────────────────────────────────────────────┘
┌─ [IMAGEM] │ [PREÇO/TAMANHO/BOTÃO]  │ [VAZIO] ┐
│           │                         │         │
│           │     ← Header invade aqui!         │
│           │                         │ VAZIO   │
│           │                         │ ← Aqui  │
└───────────────────────────────────────────────┘
```

### DEPOIS (Corrigido)
```
┌─ HEADER ──────────────────────────────────────┐
│                                                │
└────────────────────────────────────────────────┘
┌─ 🎁 3% │ 🚚 FRETE │ 🛡️ SEGURO │ ↩️ 30 DIAS ─┐
└────────────────────────────────────────────────┘
┌─ [IMAGEM] │ [PREÇO/TAMANHO/BOTÃO] │[SHIPPING] ┐
│           │                       │           │
│           │                       │           │
│           │                       │           │
└────────────────────────────────────────────────┘
```

---

## 🎯 Próximos Passos Após Validação

1. ✅ Testar em todas as páginas de produto
2. ✅ Testar em desktop + tablet + mobile
3. ✅ DevTools console: nenhum erro
4. ✅ Se tudo OK: comunicar para @qa que está pronto

---

## 💡 Notas Técnicas

### Por que faltava?
O arquivo `product.tpl` **nunca teve** essa seção implementada.
CSS estava pronto em `style-critical.tpl` desde o início, mas **órfão** (sem HTML).

### Impacto de Nuvemshop Constraints?
**NENHUM** — você está apenas adicionando uma seção de confiança, não tocando:
- ✅ Checkout (intacto)
- ✅ Footer (intacto)
- ✅ Formulários (intactos)
- ✅ Dados do produto (intactos)

---

## 📞 Se Tiver Dúvidas

- **Técnicas:** Contate @architect
- **CSS:** Contate @dev mais experiente
- **Decisões:** Contate Gabriel

---

**Pronto para começar? Boa sorte! 🚀**

---

*Guia de Implementação — Trust-Strip PDP*
*Simplicidade: Copy-paste + test*

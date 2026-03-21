# Análise Estrutural PDP (Product Detail Page) — Patagang
**Data:** 2026-03-20
**Fonte:** elements-pagina-produto.txt (DOM snapshot)
**Status:** ⚠️ **7 PROBLEMAS CRÍTICOS IDENTIFICADOS**

---

## Resumo Executivo

| Métrica | Valor |
|---------|-------|
| **Problemas Críticos** | 7 |
| **Severidade Máxima** | CRÍTICA |
| **Status Geral** | PÁGINA NÃO FUNCIONA |
| **Impacto** | Usuário NÃO consegue comprar |

---

## Problemas Identificados

### 🔴 **CRÍTICA #1: Botão "Adicionar ao Carrinho" DESABILITADO por Padrão**

**Componente:** `.js-addtocart`
**Signature HTML:**
```html
class="js-addtocart js-addtocart-placeholder btn btn-primary btn-transition disabled btn-block"
```

**Problema:**
- Botão está com classe `disabled`
- Está esperando JavaScript para habilitar
- Habilitar deve ocorrer quando usuário seleciona tamanho

**Causa Raiz:**
- Event handler em `select.js-variation-option` não está funcionando
- OU seletor não está encontrando elemento no DOM
- OU evento change não está disparando

**Impacto do Usuário:** ⚠️ **CRÍTICO**
- Usuário clica botão → nada acontece
- Mesmo que tenha selecionado tamanho, botão continua desabilitado

**Como Testar:**
```javascript
// No console do DevTools:
document.querySelector('.js-addtocart').classList
// Se contém 'disabled', botão está travado

// Testar seletor de tamanho:
document.querySelector('.js-variation-option').dispatchEvent(new Event('change'))
// Verificar se botão habilita
```

**Fix Proposto:**
1. Verificar se `LS.variants` está carregado
2. Verificar se `select.js-variation-option` tem event listener
3. Adicionar log: `console.log('Variant changed:', event.target.value)`
4. Garantir que handler chama `btn.classList.remove('disabled')`

---

### 🔴 **CRÍTICA #2: Seletor de Variantes Sem JavaScript Binding**

**Componente:** `select.js-variation-option`
**Signature HTML:**
```html
<select class="form-select js-variation-option js-refresh-installment-data">
  <option value="">Selecione um tamanho</option>
  <option value="1402384627">PP</option>
  <option value="1402384634">P</option>
  <option value="1402384641">M</option>
  <option value="1402384642">G</option>
  <option value="1402384652">GG</option>
</select>
```

**Problema:**
- Elemento existe no DOM ✅
- Dados de variantes existem em `LS.variants` ✅
- **MAS** mudança de seleção não dispara atualização de:
  - Preço
  - Parcelamento
  - Imagem do produto
  - Stock
  - Botão "Adicionar ao Carrinho"

**Causa Raiz:**
- Event listener `onChange` está quebrado ou não existe
- Possível: `window.productForm` é undefined
- Possível: código customizado no tema sobrescreveu handler Nuvemshop

**Impacto do Usuário:** ⚠️ **CRÍTICO**
- Usuário seleciona tamanho M → preço continua igual
- Parcelamento não muda
- Botão Carrinho não habilita

**Como Testar:**
```javascript
// Testar se select tem listener:
const select = document.querySelector('.js-variation-option');
select.dispatchEvent(new Event('change'));

// Verificar se preço mudou:
console.log(document.querySelector('.js-price-display').innerText);

// Procurar por erro:
console.log(window.productForm); // Se undefined = problema
```

**Fix Proposto:**
1. Inspecionar arquivo theme que contém product-form.js
2. Verificar se handler existe:
   ```javascript
   document.querySelector('.js-variation-option').addEventListener('change', function() {
     // Atualizar preço, parcelamento, botão
   });
   ```
3. Se handler não existe, criar um baseado em LS.variants

---

### 🔴 **ALTA #3: .pg-pdp-extras-container Oculto (Sem Reviews)**

**Componente:** `.pg-pdp-extras-container`
**CSS Rule:**
```css
.pg-pdp-extras-container:empty {
  display: none;
}
```

**Problema:**
- Container está **VAZIO** no snapshot
- CSS explicitamente oculta quando vazio
- Isso esconde:
  - Reviews/ratings de clientes
  - Comentários (Facebook widget)
  - UGC/social proof
  - Promoções

**Causa Raiz:**
- Reviews script não carregou
- Nuvemshop retornou lista vazia
- CSS foi adicionado durante dev e não removido

**Impacto do Usuário:** ⚠️ **ALTO**
- Usuário não vê reviews de outros clientes
- Reduz confiança na compra
- Aumenta taxa de abandono

**Como Testar:**
```javascript
// Verificar se elemento está vazio:
const container = document.querySelector('.pg-pdp-extras-container');
console.log(container.innerHTML); // Se vazio, problema identificado

// Procurar por reviews widget:
console.log(document.querySelector('#reviewsapp'));
```

**Fix Proposto:**
1. Remover CSS: `.pg-pdp-extras-container:empty { display: none; }`
2. Verificar se script de reviews está:
   ```html
   <script data-component="reviews"></script>
   ```
3. Confirmar que Reviews estão habilitadas no Admin Nuvemshop
4. Se reviews não carregam, adicionar fallback HTML

---

### 🟠 **ALTA #4: Calculadora de Frete Pode Estar com AJAX Quebrado**

**Componente:** `.js-shipping-calculator-container`
**Signature HTML:**
```html
<div class="js-shipping-calculator-container">
  <div class="js-shipping-calculator-head shipping-calculator-head ...">
    <!-- CEP input -->
    <input class="js-shipping-input" type="text" placeholder="CEP">
    <button class="js-calculate-shipping">Calcular</button>
  </div>
  <!-- Resultado aqui -->
</div>
```

**Problema:**
- Elemento existe ✅
- Mas estado é desconhecido
- CSS mostra possíveis estados:
  - `.shipping-calculator-head.with-form` (input visível)
  - `.shipping-calculator-head.with-zip` (resultado visível)
  - `.shipping-calculator-head.with-error` (erro)
- Qual estado está ativo? **Desconhecido**

**Causa Raiz:**
- AJAX para `/shipping` pode estar falhando
- CEP validação pode estar rejeitando entrada
- Resposta do servidor pode estar vazia
- CORS error possível

**Impacto do Usuário:** ⚠️ **ALTO**
- Usuário não consegue calcular frete
- Não sabe custo de entrega antes de ir para checkout
- Abandona compra

**Como Testar:**
```javascript
// Abrir DevTools Network
// Entrar CEP: 88015-500
// Clicar "Calcular Frete"
// Procurar por erro CORS ou 404 em /shipping
```

**Fix Proposto:**
1. Testar AJAX manualmente
2. Procurar por erro 404/CORS em Network tab
3. Verificar resposta tem `options` array
4. Se falha, adicionar fallback: "Frete será calculado no checkout"

---

### 🟠 **ALTA #5: Dados de Variantes Têm option1/option2 = null**

**Componente:** `LS.variants` (JavaScript global)
**Exemplo de Dado:**
```javascript
LS.variants = [
  {
    "product_id": 316515592,
    "option0": "PP",
    "option1": null,    // ← PROBLEMA
    "option2": null,    // ← PROBLEMA
    "stock": 8,
    "available": true,
    "installments_data": "{...}"
  },
  // 4 mais variantes com mesmo padrão
]
```

**Problema:**
- Produto tem **APENAS 1 atributo** (tamanho)
- `option1` e `option2` estão null
- Se tema foi desenvolvido para multi-atributo, pode haver seletores vazios

**Impacto do Usuário:** ⚠️ **MÉDIO**
- Se há seletores para option1/option2, ficarão vazios
- Confusão do usuário

**Como Testar:**
```javascript
console.log(LS.variants[0]);
// Confirmar que option1 e option2 são null
```

**Fix Proposto:**
1. Confirmar no Admin Nuvemshop que produto tem 1 atributo apenas
2. Remover seletores para option1/option2 se não existem
3. Verificar que select.js-variation-option renderiza apenas para option0

---

### 🟡 **MÉDIA #6: Parcelamento Pode Não Estar Renderizando**

**Componente:** `.js-max-installments`, `.pg-price-installments`
**Dados Presentes:** ✅
```javascript
LS.variants[0].installments_data = {
  "Nuvem Pago": {
    "1": { "installment_value": 169, "total_value": 169 },
    "2": { "installment_value": 84.5, "total_value": 169 },
    "3": { "installment_value": 56.33, "total_value": 169 },
    // ... até 12x
  }
}
```

**Problema:**
- JSON existe e é válido ✅
- Element existe no DOM ✅
- **MAS** elemento pode estar vazio (sem "até 12x sem juros")

**Causa Raiz:**
- JavaScript não está fazendo `JSON.parse()` da string
- DOM update não está acontecendo
- CSS está ocultando com `display: none`

**Impacto do Usuário:** ⚠️ **MÉDIO**
- Usuário vê só preço à vista
- Não vê opções de parcelamento
- Reduz conversão

**Como Testar:**
```javascript
// Testar parse:
const installments = JSON.parse(LS.variants[0].installments_data);
console.log(installments); // Se erro, problema identificado

// Verificar elemento:
console.log(document.querySelector('.js-max-installments').innerText);
// Se vazio, renderização falhou
```

**Fix Proposto:**
1. Testar JSON.parse() no console
2. Verificar CSS não está ocultando elemento
3. Se renderização falha, adicionar fallback

---

### 🟡 **MÉDIA #7: CSS Duplicado para Variantes**

**Componente:** `.pg-variants-container`, `.pg-variant-group`
**Problema:**
- Classe `.pg-variants-container` definida em **2 linhas**: 4374, 4758
- Classe `.pg-variant-group` definida em **2 linhas**: 4378, 4762
- Possível cascata CSS não-intencional

**Causa Raiz:**
- Código CSS não foi consolidado
- Desenvolvimento iterativo deixou duplicatas

**Impacto do Usuário:** ⚠️ **MÉDIO**
- Seletores podem estar com:
  - Altura zero
  - Overflow hidden (cortando opções)
  - Desalinhados

**Como Testar:**
```javascript
// DevTools > Elements
// Click em select.js-variation-option
// Verificar Computed Styles
// Se height: 0 ou overflow: hidden, problema
```

**Fix Proposto:**
1. Consolidar CSS duplicado
2. Testar em DevTools que select tem altura adequada
3. Garantir que não tem overflow: hidden

---

## Checklist de Componentes Críticos

| Componente | Status | Problema |
|-----------|--------|----------|
| **Formulário** `.js-product-form` | ✅ Presente | Pode ter binding JS quebrado |
| **Botão Carrinho** `.js-addtocart` | ✅ Presente | ❌ **DISABLED** |
| **Seletor Tamanho** `.js-variation-option` | ✅ Presente | ❌ Binding quebrado |
| **Preço** `.js-price-display` | ✅ Presente | Pode não atualizar |
| **Parcelamento** `.js-max-installments` | ✅ Presente | Pode estar vazio |
| **Imagens** `.js-swiper-product` | ✅ Presente | OK |
| **Frete** `.js-shipping-calculator-container` | ✅ Presente | AJAX desconhecido |
| **Reviews** `#reviewsapp` | ❌ VAZIO | Não carregou |

---

## Ações Recomendadas (Priority Order)

### 🔴 **CRÍTICA #1: Habilitar Botão Carrinho**
1. Abrir DevTools Console
2. Testar: `document.querySelector('.js-addtocart').classList`
3. Se tem `disabled`, procurar por:
   - `btn.classList.remove('disabled')` em product-form.js
4. Se não existe, criar handler de evento `change`

### 🔴 **CRÍTICA #2: Fixar Select Binding**
1. Verificar arquivo: `theme-deploy-corrigido/static/js/product-form.js`
2. Garantir que existe:
   ```javascript
   document.querySelector('.js-variation-option').addEventListener('change', function() {
     // Atualizar preço, parcelamento, botão
   });
   ```
3. Se não existe, criar handler baseado em LS.variants

### 🟠 **ALTA #3: Remover CSS de Reviews**
1. Abrir: `theme-deploy-corrigido/static/css/product-styles.css`
2. Procurar: `.pg-pdp-extras-container:empty { display: none; }`
3. Comentar ou remover

### 🟠 **ALTA #4: Testar Frete AJAX**
1. Ir para página
2. Entrar CEP válido
3. Abrir DevTools Network
4. Clicar "Calcular"
5. Procurar erro 404/CORS

---

## Arquivos para Investigar

1. **theme-deploy-corrigido/layouts/product.tpl** — Estrutura HTML
2. **theme-deploy-corrigido/static/js/product-form.js** — Lógica variantes
3. **theme-deploy-corrigido/static/css/product-styles.css** — CSS duplicado
4. **docs/guides/nuvemshop/NUVEMSHOP_FTP_STANDARDS.md** — Restrições Nuvemshop

---

## Conclusão

**A página de produto NÃO ESTÁ FUNCIONAL para compra.**

Motivo principal: **Botão "Adicionar ao Carrinho" está travado e não se habilita quando usuário seleciona tamanho.**

Causa raiz provável: **JavaScript binding do select de tamanho está quebrado.**

**Timeframe para fix:** 2-4 horas se é JS, 1 hora se é CSS.

---

**Próximo Passo:** Executar ações críticas #1 e #2 acima.

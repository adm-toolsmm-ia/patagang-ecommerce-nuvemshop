#!/usr/bin/env node
/**
 * Story 8.5 Priority 2 Phase 2: Extract 3 medium-complexity modules
 *
 * Sections to extract:
 * 1. Product detail functions (lines 926-1810)
 * 2. Cart functions (lines 1811-2316)
 * 3. Shipping calculator (lines 2318-end)
 */

const fs = require('fs');
const path = require('path');

const storeFile = 'theme-deploy-corrigido/static/js/store.js.tpl';
const backupFile = storeFile + '.backup.v1.5.77';

// Read original file
const content = fs.readFileSync(storeFile, 'utf-8');
const lines = content.split('\n');
const originalLineCount = lines.length;

console.log('📦 Extração Phase 2: Product, Cart, Shipping modules\n');

// ============================================================
// MODULE 1: Product Functions (lines 926-1810)
// ============================================================

const productStart = 925; // 0-indexed
const productEnd = 1810; // exclusive
const productLines = lines.slice(productStart, productEnd).join('\n');

const productModule = `{#/*============================================================================
  Patagang Store — Product Functions Module (Story 8.5 Priority 2 Phase 2)
  Extracted from store.js.tpl (linhas 926-1810)

  Responsabilidades:
  - Installments (sem juros, com juros)
  - Variant selection e mudanças
  - Product labels on variant change
  - Payment discounts
  - Custom mobile variant display

  Padrão: IIFE com typeof checks + namespace PatagangStore
  Auto-init: DOMContentLoaded
==============================================================================*/#}

(function() {
  'use strict';

  {# Verificar dependências #}
  if (typeof jQueryNuvem === 'undefined' || typeof LS === 'undefined') {
    console.warn('[PatagangStore.productFunctions] Dependências não disponíveis');
    return;
  }

${productLines}

  {# Função principal: Inicializar product functions #}
  const initProductFunctions = function() {
    console.log('[PatagangStore.productFunctions] ✓ Inicialisado');
  };

  {# Expor interface pública #}
  window.PatagangStore = window.PatagangStore || {};
  window.PatagangStore.productFunctions = {
    init: initProductFunctions,
    {# Public API exports for backward compatibility #}
    get_max_installments_without_interests: typeof get_max_installments_without_interests !== 'undefined' ? get_max_installments_without_interests : null,
    get_max_installments_with_interests: typeof get_max_installments_with_interests !== 'undefined' ? get_max_installments_with_interests : null,
    refreshInstallmentv2: typeof refreshInstallmentv2 !== 'undefined' ? refreshInstallmentv2 : null,
    changeVariant: typeof changeVariant !== 'undefined' ? changeVariant : null
  };

  {# Auto-inicializar quando DOM estiver pronto #}
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initProductFunctions);
  } else {
    initProductFunctions();
  }
})();
`;

fs.writeFileSync('theme-deploy-corrigido/static/js/modules/product-functions.js', productModule, 'utf-8');
console.log('✅ Criado: modules/product-functions.js');

// ============================================================
// MODULE 2: Cart Functions (lines 1811-2316)
// ============================================================

const cartStart = 1810; // 0-indexed
const cartEnd = 2316; // exclusive
const cartLines = lines.slice(cartStart, cartEnd).join('\n');

const cartModule = `{#/*============================================================================
  Patagang Store — Cart Functions Module (Story 8.5 Priority 2 Phase 2)
  Extracted from store.js.tpl (linhas 1811-2316)

  Responsabilidades:
  - Toggle cart drawer
  - Add to cart
  - Cart quantity changes
  - Remove from cart
  - Empty cart alerts
  - Go to checkout

  Padrão: IIFE com typeof checks + namespace PatagangStore
  Auto-init: DOMContentLoaded
==============================================================================*/#}

(function() {
  'use strict';

  {# Verificar dependências #}
  if (typeof jQueryNuvem === 'undefined' || typeof LS === 'undefined') {
    console.warn('[PatagangStore.cartFunctions] Dependências não disponíveis');
    return;
  }

${cartLines}

  {# Função principal: Inicializar cart functions #}
  const initCartFunctions = function() {
    console.log('[PatagangStore.cartFunctions] ✓ Inicialisado');
  };

  {# Expor interface pública #}
  window.PatagangStore = window.PatagangStore || {};
  window.PatagangStore.cartFunctions = {
    init: initCartFunctions,
    {# Public API exports for backward compatibility #}
    renderCartTotal: typeof renderCartTotal !== 'undefined' ? renderCartTotal : null,
    toggleCart: typeof toggleCart !== 'undefined' ? toggleCart : null
  };

  {# Auto-inicializar quando DOM estiver pronto #}
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initCartFunctions);
  } else {
    initCartFunctions();
  }
})();
`;

fs.writeFileSync('theme-deploy-corrigido/static/js/modules/cart-functions.js', cartModule, 'utf-8');
console.log('✅ Criado: modules/cart-functions.js');

// ============================================================
// MODULE 3: Shipping Functions (lines 2318-end)
// ============================================================

const shippingStart = 2317; // 0-indexed
const shippingEnd = lines.length; // to end
const shippingLines = lines.slice(shippingStart, shippingEnd).join('\n');

const shippingModule = `{#/*============================================================================
  Patagang Store — Shipping Functions Module (Story 8.5 Priority 2 Phase 2)
  Extracted from store.js.tpl (linhas 2318-fim)

  Responsabilidades:
  - Select shipping option
  - Calculate shipping
  - Free shipping bar
  - Toggle branches link
  - Shipping on page load
  - Store country/province change

  Padrão: IIFE com typeof checks + namespace PatagangStore
  Auto-init: DOMContentLoaded
==============================================================================*/#}

(function() {
  'use strict';

  {# Verificar dependências #}
  if (typeof jQueryNuvem === 'undefined' || typeof LS === 'undefined') {
    console.warn('[PatagangStore.shippingFunctions] Dependências não disponíveis');
    return;
  }

${shippingLines}

  {# Função principal: Inicializar shipping functions #}
  const initShippingFunctions = function() {
    console.log('[PatagangStore.shippingFunctions] ✓ Inicialisado');
  };

  {# Expor interface pública #}
  window.PatagangStore = window.PatagangStore || {};
  window.PatagangStore.shippingFunctions = {
    init: initShippingFunctions,
    {# Public API exports for backward compatibility #}
    selectShippingOption: typeof selectShippingOption !== 'undefined' ? selectShippingOption : null,
    calculateShipping: typeof calculateShipping !== 'undefined' ? calculateShipping : null
  };

  {# Auto-inicializar quando DOM estiver pronto #}
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', initShippingFunctions);
  } else {
    initShippingFunctions();
  }
})();
`;

fs.writeFileSync('theme-deploy-corrigido/static/js/modules/shipping-functions.js', shippingModule, 'utf-8');
console.log('✅ Criado: modules/shipping-functions.js');

// ============================================================
// SUMMARY
// ============================================================

console.log('\n📊 Resumo da Extração Phase 2:');
console.log(`  Product functions: ${productEnd - productStart} linhas (~12-15K)`);
console.log(`  Cart functions: ${cartEnd - cartStart} linhas (~10-12K)`);
console.log(`  Shipping functions: ${shippingEnd - shippingStart} linhas (~8-10K)`);
console.log(`  Total extraído: ${(productEnd - productStart) + (cartEnd - cartStart) + (shippingEnd - shippingStart)} linhas`);
console.log(`\n  Próximo passo: Remover essas seções de store.js.tpl`);
console.log(`                Atualizar layout.tpl com novos includes`);
console.log(`                Deploy v1.5.78 com validação`);

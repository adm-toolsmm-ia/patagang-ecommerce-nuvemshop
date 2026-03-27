# Patagang Store — JavaScript Modules

Módulos extraídos do `store.js.tpl` durante **Story 8.5 Priority 2** para reduzir tamanho do arquivo principal.

## Módulos (Phase 1 — Low-Risk)

| Módulo | Tamanho | Responsabilidade | Auto-Init |
|--------|--------|------------------|-----------|
| **notifications.js** | ~1.5K | Mostrar/esconder notificações, cookie banner | DOMContentLoaded |
| **forms.js** | ~1K | Validação de formulários, toggle password | DOMContentLoaded |
| **footer.js** | ~0.3K | Logo AFIP alt attr (SEO) | DOMContentLoaded |
| **utilities.js** | ~2-3K | Modal management, URL hash handling | DOMContentLoaded |

## Padrão de Implementação (IIFE)

Cada módulo segue este padrão para segurança:

```javascript
(function() {
  'use strict';

  // 1. Verificar dependências
  if (typeof jQueryNuvem === 'undefined') {
    console.warn('[PatagangStore.moduleName] Dependência não disponível');
    return;
  }

  // 2. Código do módulo
  const init = function() { ... };

  // 3. Expor interface pública
  window.PatagangStore = window.PatagangStore || {};
  window.PatagangStore.moduleName = { init: init };

  // 4. Auto-inicializar
  if (document.readyState === 'loading') {
    document.addEventListener('DOMContentLoaded', init);
  } else {
    init();
  }
})();
```

## Carregamento

Ordem correta de carregamento em `layout.tpl`:

```tpl
<!-- 1. Dependências externas -->
<script src="{{ 'js/external-no-dependencies.js.tpl' | static_url }}"></script>

<!-- 2. Módulos Patagang (Phase 1) -->
<script src="{{ 'js/modules/notifications.js' | static_url }}"></script>
<script src="{{ 'js/modules/forms.js' | static_url }}"></script>
<script src="{{ 'js/modules/footer.js' | static_url }}"></script>
<script src="{{ 'js/modules/utilities.js' | static_url }}"></script>

<!-- 3. Store.js principal (reduzido após extração) -->
<script src="{{ 'js/store.js.tpl' | static_url }}"></script>
```

## Backward Compatibility

Funções exportadas globalmente para manter compatibilidade:

- `window.modalOpen()` → `PatagangStore.utilities.modalOpen`
- `window.cleanURLHash()` → `PatagangStore.utilities.cleanURLHash`
- `window.goBackBrowser()` → `PatagangStore.utilities.goBackBrowser`
- `window.restoreNotifications()` → Criada por `PatagangStore.notifications`

## Próximas Fases

**Phase 2** (Priority 2 continuação):
- product-functions.js (~12-15K)
- cart-functions.js (~10-12K)
- shipping-functions.js (~8-10K)

**Phase 3** (Priority 3):
- Consolidação cart + cart-drawer

**Phase 4** (Priority 4):
- Review Swiper usage e consolidação

## Versão

- **Introduzido:** v1.5.77 (Story 8.5 Priority 2)
- **Padrão:** IIFE + typeof checks + namespace
- **Auto-init:** DOMContentLoaded
- **Log console:** ✓ (cada módulo loga inicialização)

---

**Mantido por:** @dev (Story 8.5 Phase Implementation)
**Referência:** `.aiox-core/development/docs/NUVEMSHOP-JAVASCRIPT-SAFE-PRACTICES.md`

# Botões laterais (Posso ajudar? e Compre pelo Whats)

Botões flutuantes fixos nas laterais da tela: AJUDA? (direita) abre a sidebar de ajuda; Compre pelo Whats (esquerda) link direto para WhatsApp.

---

## Componentes

| Componente | Classe | Template | CSS |
|------------|--------|----------|-----|
| Posso ajudar? | `.pg-help-btn` | `snipplets/help-sidebar.tpl` | `style-help-sidebar.css.tpl` |
| Compre pelo Whats | `.btn-whatsapp-left` | `snipplets/whatsapp-left.tpl` | `style-critical.tpl` (~linhas 1390-1448) |

---

## Design padronizado (2026-03)

- **Background:** `#EAFE67` (amarelo da loja)
- **Hover:** `#d4e65d`
- **Texto:** Familjen Grotesk, font-weight 500, 12px (11px mobile), uppercase, cor `#1A1A1A`
- **Ícones:** Traços finos (stroke-width 1.5 no AJUDA?; WhatsApp mantém verde `#25D366` para reconhecimento de marca)
- **Bordas:** 4px arredondadas no lado externo
- **Box-shadow:** `2px 0 8px rgba(0,0,0,0.1)` (lado esquerdo) / `-2px 0 8px` (lado direito)

---

## Breakpoints e comportamento responsivo

| Viewport | Posso ajudar? | Compre pelo Whats |
|----------|---------------|-------------------|
| Web (≥769px) | Centralizado verticalmente à direita | Centralizado verticalmente à esquerda |
| Mobile (≤768px) | Centralizado verticalmente à direita (igual web) | Centralizado verticalmente à esquerda |
| Mobile pequeno (≤480px) | Idem | Padding e fonte reduzidos |

---

## Override final

Para garantir que as alterações não sejam sobrescritas por `settings.css_code` ou CSS da plataforma, existe um bloco de override em `layouts/layout.tpl` (após `settings.css_code`) com seletores `body .pg-help-btn` e `body .btn-whatsapp-left`.

---

## Referência

- Plano de padronização: `.cursor/plans/padronização_botões_laterais_54ea80fa.plan.md`
- Padrões CSS: [Docs/project/standards-css-e-tema-nuvemshop.md](../../project/standards-css-e-tema-nuvemshop.md)

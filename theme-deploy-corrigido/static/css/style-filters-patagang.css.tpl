/* ===========================================
   PATAGANG - FILTROS E CONTROLES DE CATEGORIA
   Design consistente com identidade visual
   =========================================== */

/* Container dos controles */
.pg-search-page .category-controls,
.pg-search-page .js-category-controls {
    padding: 20px 0;
    margin-bottom: 28px;
    border-bottom: 1px solid rgba(0,0,0,0.1);
}

/* ============================================
   BOTÃO FILTRAR - Design clean, sem arredondamento
   ============================================ */
.pg-search-page .filter-link {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-size: 12px !important;
    font-weight: 700 !important;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    color: #000 !important;
    padding: 10px 22px;
    border: 1.5px solid #000;
    border-radius: 0;
    background: transparent;
    transition: all 0.2s ease;
    cursor: pointer;
    text-decoration: none !important;
}

.pg-search-page .filter-link:hover {
    background: #000;
    color: #EAFE67 !important;
}

.pg-search-page .filter-link svg,
.pg-search-page .filter-link .icon-inline {
    width: 14px;
    height: 14px;
    fill: currentColor;
}

/* ============================================
   DROPDOWN ORDENAÇÃO - Mesmo estilo do FILTRAR
   ============================================ */
.pg-search-page .form-group {
    margin: 0 !important;
}

.pg-search-page select,
.pg-search-page .form-select {
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    background-color: transparent !important;
    border: 1.5px solid #000 !important;
    border-radius: 0 !important;
    padding: 10px 36px 10px 16px !important;
    height: auto !important;
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-size: 12px !important;
    font-weight: 700 !important;
    text-transform: uppercase !important;
    letter-spacing: 0.08em !important;
    color: #000 !important;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%23000000' stroke-width='2.5' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E") !important;
    background-repeat: no-repeat !important;
    background-position: right 12px center !important;
    background-size: 12px !important;
    cursor: pointer;
    min-width: 160px;
    max-width: 220px;
    box-shadow: none !important;
    outline: none !important;
    transition: all 0.2s ease;
}

.pg-search-page select:hover,
.pg-search-page .form-select:hover {
    background-color: #000 !important;
    color: #EAFE67 !important;
    border-color: #000 !important;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%23EAFE67' stroke-width='2.5' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E") !important;
}

.pg-search-page select:focus,
.pg-search-page .form-select:focus {
    outline: none !important;
    box-shadow: none !important;
}

/* Oculta ícone nativo do select */
.pg-search-page .form-select-arrow,
.pg-search-page .select-icon,
.pg-search-page select + svg,
.pg-search-page select + i,
.pg-search-page .form-select-icon {
    display: none !important;
}

/* Filtros aplicados (tags/chips) */
.pg-search-page .chip,
.pg-search-page .filter-tag,
.pg-search-page .selected-filter {
    display: inline-flex;
    align-items: center;
    gap: 6px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 11px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.04em;
    padding: 6px 14px;
    background: #EAFE67;
    color: #000;
    border: 1px solid #000;
    border-radius: 0;
    margin: 4px 6px 4px 0;
    transition: all 0.2s ease;
}

.pg-search-page .chip:hover,
.pg-search-page .filter-tag:hover {
    background: #000;
    color: #EAFE67;
}

.pg-search-page .chip-remove-icon,
.pg-search-page .filter-tag-close,
.pg-search-page .selected-filter .remove-filter {
    cursor: pointer;
    opacity: 0.7;
    transition: opacity 0.2s ease;
    margin-left: 2px;
    font-size: 14px;
    line-height: 1;
}

.pg-search-page .chip-remove-icon:hover,
.pg-search-page .filter-tag-close:hover {
    opacity: 1;
}

/* ===========================================
   MODAL DE FILTROS (sidebar esquerda)
   Fundo preto sólido
   =========================================== */

/* ===========================================
   MODAL DE FILTROS (sidebar esquerda)
   Fundo BRANCO (Light Theme)
   =========================================== */

#nav-filters.modal-docked-small {
    background: #FFFFFF !important;
    backdrop-filter: none !important;
    -webkit-backdrop-filter: none !important;
    max-width: 340px !important;
    box-shadow: 20px 0 60px rgba(0, 0, 0, 0.1) !important;
    border-right: 1px solid rgba(0,0,0,0.05) !important;
}

/* ============================================
   RESET AGRESSIVO: Remove backgrounds e bordas
   do tema base dentro do modal de filtros
   ============================================ */
#nav-filters .modal-body,
#nav-filters .filters-container,
#nav-filters .filter-group,
#nav-filters .filters-group,
#nav-filters .checkbox,
#nav-filters .checkbox-container,
#nav-filters .list-unstyled,
#nav-filters ul,
#nav-filters li {
    background-color: transparent !important;
    background: transparent !important;
    box-shadow: none !important;
}

/* Header do modal - FILTROS */
#nav-filters .modal-header {
    background: #FFFFFF !important;
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-size: 14px !important;
    font-weight: 700 !important;
    text-transform: uppercase;
    letter-spacing: 0.12em;
    color: #000000 !important;
    padding: 20px 24px !important;
    border-bottom: 1px solid rgba(0, 0, 0, 0.08) !important;
    display: flex;
    align-items: center;
}

#nav-filters .modal-header-title,
#nav-filters .modal-header span:not(.modal-close) {
    color: #000000 !important;
}

/* Botão fechar (X) */
#nav-filters .modal-close {
    color: #000000 !important;
    opacity: 0.6;
    transition: opacity 0.2s ease;
    background: none !important;
    border: none !important;
}

#nav-filters .modal-close:hover {
    opacity: 1 !important;
}

#nav-filters .modal-close svg {
    fill: #000000 !important;
    stroke: #000000 !important;
}

/* Body do modal */
#nav-filters .modal-body {
    padding: 24px !important;
    background: #FFFFFF !important;
    overflow-y: auto;
}

/* ============================================
   GRUPOS DE FILTROS
   ============================================ */
#nav-filters .filter-group,
#nav-filters .filters-container {
    margin-bottom: 28px !important;
    padding: 0 !important;
}

/* Espaçamento Bootstrap mb-5 reset */
#nav-filters .filters-container.mb-5,
#nav-filters .mb-5 {
    margin-bottom: 28px !important;
}

/* ============================================
   TÍTULOS DOS GRUPOS (CATEGORIAS, TAMANHO, MARCA, Preço)
   ============================================ */
#nav-filters h6,
#nav-filters .filter-group-title,
#nav-filters .filters-group-title,
#nav-filters .filters-container > h6,
#nav-filters .mb-3:first-child {
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-size: 13px !important;
    font-weight: 700 !important;
    text-transform: uppercase !important;
    letter-spacing: 0.1em !important;
    color: #000000 !important;
    margin-bottom: 12px !important;
    padding-bottom: 10px !important;
    border-bottom: 1px solid rgba(0, 0, 0, 0.08) !important;
    display: block !important;
    background: transparent !important;
    font-style: normal !important;
    line-height: 1.4 !important;
}

/* ============================================
   LINKS DE CATEGORIA (Roupas, Peitorais, etc.)
   ============================================ */
#nav-filters ul,
#nav-filters .list-unstyled {
    list-style: none !important;
    padding: 0 !important;
    margin: 0 !important;
}

#nav-filters li {
    margin-bottom: 0 !important;
    padding: 0 !important;
}

/* Reset mb-3 nos li do filtro */
#nav-filters li.mb-3 {
    margin-bottom: 0 !important;
}

#nav-filters li a,
#nav-filters .text-primary {
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-size: 13px !important;
    font-weight: 400 !important;
    color: #333333 !important;
    text-decoration: none !important;
    display: block !important;
    padding: 8px 0 !important;
    border-bottom: 1px solid rgba(0, 0, 0, 0.05) !important;
    transition: color 0.15s ease;
    background: transparent !important;
}

#nav-filters li a:hover,
#nav-filters .text-primary:hover {
    color: #000000 !important;
    font-weight: 600 !important;
}

/* ============================================
   CHECKBOXES - TAMANHO, MARCA, etc.
   Estrutura: label.checkbox-container > span.checkbox > input + .checkbox-icon + .checkbox-text
   ============================================ */

/* Label wrapper */
#nav-filters label,
#nav-filters .checkbox-container {
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-size: 13px !important;
    font-weight: 400 !important;
    color: #333333 !important;
    cursor: pointer;
    display: flex !important;
    align-items: center !important;
    padding: 7px 0 !important;
    margin-bottom: 0 !important;
    text-transform: none !important;
    border-bottom: 1px solid rgba(0, 0, 0, 0.05) !important;
    transition: color 0.15s ease;
    background: transparent !important;
}

/* Reset mb-2 do tema base */
#nav-filters label.mb-2,
#nav-filters .checkbox-container.mb-2 {
    margin-bottom: 0 !important;
}

#nav-filters label:hover,
#nav-filters .checkbox-container:hover {
    color: #000000 !important;
}

/* Span .checkbox wrapper - deve ser flex row */
#nav-filters .checkbox {
    display: flex !important;
    align-items: center !important;
    width: 100% !important;
    background: transparent !important;
    gap: 0 !important;
}

/* Checkbox input customizado */
#nav-filters input[type="checkbox"] {
    appearance: none !important;
    -webkit-appearance: none !important;
    -moz-appearance: none !important;
    width: 16px !important;
    height: 16px !important;
    min-width: 16px !important;
    min-height: 16px !important;
    border: 1.5px solid rgba(0, 0, 0, 0.3) !important;
    border-radius: 3px !important;
    margin: 0 10px 0 0 !important;
    padding: 0 !important;
    cursor: pointer !important;
    transition: all 0.15s ease;
    position: relative !important;
    background: #FFFFFF !important;
    flex-shrink: 0 !important;
    display: inline-block !important;
    vertical-align: middle !important;
}

#nav-filters input[type="checkbox"]:hover {
    border-color: #000000 !important;
}

#nav-filters input[type="checkbox"]:checked {
    background: #000000 !important;
    border-color: #000000 !important;
}

#nav-filters input[type="checkbox"]:checked::after {
    content: '' !important;
    position: absolute !important;
    top: 1px !important;
    left: 4px !important;
    width: 5px !important;
    height: 9px !important;
    border: solid #EAFE67 !important;
    border-width: 0 2px 2px 0 !important;
    transform: rotate(45deg) !important;
    display: block !important;
}

/* Oculta checkbox-icon do tema (substituído pelo input customizado) */
#nav-filters .checkbox-icon {
    display: none !important;
    width: 0 !important;
    height: 0 !important;
    overflow: hidden !important;
}

/* Texto do checkbox - DEVE SER VISÍVEL */
#nav-filters .checkbox-text {
    color: #333333 !important;
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-size: 13px !important;
    font-weight: 400 !important;
    display: inline !important;
    background: transparent !important;
    line-height: 1.4 !important;
}

#nav-filters label:hover .checkbox-text,
#nav-filters .checkbox-container:hover .checkbox-text {
    color: #000000 !important;
}

/* Cores de filtro (swatches) */
#nav-filters .checkbox-color {
    width: 18px !important;
    height: 18px !important;
    border-radius: 50% !important;
    border: 2px solid rgba(0, 0, 0, 0.1) !important;
    margin-left: 8px !important;
    flex-shrink: 0 !important;
    display: inline-block !important;
}

/* ============================================
   PREÇO - Inputs De/Até + Botão Aplicar
   ============================================ */

/* Inputs de preço */
#nav-filters input[type="number"],
#nav-filters input[type="text"]:not([autocomplete]) {
    background: #F5F5F5 !important;
    border: 1px solid rgba(0, 0, 0, 0.1) !important;
    border-radius: 3px !important;
    color: #000000 !important;
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-size: 13px !important;
    padding: 8px 12px !important;
    outline: none !important;
    box-shadow: none !important;
    width: auto !important;
    max-width: 100px !important;
}

#nav-filters input[type="number"]:focus,
#nav-filters input[type="text"]:focus {
    border-color: #000000 !important;
    background: #FFFFFF !important;
}

/* Labels "De" / "Até" dentro do filtro de preço */
#nav-filters .price-filter label,
#nav-filters .filter-price label {
    color: #666666 !important;
    font-size: 11px !important;
    font-weight: 600 !important;
    text-transform: uppercase !important;
    letter-spacing: 0.08em !important;
    border-bottom: none !important;
    padding: 4px 0 !important;
}

/* Botão APLICAR */
#nav-filters .btn-primary,
#nav-filters .btn-default,
#nav-filters .btn[type="submit"],
#nav-filters button.btn {
    background: #EAFE67 !important;
    color: #000 !important;
    border: none !important;
    border-radius: 0 !important;
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-size: 11px !important;
    font-weight: 700 !important;
    text-transform: uppercase !important;
    letter-spacing: 0.08em !important;
    padding: 10px 24px !important;
    cursor: pointer;
    transition: all 0.2s ease;
    margin-top: 8px !important;
}

#nav-filters .btn-primary:hover,
#nav-filters .btn-default:hover,
#nav-filters .btn[type="submit"]:hover,
#nav-filters button.btn:hover {
    background: #d9ec4f !important;
}

/* Link "Ver todos" / "Ver menos" */
#nav-filters .btn-link,
#nav-filters a.btn-link,
#nav-filters .js-accordion-toggle {
    color: #000000 !important;
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-size: 11px !important;
    font-weight: 600 !important;
    text-transform: uppercase !important;
    letter-spacing: 0.06em !important;
    text-decoration: underline !important;
    padding: 6px 0 !important;
    transition: opacity 0.2s ease;
    background: transparent !important;
    border: none !important;
    display: inline-block !important;
}

#nav-filters .btn-link:hover,
#nav-filters .js-accordion-toggle:hover {
    opacity: 0.7 !important;
    color: #333333 !important;
}

/* ============================================
   OVERLAY DE LOADING
   ============================================ */
#nav-filters .filters-overlay {
    background: rgba(255, 255, 255, 0.85) !important;
}

#nav-filters .filters-updating-message h3 {
    color: #000000 !important;
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-size: 13px !important;
    font-weight: 600 !important;
    text-transform: uppercase;
    letter-spacing: 0.08em;
}

/* Scrollbar personalizada */
#nav-filters .modal-body::-webkit-scrollbar {
    width: 4px;
}

#nav-filters .modal-body::-webkit-scrollbar-track {
    background: rgba(0, 0, 0, 0.05);
}

#nav-filters .modal-body::-webkit-scrollbar-thumb {
    background: rgba(0, 0, 0, 0.2);
    border-radius: 2px;
}

#nav-filters .modal-body::-webkit-scrollbar-thumb:hover {
    background: rgba(0, 0, 0, 0.4);
}

/* ============================================
   RESPONSIVO - Mobile
   ============================================ */
@media (max-width: 768px) {
    #nav-filters.modal-docked-small {
        max-width: 100% !important;
    }

    #nav-filters .modal-body {
        padding: 20px !important;
    }

    #nav-filters .modal-header {
        padding: 16px 20px !important;
    }

    .pg-search-page .category-controls {
        flex-direction: column;
        gap: 12px;
    }

    .pg-search-page .filter-link {
        padding: 8px 18px;
        font-size: 11px !important;
    }

    .pg-search-page select,
    .pg-search-page .form-select {
        font-size: 11px !important;
        padding: 8px 32px 8px 14px !important;
        min-width: 140px;
    }
}

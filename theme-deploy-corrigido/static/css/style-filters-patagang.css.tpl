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
   BOTO FILTRAR - Design clean, sem arredondamento
   ============================================ */
.pg-search-page .filter-link {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 12px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    color: #000;
    padding: 10px 22px;
    border: 1.5px solid #000;
    border-radius: 0;
    background: transparent;
    transition: all 0.2s ease;
    cursor: pointer;
    text-decoration: none;
}

.pg-search-page .filter-link:hover {
    background: #000;
    color: #EAFE67;
}

.pg-search-page .filter-link svg,
.pg-search-page .filter-link .icon-inline {
    width: 14px;
    height: 14px;
    fill: currentColor;
}

/* ============================================
   DROPDOWN ORDENAO - Mesmo estilo do FILTRAR
   ============================================ */
.pg-search-page .form-group {
    margin: 0;
}

.pg-search-page select,
.pg-search-page .form-select {
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    background-color: transparent;
    border: 1.5px solid #000;
    border-radius: 0;
    padding: 10px 36px 10px 16px;
    height: auto;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 12px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    color: #000;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%23000000' stroke-width='2.5' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
    background-repeat: no-repeat;
    background-position: right 12px center;
    background-size: 12px;
    cursor: pointer;
    min-width: 160px;
    max-width: 220px;
    box-shadow: none;
    outline: none;
    transition: all 0.2s ease;
}

.pg-search-page select:hover,
.pg-search-page .form-select:hover {
    background-color: #000;
    color: #EAFE67;
    border-color: #000;
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%23EAFE67' stroke-width='2.5' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E");
}

.pg-search-page select:focus,
.pg-search-page .form-select:focus {
    outline: none;
    box-shadow: none;
}

/* Oculta cone nativo do select */
.pg-search-page .form-select-arrow,
.pg-search-page .select-icon,
.pg-search-page select + svg,
.pg-search-page select + i,
.pg-search-page .form-select-icon {
    display: none;
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
   Fundo preto slido
   =========================================== */

/* ===========================================
   MODAL DE FILTROS (sidebar esquerda)
   Fundo BRANCO (Light Theme)
   =========================================== */

#nav-filters.modal-docked-small {
    background: #FFFFFF;
    backdrop-filter: none;
    -webkit-backdrop-filter: none;
    max-width: 340px;
    box-shadow: 20px 0 60px rgba(0, 0, 0, 0.1);
    border-right: 1px solid rgba(0,0,0,0.05);
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
    background-color: transparent;
    background: transparent;
    box-shadow: none;
}

/* Header do modal - FILTROS */
#nav-filters .modal-header {
    background: #FFFFFF;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 14px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.12em;
    color: #000000;
    padding: 20px 24px;
    border-bottom: 1px solid rgba(0, 0, 0, 0.08);
    display: flex;
    align-items: center;
}

#nav-filters .modal-header-title,
#nav-filters .modal-header span:not(.modal-close) {
    color: #000000;
}

/* Boto fechar (X) */
#nav-filters .modal-close {
    color: #000000;
    opacity: 0.6;
    transition: opacity 0.2s ease;
    background: none;
    border: none;
}

#nav-filters .modal-close:hover {
    opacity: 1;
}

#nav-filters .modal-close svg {
    fill: #000000;
    stroke: #000000;
}

/* Body do modal */
#nav-filters .modal-body {
    padding: 24px;
    background: #FFFFFF;
    overflow-y: auto;
}

/* ============================================
   GRUPOS DE FILTROS
   ============================================ */
#nav-filters .filter-group,
#nav-filters .filters-container {
    margin-bottom: 28px;
    padding: 0;
}

/* Espaamento Bootstrap mb-5 reset */
#nav-filters .filters-container.mb-5,
#nav-filters .mb-5 {
    margin-bottom: 28px;
}

/* ============================================
   TTULOS DOS GRUPOS (CATEGORIAS, TAMANHO, MARCA, Preo)
   ============================================ */
#nav-filters h6,
#nav-filters .filter-group-title,
#nav-filters .filters-group-title,
#nav-filters .filters-container > h6,
#nav-filters .mb-3:first-child {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 13px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.1em;
    color: #000000;
    margin-bottom: 12px;
    padding-bottom: 10px;
    border-bottom: 1px solid rgba(0, 0, 0, 0.08);
    display: block;
    background: transparent;
    font-style: normal;
    line-height: 1.4;
}

/* ============================================
   LINKS DE CATEGORIA (Roupas, Peitorais, etc.)
   ============================================ */
#nav-filters ul,
#nav-filters .list-unstyled {
    list-style: none;
    padding: 0;
    margin: 0;
}

#nav-filters li {
    margin-bottom: 0;
    padding: 0;
}

/* Reset mb-3 nos li do filtro */
#nav-filters li.mb-3 {
    margin-bottom: 0;
}

#nav-filters li a,
#nav-filters .text-primary {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 13px;
    font-weight: 400;
    color: #333333;
    text-decoration: none;
    display: block;
    padding: 8px 0;
    border-bottom: 1px solid rgba(0, 0, 0, 0.05);
    transition: color 0.15s ease;
    background: transparent;
}

#nav-filters li a:hover,
#nav-filters .text-primary:hover {
    color: #000000;
    font-weight: 600;
}

/* ============================================
   CHECKBOXES - TAMANHO, MARCA, etc.
   Estrutura: label.checkbox-container > span.checkbox > input + .checkbox-icon + .checkbox-text
   ============================================ */

/* Label wrapper */
#nav-filters label,
#nav-filters .checkbox-container {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 13px;
    font-weight: 400;
    color: #333333;
    cursor: pointer;
    display: flex;
    align-items: center;
    padding: 7px 0;
    margin-bottom: 0;
    text-transform: none;
    border-bottom: 1px solid rgba(0, 0, 0, 0.05);
    transition: color 0.15s ease;
    background: transparent;
}

/* Reset mb-2 do tema base */
#nav-filters label.mb-2,
#nav-filters .checkbox-container.mb-2 {
    margin-bottom: 0;
}

#nav-filters label:hover,
#nav-filters .checkbox-container:hover {
    color: #000000;
}

/* Span .checkbox wrapper - deve ser flex row */
#nav-filters .checkbox {
    display: flex;
    align-items: center;
    width: 100%;
    background: transparent;
    gap: 0;
}

/* Checkbox input customizado */
#nav-filters input[type="checkbox"] {
    appearance: none;
    -webkit-appearance: none;
    -moz-appearance: none;
    width: 16px;
    height: 16px;
    min-width: 16px;
    min-height: 16px;
    border: 1.5px solid rgba(0, 0, 0, 0.3);
    border-radius: 3px;
    margin: 0 10px 0 0;
    padding: 0;
    cursor: pointer;
    transition: all 0.15s ease;
    position: relative;
    background: #FFFFFF;
    flex-shrink: 0;
    display: inline-block;
    vertical-align: middle;
}

#nav-filters input[type="checkbox"]:hover {
    border-color: #000000;
}

#nav-filters input[type="checkbox"]:checked {
    background: #000000;
    border-color: #000000;
}

#nav-filters input[type="checkbox"]:checked::after {
    content: '';
    position: absolute;
    top: 1px;
    left: 4px;
    width: 5px;
    height: 9px;
    border: solid #EAFE67;
    border-width: 0 2px 2px 0;
    transform: rotate(45deg);
    display: block;
}

/* Oculta checkbox-icon do tema (substitudo pelo input customizado) */
#nav-filters .checkbox-icon {
    display: none;
    width: 0;
    height: 0;
    overflow: hidden;
}

/* Texto do checkbox - DEVE SER VISVEL */
#nav-filters .checkbox-text {
    color: #333333;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 13px;
    font-weight: 400;
    display: inline;
    background: transparent;
    line-height: 1.4;
}

#nav-filters label:hover .checkbox-text,
#nav-filters .checkbox-container:hover .checkbox-text {
    color: #000000;
}

/* Cores de filtro (swatches) */
#nav-filters .checkbox-color {
    width: 18px;
    height: 18px;
    border-radius: 50%;
    border: 2px solid rgba(0, 0, 0, 0.1);
    margin-left: 8px;
    flex-shrink: 0;
    display: inline-block;
}

/* ============================================
   PREO - Inputs De/At + Boto Aplicar
   ============================================ */

/* Inputs de preo */
#nav-filters input[type="number"],
#nav-filters input[type="text"]:not([autocomplete]) {
    background: #F5F5F5;
    border: 1px solid rgba(0, 0, 0, 0.1);
    border-radius: 3px;
    color: #000000;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 13px;
    padding: 8px 12px;
    outline: none;
    box-shadow: none;
    width: auto;
    max-width: 100px;
}

#nav-filters input[type="number"]:focus,
#nav-filters input[type="text"]:focus {
    border-color: #000000;
    background: #FFFFFF;
}

/* Labels "De" / "At" dentro do filtro de preo */
#nav-filters .price-filter label,
#nav-filters .filter-price label {
    color: #666666;
    font-size: 11px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    border-bottom: none;
    padding: 4px 0;
}

/* Boto APLICAR */
#nav-filters .btn-primary,
#nav-filters .btn-default,
#nav-filters .btn[type="submit"],
#nav-filters button.btn {
    background: #EAFE67;
    color: #000;
    border: none;
    border-radius: 0;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 11px;
    font-weight: 700;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    padding: 10px 24px;
    cursor: pointer;
    transition: all 0.2s ease;
    margin-top: 8px;
}

#nav-filters .btn-primary:hover,
#nav-filters .btn-default:hover,
#nav-filters .btn[type="submit"]:hover,
#nav-filters button.btn:hover {
    background: #d9ec4f;
}

/* Link "Ver todos" / "Ver menos" */
#nav-filters .btn-link,
#nav-filters a.btn-link,
#nav-filters .js-accordion-toggle {
    color: #000000;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 11px;
    font-weight: 600;
    text-transform: uppercase;
    letter-spacing: 0.06em;
    text-decoration: underline;
    padding: 6px 0;
    transition: opacity 0.2s ease;
    background: transparent;
    border: none;
    display: inline-block;
}

#nav-filters .btn-link:hover,
#nav-filters .js-accordion-toggle:hover {
    opacity: 0.7;
    color: #333333;
}

/* ============================================
   OVERLAY DE LOADING
   ============================================ */
#nav-filters .filters-overlay {
    background: rgba(255, 255, 255, 0.85);
}

#nav-filters .filters-updating-message h3 {
    color: #000000;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 13px;
    font-weight: 600;
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
        max-width: 100%;
    }

    #nav-filters .modal-body {
        padding: 20px;
    }

    #nav-filters .modal-header {
        padding: 16px 20px;
    }

    .pg-search-page .category-controls {
        flex-direction: column;
        gap: 12px;
    }

    .pg-search-page .filter-link {
        padding: 8px 18px;
        font-size: 11px;
    }

    .pg-search-page select,
    .pg-search-page .form-select {
        font-size: 11px;
        padding: 8px 32px 8px 14px;
        min-width: 140px;
    }
}


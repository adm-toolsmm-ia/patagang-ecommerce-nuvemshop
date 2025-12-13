/* ===========================================
   PATAGANG - FILTROS E CONTROLES DE CATEGORIA
   =========================================== */

/* Container dos controles */
.pg-search-page .category-controls,
.pg-search-page .js-category-controls {
    padding: 24px 0;
    margin-bottom: 32px;
    border-bottom: 1px solid rgba(0,0,0,0.08);
}

/* Botão de Filtrar - Estilização */
.pg-search-page .filter-link {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-size: 15px !important;
    font-weight: 600 !important;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    color: #000 !important;
    padding: 12px 24px;
    border: 2px solid #000;
    border-radius: 8px;
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
    width: 16px;
    height: 16px;
    fill: currentColor;
}

/* Dropdown de Ordenação - Estilização PADRONIZADA (Igual ao Botão Filtrar) */
.pg-search-page .form-group {
    margin: 0 !important;
}

.pg-search-page select,
.pg-search-page .form-select {
    -webkit-appearance: none;
    -moz-appearance: none;
    appearance: none;
    
    /* Layout Box igual ao botão Filtrar */
    background-color: #fff !important;
    border: 1px solid #000 !important;
    border-radius: 6px !important;
    padding: 8px 35px 8px 16px !important; /* Espaço extra na direita para a seta */
    height: auto !important;
    
    /* Tipografia igual ao botão Filtrar */
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-size: 11px !important;
    font-weight: 600 !important;
    text-transform: uppercase !important;
    letter-spacing: 0.05em !important;
    color: #000 !important;
    
    /* Ícone de Seta (Chevron Down) customizado */
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%23000000' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E") !important;
    background-repeat: no-repeat !important;
    background-position: right 10px center !important;
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
    /* Inverte a cor da seta no hover */
    background-image: url("data:image/svg+xml,%3Csvg xmlns='http://www.w3.org/2000/svg' width='12' height='12' viewBox='0 0 24 24' fill='none' stroke='%23EAFE67' stroke-width='2' stroke-linecap='round' stroke-linejoin='round'%3E%3Cpolyline points='6 9 12 15 18 9'%3E%3C/polyline%3E%3C/svg%3E") !important;
}

.pg-search-page select:focus,
.pg-search-page .form-select:focus {
    outline: none;
}

/* Ícone do select customizado - Remover pois usamos background-image */
.pg-search-page .form-select-arrow,
.pg-search-page .select-icon,
.pg-search-page select + svg,
.pg-search-page select + i {
    display: none !important;
}

/* Filtros aplicados (tags) */
.pg-search-page .filters-container {
    margin-top: 16px;
    margin-bottom: 24px;
    background: transparent !important;
    padding: 0 !important;
}

.pg-search-page .filter-tag,
.pg-search-page .selected-filter {
    display: inline-flex;
    align-items: center;
    gap: 8px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 13px;
    font-weight: 500;
    padding: 8px 16px;
    background: #EAFE67;
    color: #000;
    border-radius: 20px;
    margin: 4px 8px 4px 0;
    transition: all 0.2s ease;
}

.pg-search-page .filter-tag:hover {
    background: #d9ec4f;
}

.pg-search-page .filter-tag-close,
.pg-search-page .selected-filter .remove-filter {
    cursor: pointer;
    opacity: 0.7;
    transition: opacity 0.2s ease;
    margin-left: 4px;
    font-size: 16px;
    line-height: 1;
}

.pg-search-page .filter-tag-close:hover {
    opacity: 1;
}

/* Modal de Filtros (sidebar) - Glassmorphism */
#nav-filters.modal-docked-small {
    background: rgba(255, 255, 255, 0.3) !important;
    backdrop-filter: blur(30px) !important;
    -webkit-backdrop-filter: blur(30px) !important;
}

#nav-filters .modal-header {
    background: transparent;
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-size: 18px !important;
    font-weight: 700 !important;
    text-transform: uppercase;
    padding: 15px 20px;
    border-bottom: 2px solid #EAFE67;
}

#nav-filters .modal-body {
    padding: 20px;
}

/* Grupos de filtros - Layout Limpo */
#nav-filters .filter-group,
#nav-filters .filters-group {
    margin-bottom: 25px;
    background: transparent !important;
    padding: 0 !important;
}

#nav-filters .filter-group-title,
#nav-filters .filters-group-title {
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-size: 14px !important;
    font-weight: 700 !important;
    text-transform: uppercase;
    color: #000;
    margin-bottom: 15px;
    border-bottom: 1px solid #000;
    padding-bottom: 5px;
    display: inline-block;
}

/* Checkboxes customizados e alinhados */
#nav-filters input[type="checkbox"] {
    appearance: none !important;
    -webkit-appearance: none !important;
    width: 18px !important;
    height: 18px !important;
    border: 1px solid #000 !important;
    border-radius: 4px !important;
    margin-right: 10px !important;
    cursor: pointer;
    transition: all 0.2s ease;
    position: relative;
    background: transparent !important;
}

#nav-filters input[type="checkbox"]:checked {
    background: #EAFE67 !important;
    border-color: #000 !important;
}

#nav-filters input[type="checkbox"]:checked::after {
    content: '';
    position: absolute;
    top: 2px;
    left: 5px;
    width: 6px;
    height: 10px;
    border: solid #000;
    border-width: 0 2px 2px 0;
    transform: rotate(45deg);
}

#nav-filters label {
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-size: 13px !important;
    font-weight: 500 !important;
    color: #000;
    cursor: pointer;
    display: flex;
    align-items: center;
    padding: 8px 0;
    text-transform: uppercase;
}

#nav-filters label:hover {
    color: #333;
}

/* Mobile adjustments */
@media (max-width: 768px) {
    .pg-search-page .category-controls {
        flex-direction: column;
        gap: 16px;
    }
    
    .pg-search-page .filter-link,
    .pg-search-page select {
        width: 100%;
        justify-content: center;
    }
}

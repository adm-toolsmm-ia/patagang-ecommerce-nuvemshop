/* ===========================================
   PATAGANG MENU - MODERN V4
   Fundo cinza claro, tipografia clean escura,
   inspirado em Zee.Dog - design limpo e moderno
   =========================================== */

/* 1. Container - Fundo CINZA claro */
#nav-hamburger {
    background: #F5F5F5;
    backdrop-filter: none;
    -webkit-backdrop-filter: none;
    opacity: 1;
    border-right: none;
    box-shadow: 4px 0 24px rgba(0, 0, 0, 0.08);
    width: 100%;
    max-width: 420px;
}

/* 2. Header - Logo + botao fechar */
#nav-hamburger .modal-header {
    background: transparent;
    border: none;
    padding: 40px 32px 32px;
    display: flex;
    justify-content: center;
    align-items: center;
    border-bottom: none;
}

/* Logo no header - escura sobre fundo claro */
.pg-menu-logo {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
}

.pg-menu-logo__img {
    height: 28px;
    width: auto;
    filter: none; /* Logo na cor original (escura) */
    opacity: 1;
}

/* Botao X - escuro minimalista */
#nav-hamburger .modal-close {
    position: absolute;
    top: 40px;
    left: 32px;
    color: #000000;
    opacity: 0.5;
    transition: opacity 0.2s ease;
    font-size: 20px;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 10;
    background: none;
    border: none;
}

#nav-hamburger .modal-close:hover {
    opacity: 1;
}

/* 3. Corpo */
#nav-hamburger .modal-body {
    padding: 0 32px 40px;
    display: flex;
    flex-direction: column;
    background: transparent;
}

.pg-menu-container {
    display: flex;
    flex-direction: column;
    gap: 0;
}

/* 4. Links Principais - Escuro, clean, estilo Zee.Dog */
#nav-hamburger .nav-primary {
    margin: 0;
    padding: 0;
}

#nav-hamburger .nav-list {
    list-style: none;
    padding: 0;
    margin: 0;
}

#nav-hamburger .nav-list > li {
    margin: 0;
    padding: 0;
}

#nav-hamburger .nav-list-link {
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 500;
    font-size: 15px;
    line-height: 1;
    letter-spacing: 0.02em;
    color: #1A1A1A;
    text-transform: none;
    text-align: left;
    opacity: 1;
    padding: 18px 0;
    margin: 0;
    display: flex;
    align-items: center;
    justify-content: space-between;
    transition: color 0.2s ease, background 0.2s ease;
    border: none;
    border-bottom: 1px solid rgba(0, 0, 0, 0.08);
    position: relative;
}

#nav-hamburger .nav-list-link:hover {
    color: #000000;
    opacity: 0.7;
    padding-left: 0;
}

/* Remover indicadores extras */
#nav-hamburger .nav-list-link::before,
#nav-hamburger .nav-list-link::after {
    display: none;
}

/* Seta do Accordion - Escura, estilo Zee.Dog */
#nav-hamburger .nav-list-arrow {
    display: inline-flex;
    align-items: center;
    margin-left: 8px;
    transition: transform 0.2s ease;
}

#nav-hamburger .nav-list-arrow svg {
    width: 10px;
    height: 10px;
    fill: #1A1A1A;
    opacity: 0.4;
    transition: fill 0.2s ease, opacity 0.2s ease;
}

#nav-hamburger .nav-list-link:hover .nav-list-arrow svg {
    fill: #000000;
    opacity: 0.7;
}

#nav-hamburger .js-nav-list-toggle-accordion.accordion-show .nav-list-arrow {
    transform: rotate(180deg);
}

/* 5. Submenus - Indentados, estilo clean */
#nav-hamburger .list-subitems {
    padding-left: 16px;
    margin: 0;
    border-left: 2px solid rgba(0, 0, 0, 0.1);
    list-style: none;
    margin-left: 4px;
}

#nav-hamburger .list-subitems .nav-list-link {
    font-size: 13px;
    font-weight: 400;
    line-height: 1;
    letter-spacing: 0.02em;
    color: rgba(0, 0, 0, 0.6);
    padding: 14px 0;
    border-bottom: 1px solid rgba(0, 0, 0, 0.04);
}

#nav-hamburger .list-subitems .nav-list-link:hover {
    color: #000000;
    opacity: 1;
}

/* 6. Divisor */
.pg-menu-divider {
    display: none;
}

/* 7. Secao de Conta - ESCONDER */
#nav-hamburger .nav-secondary,
#nav-hamburger .nav-account {
    display: none;
}

/* 7.5. Secao O Movimento */
.pg-menu-movimento {
    margin-top: 32px;
    padding-top: 32px;
    border-top: 1px solid rgba(0, 0, 0, 0.08);
}

/* O Movimento - Link com destaque especial */
.pg-menu-movimento__link {
    display: block;
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 600;
    font-size: 15px;
    line-height: 1;
    letter-spacing: 0.02em;
    color: #1A1A1A;
    text-transform: none;
    text-align: left;
    padding: 18px 0;
    margin: 0;
    border: none;
    border-bottom: 1px solid rgba(0, 0, 0, 0.08);
    transition: opacity 0.2s ease;
}

.pg-menu-movimento__link:hover {
    opacity: 0.6;
    padding-left: 0;
}

/* 8. Mobile - Full width */
@media (max-width: 768px) {
    #nav-hamburger {
        max-width: 100%;
    }

    #nav-hamburger .modal-body {
        padding: 0 24px 32px;
    }

    #nav-hamburger .modal-header {
        padding: 36px 24px 28px;
    }

    #nav-hamburger .modal-close {
        top: 36px;
        left: 24px;
    }

    #nav-hamburger .nav-list-link {
        font-size: 16px;
        padding: 20px 0;
    }
}

/* 9. Animacao suave de entrada */
#nav-hamburger.modal-show .nav-list > li {
    animation: pgMenuFadeIn 0.3s ease forwards;
    opacity: 0;
}

#nav-hamburger.modal-show .nav-list > li:nth-child(1) { animation-delay: 0.05s; }
#nav-hamburger.modal-show .nav-list > li:nth-child(2) { animation-delay: 0.1s; }
#nav-hamburger.modal-show .nav-list > li:nth-child(3) { animation-delay: 0.15s; }
#nav-hamburger.modal-show .nav-list > li:nth-child(4) { animation-delay: 0.2s; }
#nav-hamburger.modal-show .nav-list > li:nth-child(5) { animation-delay: 0.25s; }
#nav-hamburger.modal-show .nav-list > li:nth-child(6) { animation-delay: 0.3s; }
#nav-hamburger.modal-show .nav-list > li:nth-child(7) { animation-delay: 0.35s; }

/* Animacao para O Movimento */
#nav-hamburger.modal-show .pg-menu-movimento {
    animation: pgMenuFadeIn 0.4s ease forwards;
    opacity: 0;
    animation-delay: 0.35s;
}

@keyframes pgMenuFadeIn {
    from {
        opacity: 0;
        transform: translateX(-8px);
    }
    to {
        opacity: 1;
        transform: translateX(0);
    }
}

/* ============================================
   DROPDOWN DESKTOP - Abre ao clicar
   ============================================ */

.pg-header__nav-item {
    position: relative;
    display: inline-flex;
    align-items: center;
}

.pg-header__nav-item--has-dropdown {
    position: relative;
}

.pg-header__nav-link--dropdown {
    background: none;
    border: none;
    cursor: pointer;
    display: inline-flex;
    align-items: center;
    gap: 4px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 500;
    font-size: 12px;
    color: #000;
    text-transform: uppercase;
    letter-spacing: 0.08em;
    padding: 8px 0;
}

.pg-header__nav-link--dropdown:hover {
    opacity: 0.7;
}

.pg-header__nav-arrow {
    transition: transform 0.2s ease;
    opacity: 0.6;
}

.pg-header__nav-link--dropdown.is-active .pg-header__nav-arrow {
    transform: rotate(180deg);
}

/* Dropdown Container */
.pg-header__dropdown {
    display: none !important;
    position: absolute;
    top: 100%;
    left: 50%;
    transform: translateX(-50%);
    min-width: 200px;
    background: #fff;
    border-radius: 8px;
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.15);
    padding: 12px 0;
    z-index: 1000;
    opacity: 0;
    visibility: hidden;
    transition: opacity 0.2s ease, visibility 0.2s ease;
    margin-top: 8px;
}

.pg-header__dropdown.is-open {
    display: block !important;
    opacity: 1;
    visibility: visible;
}

/* Guarda adicional contra regressao de submenu exposto no desktop */
.pg-header__nav-desktop .nav-dropdown-content {
    display: none !important;
    visibility: hidden !important;
    opacity: 0 !important;
}

.pg-header__dropdown-inner {
    display: flex;
    flex-direction: column;
}

.pg-header__dropdown-link {
    display: block;
    padding: 10px 20px;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 13px;
    font-weight: 400;
    color: #333;
    text-decoration: none;
    transition: background 0.15s ease, color 0.15s ease;
}

.pg-header__dropdown-link:hover {
    background: #f5f5f5;
    color: #000;
}

.pg-header__dropdown-link--all {
    font-weight: 600;
    border-bottom: 1px solid #eee;
    margin-bottom: 4px;
    padding-bottom: 12px;
}


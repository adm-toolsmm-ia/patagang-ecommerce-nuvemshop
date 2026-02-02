/* ===========================================
   PATAGANG MENU - MODERN V4
   Fundo cinza claro, tipografia clean escura,
   inspirado em Zee.Dog - design limpo e moderno
   =========================================== */

/* 1. Container - Fundo CINZA claro */
#nav-hamburger {
    background: #F5F5F5 !important;
    backdrop-filter: none !important;
    -webkit-backdrop-filter: none !important;
    opacity: 1 !important;
    border-right: none !important;
    box-shadow: 4px 0 24px rgba(0, 0, 0, 0.08) !important;
    width: 100% !important;
    max-width: 420px !important;
}

/* 2. Header - Logo + botao fechar */
#nav-hamburger .modal-header {
    background: transparent !important;
    border: none !important;
    padding: 40px 32px 32px !important;
    display: flex;
    justify-content: center !important;
    align-items: center;
    border-bottom: none !important;
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
    color: #000000 !important;
    opacity: 0.5 !important;
    transition: opacity 0.2s ease;
    font-size: 20px !important;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 10;
    background: none !important;
    border: none !important;
}

#nav-hamburger .modal-close:hover {
    opacity: 1 !important;
}

/* 3. Corpo */
#nav-hamburger .modal-body {
    padding: 0 32px 40px !important;
    display: flex;
    flex-direction: column;
    background: transparent !important;
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
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-weight: 500 !important;
    font-size: 15px !important;
    line-height: 1 !important;
    letter-spacing: 0.02em !important;
    color: #1A1A1A !important;
    text-transform: none !important;
    text-align: left !important;
    opacity: 1 !important;
    padding: 18px 0 !important;
    margin: 0 !important;
    display: flex !important;
    align-items: center;
    justify-content: space-between;
    transition: color 0.2s ease, background 0.2s ease;
    border: none !important;
    border-bottom: 1px solid rgba(0, 0, 0, 0.08) !important;
    position: relative;
}

#nav-hamburger .nav-list-link:hover {
    color: #000000 !important;
    opacity: 0.7 !important;
    padding-left: 0 !important;
}

/* Remover indicadores extras */
#nav-hamburger .nav-list-link::before,
#nav-hamburger .nav-list-link::after {
    display: none !important;
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
    fill: #1A1A1A !important;
    opacity: 0.4;
    transition: fill 0.2s ease, opacity 0.2s ease;
}

#nav-hamburger .nav-list-link:hover .nav-list-arrow svg {
    fill: #000000 !important;
    opacity: 0.7;
}

#nav-hamburger .js-nav-list-toggle-accordion.accordion-show .nav-list-arrow {
    transform: rotate(180deg);
}

/* 5. Submenus - Indentados, estilo clean */
#nav-hamburger .list-subitems {
    padding-left: 16px !important;
    margin: 0 !important;
    border-left: 2px solid rgba(0, 0, 0, 0.1) !important;
    list-style: none;
    margin-left: 4px !important;
}

#nav-hamburger .list-subitems .nav-list-link {
    font-size: 13px !important;
    font-weight: 400 !important;
    line-height: 1 !important;
    letter-spacing: 0.02em !important;
    color: rgba(0, 0, 0, 0.6) !important;
    padding: 14px 0 !important;
    border-bottom: 1px solid rgba(0, 0, 0, 0.04) !important;
}

#nav-hamburger .list-subitems .nav-list-link:hover {
    color: #000000 !important;
    opacity: 1 !important;
}

/* 6. Divisor */
.pg-menu-divider {
    display: none !important;
}

/* 7. Secao de Conta - ESCONDER */
#nav-hamburger .nav-secondary,
#nav-hamburger .nav-account {
    display: none !important;
}

/* 7.5. Secao O Movimento */
.pg-menu-movimento {
    margin-top: 32px;
    padding-top: 32px;
    border-top: 1px solid rgba(0, 0, 0, 0.08);
}

/* O Movimento - Link com destaque especial */
.pg-menu-movimento__link {
    display: block !important;
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-weight: 600 !important;
    font-size: 15px !important;
    line-height: 1 !important;
    letter-spacing: 0.02em !important;
    color: #1A1A1A !important;
    text-transform: none !important;
    text-align: left !important;
    padding: 18px 0 !important;
    margin: 0 !important;
    border: none !important;
    border-bottom: 1px solid rgba(0, 0, 0, 0.08) !important;
    transition: opacity 0.2s ease;
}

.pg-menu-movimento__link:hover {
    opacity: 0.6 !important;
    padding-left: 0 !important;
}

/* 8. Mobile - Full width */
@media (max-width: 768px) {
    #nav-hamburger {
        max-width: 100% !important;
    }

    #nav-hamburger .modal-body {
        padding: 0 24px 32px !important;
    }

    #nav-hamburger .modal-header {
        padding: 36px 24px 28px !important;
    }

    #nav-hamburger .modal-close {
        top: 36px;
        left: 24px;
    }

    #nav-hamburger .nav-list-link {
        font-size: 16px !important;
        padding: 20px 0 !important;
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

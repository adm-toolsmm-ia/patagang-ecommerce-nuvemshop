/* ===========================================
   PATAGANG MENU - ADOBE XD PROTOTYPE EXACT
   =========================================== */

/* 1. Container - Fundo TRANSPARENTE com Blur */
#nav-hamburger {
    background: rgba(255, 255, 255, 0.08) !important; /* Leve tint para legibilidade */
    backdrop-filter: blur(40px) saturate(120%) !important;
    -webkit-backdrop-filter: blur(40px) saturate(120%) !important;
    opacity: 1 !important;
    border-right: none !important;
    box-shadow: none !important;
    width: 100% !important;
    max-width: 480px !important;
}

/* 2. Header - Logo Centralizado */
#nav-hamburger .modal-header {
    background: transparent !important;
    border: none !important;
    padding: 32px 28px 24px 28px !important;
    display: flex;
    justify-content: center !important; /* Centralizado */
    align-items: center;
    border-bottom: 1px solid rgba(234, 254, 103, 0.2);
}

/* Logo no header */
.pg-menu-logo {
    display: flex;
    justify-content: center;
    align-items: center;
    width: 100%;
}

.pg-menu-logo__img {
    height: 32px;
    width: auto;
    opacity: 0.9;
}

/* Botão X agora posicionado absolute no canto */
#nav-hamburger .modal-close {
    position: absolute;
    top: 32px;
    left: 28px;
    color: #000 !important;
    opacity: 0.5 !important;
    transition: opacity 0.2s ease;
    font-size: 18px !important;
    cursor: pointer;
    display: flex;
    align-items: center;
    justify-content: center;
    z-index: 10;
}

#nav-hamburger .modal-close:hover {
    opacity: 1 !important;
}

/* 3. Corpo - Padding ajustado */
#nav-hamburger .modal-body {
    padding: 24px 28px 32px 28px !important; /* Reduzido padding top */
    display: flex;
    flex-direction: column;
}

.pg-menu-container {
    display: flex;
    flex-direction: column;
    gap: 0;
}

/* 4. Links Principais - EXATAMENTE como Adobe XD */
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
    /* Adobe XD ajustado para compactar */
    font-family: 'Familjen Grotesk', sans-serif !important;
    font-weight: normal !important;
    font-size: 17px !important; /* Reduzido de 20px */
    line-height: 50px !important; /* Reduzido de 75px para compactar */
    letter-spacing: 0px !important;
    color: #EAFE67 !important;
    text-transform: uppercase !important;
    text-align: left !important;
    opacity: 1 !important;

    padding: 0 !important;
    margin: 0 !important;
    display: block !important;
    transition: opacity 0.2s ease;
    border: none !important;
    border-bottom: 1px solid #EAFE67 !important;
    position: relative;
}

#nav-hamburger .nav-list-link:hover {
    opacity: 0.8 !important;
}

/* Remover indicadores extras */
#nav-hamburger .nav-list-link::before,
#nav-hamburger .nav-list-link::after {
    display: none !important;
}

/* Seta do Accordion - Amarela */
#nav-hamburger .nav-list-arrow {
    display: inline-flex;
    align-items: center;
    margin-left: 8px;
    transition: transform 0.2s ease;
}

#nav-hamburger .nav-list-arrow svg {
    width: 12px;
    height: 12px;
    fill: #EAFE67 !important;
    opacity: 1;
}

#nav-hamburger .js-nav-list-toggle-accordion.accordion-show .nav-list-arrow {
    transform: rotate(180deg);
}

/* 5. Submenus - Mesma estética */
#nav-hamburger .list-subitems {
    padding-left: 20px !important;
    margin: 0 !important;
    border-left: none !important;
    list-style: none;
}

#nav-hamburger .list-subitems .nav-list-link {
    font-size: 15px !important; /* Reduzido proporcionalmente */
    font-weight: normal !important;
    line-height: 45px !important; /* Reduzido proporcionalmente */
    color: #EAFE67 !important;
    opacity: 0.8 !important;
    border-bottom: 1px solid rgba(234, 254, 103, 0.5) !important;
}

#nav-hamburger .list-subitems .nav-list-link:hover {
    opacity: 1 !important;
}

/* 6. Divisor - REMOVER */
.pg-menu-divider {
    display: none !important;
}

/* 7. Seção de Conta - ESCONDER */
#nav-hamburger .nav-secondary,
#nav-hamburger .nav-account {
    display: none !important;
}

/* 7.5. Seção O Movimento - Mobile (Link único) */
.pg-menu-movimento {
    margin-top: 24px;
    padding-top: 24px;
    border-top: 1px solid rgba(234, 254, 103, 0.2);
}

/* Animação fadeIn para seção O Movimento */
#nav-hamburger.modal-show .pg-menu-movimento {
    animation: fadeIn 0.3s ease forwards;
    opacity: 0;
    animation-delay: 0.3s;
}

/* 8. Mobile - Ajustes proporcionais */
@media (max-width: 768px) {
    #nav-hamburger {
        max-width: 100% !important;
    }

    #nav-hamburger .modal-body {
        padding: 80px 20px 24px 20px !important;
    }

    #nav-hamburger .modal-header {
        padding: 24px 20px 0 20px !important;
    }

    #nav-hamburger .nav-list-link {
        font-size: 18px !important;
        line-height: 60px !important;
    }
}

/* 9. Animação suave */
#nav-hamburger.modal-show .nav-list > li {
    animation: fadeIn 0.3s ease forwards;
    opacity: 0;
}

#nav-hamburger.modal-show .nav-list > li:nth-child(1) { animation-delay: 0.05s; }
#nav-hamburger.modal-show .nav-list > li:nth-child(2) { animation-delay: 0.1s; }
#nav-hamburger.modal-show .nav-list > li:nth-child(3) { animation-delay: 0.15s; }
#nav-hamburger.modal-show .nav-list > li:nth-child(4) { animation-delay: 0.2s; }
#nav-hamburger.modal-show .nav-list > li:nth-child(5) { animation-delay: 0.25s; }
#nav-hamburger.modal-show .nav-list > li:nth-child(6) { animation-delay: 0.3s; }
#nav-hamburger.modal-show .nav-list > li:nth-child(7) { animation-delay: 0.35s; }
#nav-hamburger.modal-show .nav-list > li:nth-child(8) { animation-delay: 0.4s; }
#nav-hamburger.modal-show .nav-list > li:nth-child(9) { animation-delay: 0.45s; }
#nav-hamburger.modal-show .nav-list > li:nth-child(10) { animation-delay: 0.5s; }

@keyframes fadeIn {
    from {
        opacity: 0;
        transform: translateY(-5px);
    }
    to {
        opacity: 1;
        transform: translateY(0);
    }
}

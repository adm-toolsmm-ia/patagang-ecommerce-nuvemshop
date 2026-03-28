/* ===========================================
   WHATSAPP BUTTON - PATAGANG v1.5.65
   Floating button on LEFT side (opposite of Help Sidebar)
   Same design as .pg-help-btn, positioned left instead of right
   =========================================== */

/* 1. Floating WhatsApp Button (LEFT side) */
.btn-whatsapp-left {
    position: fixed;
    left: 0;
    top: 50%;
    transform: translateY(-50%);
    background: #F0F0F0; /* Light gray - matches header icon style */
    color: #1A1A1A; /* Black Text */
    z-index: 9990;
    cursor: pointer;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 12px 8px;
    border-top-right-radius: 4px;
    border-bottom-right-radius: 4px;
    box-shadow: 2px 0 8px rgba(0,0,0,0.1);
    transition: all 0.3s ease;
    text-decoration: none;
}

.btn-whatsapp-left:hover {
    background: #E8E8E8; /* Slightly darker gray on hover */
    padding-left: 12px;
}

.btn-whatsapp-left svg {
    width: 20px;
    height: 20px;
    color: #1A1A1A; /* Black Icon */
}

.btn-whatsapp-left span {
    writing-mode: vertical-rl;
    text-orientation: mixed;
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 500;
    font-size: 12px;
    letter-spacing: 0.03em;
    text-transform: uppercase;
    margin-top: 6px;
    color: #1A1A1A;
    display: inline-block;
    /* Removido: transform: scaleX(-1) rotateZ(180deg); */
    /* Texto agora lido naturalmente de cima para baixo no lado esquerdo */
}

/* Mobile Tweaks - button centered vertically (same as pg-help-btn) */
@media (max-width: 768px) {
    .btn-whatsapp-left {
        top: 50%;
        transform: translateY(-50%);
        left: 0;
        padding: 10px 6px;
        z-index: 9990;
    }
    .btn-whatsapp-left span {
        font-size: 11px;
    }
}

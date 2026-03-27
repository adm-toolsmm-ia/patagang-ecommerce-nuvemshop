/* ===========================================
   WHATSAPP BUTTON - PATAGANG v1.5.65
   Floating button on LEFT side (opposite of Help Sidebar)
   Same design as .pg-help-btn, positioned left instead of right
   =========================================== */

/* 1. Floating WhatsApp Button (LEFT side)  BEM Pattern */
.btn-whatsapp-left {
    position: fixed;
    left: 0;
    top: 50%;
    transform: translateY(-50%);
    background: #F0F0F0; /* Light gray - matches pg-help-btn */
    color: #1A1A1A; /* Black Text */
    z-index: 9990;
    cursor: pointer;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 16px 10px;
    border-top-right-radius: 4px;
    border-bottom-right-radius: 4px;
    box-shadow: 2px 0 8px rgba(0,0,0,0.1);
    transition: all 0.3s ease;
    text-decoration: none;
}

.btn-whatsapp-left:hover {
    background: #E8E8E8; /* Slightly darker gray on hover */
    padding-left: 14px;
}

.btn-whatsapp-left:focus {
    outline: 2px solid #EAFE67;
    outline-offset: 2px;
}

/* BEM: Icon element */
.btn-whatsapp-left__icon {
    width: 24px;
    height: 24px;
    color: #1A1A1A; /* Black Icon */
    fill: currentColor;
    display: block;
    flex-shrink: 0;
}

/* BEM: Text element  vertical layout with rotate for left-side reading */
.btn-whatsapp-left__text {
    writing-mode: vertical-rl;
    text-orientation: mixed;
    transform: rotate(180deg); /* Inverted text direction for left-side readability */
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 500;
    font-size: 13px;
    letter-spacing: 0.03em;
    text-transform: uppercase;
    margin-bottom: 8px; /* Space between icon and text */
    color: #1A1A1A;
    display: inline-block;
}

/* Fallback for legacy <span> pattern (if still used) */
.btn-whatsapp-left span {
    writing-mode: vertical-rl;
    text-orientation: mixed;
    transform: rotate(180deg);
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 500;
    font-size: 12px;
    letter-spacing: 0.03em;
    text-transform: uppercase;
    margin-bottom: 6px;
    color: #1A1A1A;
    display: inline-block;
}

/* Mobile Tweaks - button centered vertically (same as pg-help-btn) */
@media (max-width: 768px) {
    .btn-whatsapp-left {
        top: 50%;
        transform: translateY(-50%);
        left: 0;
        padding: 13px 8px;
        z-index: 9990;
    }
    .btn-whatsapp-left span {
        font-size: 11px;
    }
}

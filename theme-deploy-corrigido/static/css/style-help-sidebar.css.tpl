/* ===========================================
   FLOATING HELP SIDEBAR - PATAGANG
   =========================================== */

/* 1. Floating Button */
.pg-help-btn {
    position: fixed;
    right: 0;
    top: 50%;
    transform: translateY(-50%);
    background: #F0F0F0; /* Light gray - matches production design */
    color: #1A1A1A; /* Black Text */
    z-index: 9990;
    cursor: pointer;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    padding: 16px 10px;
    border-top-left-radius: 4px;
    border-bottom-left-radius: 4px;
    box-shadow: -2px 0 8px rgba(0,0,0,0.1);
    transition: all 0.3s ease;
}

.pg-help-btn:hover {
    background: #E8E8E8; /* Slightly darker gray on hover */
    padding-right: 14px;
}

.pg-help-btn__text {
    writing-mode: vertical-rl;
    text-orientation: mixed;
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 500;
    font-size: 13px;
    letter-spacing: 0.03em;
    text-transform: uppercase;
    margin-bottom: 8px;
    color: #1A1A1A;
}

.pg-help-btn__icon {
    width: 24px;
    height: 24px;
    color: #1A1A1A; /* Black Icon - stroke-based SVG uses currentColor */
}

/* 2. Sidebar Overlay */
.pg-help-overlay {
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background: rgba(0, 0, 0, 0.5);
    z-index: 9998;
    opacity: 0;
    visibility: hidden;
    transition: all 0.3s ease;
    backdrop-filter: blur(2px);
}

.pg-help-overlay.is-active {
    opacity: 1;
    visibility: visible;
}

/* 3. Sidebar Container */
.pg-help-sidebar {
    position: fixed;
    top: 0;
    right: -400px;
    width: 100%;
    max-width: 360px;
    height: 100%;
    background: #FFFFFF;
    z-index: 9999;
    box-shadow: -4px 0 24px rgba(0,0,0,0.15);
    transition: right 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
    display: flex;
    flex-direction: column;
}

.pg-help-sidebar.is-active {
    right: 0;
}

/* 4. Sidebar Header */
.pg-help-sidebar__header {
    padding: 24px;
    display: flex;
    align-items: center;
    justify-content: space-between;
    border-bottom: 1px solid #F0F0F0;
}

.pg-help-sidebar__title {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 18px;
    font-weight: 700;
    color: #1A1A1A;
    margin: 0;
    display: flex;
    align-items: center;
    gap: 12px;
}

.pg-help-sidebar__close {
    background: none;
    border: none;
    cursor: pointer;
    padding: 8px;
    color: #999;
    transition: color 0.2s;
    display: flex;
    align-items: center;
    justify-content: center;
}

.pg-help-sidebar__close:hover {
    color: #000;
}

/* 5. Sidebar Body */
.pg-help-sidebar__body {
    flex: 1;
    overflow-y: auto;
    padding: 24px;
    display: flex;
    flex-direction: column;
    gap: 16px;
}

/* 6. Action Links Grid */
.pg-help-grid {
    display: grid;
    grid-template-columns: repeat(2, 1fr);
    gap: 12px;
}

.pg-help-item {
    background: #F9F9F9;
    border-radius: 8px;
    padding: 20px 12px;
    display: flex;
    flex-direction: column;
    align-items: center;
    justify-content: center;
    text-align: center;
    text-decoration: none;
    color: #1A1A1A;
    transition: all 0.2s ease;
    border: 1px solid transparent;
    height: 100%;
    min-height: 110px;
}

.pg-help-item:hover {
    background: #FFFFFF;
    border-color: #E0E0E0;
    transform: translateY(-2px);
    box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    color: #000;
}

.pg-help-item__icon {
    width: 28px;
    height: 28px;
    margin-bottom: 12px;
    fill: #1A1A1A;
    transition: transform 0.2s ease;
}

.pg-help-item:hover .pg-help-item__icon {
    transform: scale(1.1);
}

/* Image Icon Support */
img.pg-help-item__icon {
    object-fit: contain;
    filter: none;
}

.pg-help-item__text {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 13px;
    font-weight: 600;
    line-height: 1.3;
}

/* Order Tracking Specific */
.pg-help-tracking {
    background: #F5F5F5;
    padding: 20px;
    border-radius: 8px;
    margin-bottom: 24px;
}

.pg-help-tracking__title {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 14px;
    font-weight: 700;
    margin-bottom: 12px;
    display: flex;
    align-items: center;
    gap: 8px;
}

.pg-help-tracking__input-group {
    display: flex;
    gap: 8px;
}

.pg-help-tracking__input {
    flex: 1;
    border: 1px solid #E0E0E0;
    border-radius: 4px;
    padding: 8px 12px;
    font-size: 14px;
    font-family: 'Familjen Grotesk', sans-serif;
}

.pg-help-tracking__btn {
    background: #00CC66; /* WhatsApp Green / Positive */
    color: #FFF;
    border: none;
    border-radius: 4px;
    padding: 0 16px;
    font-weight: 700;
    font-size: 13px;
    cursor: pointer;
    transition: background 0.2s;
    font-family: 'Familjen Grotesk', sans-serif;
}

.pg-help-tracking__btn:hover {
    background: #00B359;
}

/* 7. Newsletter Section */
.pg-help-newsletter {
    margin-top: auto;
    background: #FFF8E6; /* Light yellow/beige */
    padding: 20px 20px 30px 20px; /* Increased bottom padding */
    border-radius: 8px;
    position: relative;
    overflow: hidden;
}

.pg-help-newsletter__content {
    position: relative;
    z-index: 2;
}

.pg-help-newsletter__title {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 15px;
    font-weight: 800;
    margin-bottom: 4px;
    color: #000;
}

.pg-help-newsletter__text {
    font-size: 12px;
    color: #555;
    margin-bottom: 12px;
}

.pg-help-newsletter__form {
    display: flex;
    flex-direction: column;
    gap: 8px;
}

.pg-help-newsletter__input {
    border: 1px solid rgba(0,0,0,0.1);
    background: #FFF;
    padding: 10px;
    border-radius: 4px;
    font-size: 13px;
    font-family: 'Familjen Grotesk', sans-serif;
    width: 100%;
}

.pg-help-newsletter__submit {
    background: #1A1A1A;
    color: #FFF;
    border: none;
    padding: 10px;
    border-radius: 4px;
    font-weight: 700;
    font-size: 13px;
    cursor: pointer;
    transition: background 0.2s;
    font-family: 'Familjen Grotesk', sans-serif;
    text-transform: uppercase;
}

.pg-help-newsletter__submit:hover {
    background: #000;
}

.pg-help-newsletter__cat {
    position: absolute;
    bottom: -10px;
    right: -10px;
    width: 80px;
    height: auto;
    opacity: 0.15;
    z-index: 1;
    pointer-events: none;
}

/* Mobile Tweaks - botão centralizado verticalmente (igual ao WhatsApp) */
@media (max-width: 768px) {
    .pg-help-btn {
        top: 50%;
        transform: translateY(-50%);
        right: 0;
        padding: 13px 8px;
        z-index: 9990;
    }
    .pg-help-btn__text {
        font-size: 11px;
    }
    
    .pg-help-sidebar {
        width: 85%;
        max-width: none;
    }
}


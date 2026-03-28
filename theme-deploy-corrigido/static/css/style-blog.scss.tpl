/* ============================================================================
   BLOG STYLES - PATAGANG
   Cards com glassmorphism e destaque visual
============================================================================ */

/* Espaçamento horizontal entre os cards */
.pg-page .row {
    margin-left: -12px;
    margin-right: -12px;
}

.pg-page .row > [class*="col-"] {
    padding-left: 12px;
    padding-right: 12px;
    margin-bottom: 24px;
}

/* Visual de card com glassmorphism para cada post */
.pg-page article {
    background: rgba(255, 255, 255, 0.7);
    backdrop-filter: blur(10px);
    -webkit-backdrop-filter: blur(10px);
    border-radius: 24px;
    padding: 24px;
    border: 2px solid rgba(255, 255, 255, 0.8);
    box-shadow: 0 8px 24px rgba(0, 0, 0, 0.12);
    transition: all 0.4s cubic-bezier(0.25, 0.8, 0.25, 1);
    height: 100%;
    display: flex;
    flex-direction: column;
    position: relative;
}

.pg-page article .post-item__content {
    flex: 1;
    display: flex;
    flex-direction: column;
}

.pg-page article::before {
    content: '';
    position: absolute;
    inset: 0;
    border-radius: 24px;
    padding: 2px;
    background: linear-gradient(135deg, rgba(234, 254, 103, 0.3), rgba(255, 255, 255, 0.1));
    -webkit-mask: linear-gradient(#fff 0 0) content-box, linear-gradient(#fff 0 0);
    -webkit-mask-composite: xor;
    mask-composite: exclude;
    pointer-events: none;
}

.pg-page article:hover {
    transform: translateY(-8px) scale(1.02);
    box-shadow: 0 16px 40px rgba(0, 0, 0, 0.18);
    border-color: rgba(234, 254, 103, 0.6);
    background: rgba(255, 255, 255, 0.85);
}

/* Link da imagem - Container com altura fixa para garantir alinhamento */
.pg-page article .post-item__image-link {
    display: block;
    margin-bottom: 16px;
    text-decoration: none;
    height: 240px;
    overflow: hidden;
    border-radius: 16px;
    position: relative;
}

/* Garantir que imagens fiquem visíveis e dentro do card - Altura fixa para alinhamento */
.pg-page article .post-item__image,
.pg-page article .post-item__image--placeholder,
.pg-page article .post-item__image-link img {
    display: block;
    width: 100%;
    height: 240px;
    object-fit: cover;
    border-radius: 16px;
    margin: 0;
}

/* Título do Card */
.pg-page article .post-item__title,
.pg-page article h3 {
    margin-top: 0;
    margin-bottom: 12px;
}

.pg-page article .post-item__title a,
.pg-page article h3 a {
    font-family: 'Familjen Grotesk', sans-serif;
    font-weight: 800;
    color: #000;
    text-decoration: none;
    font-size: 15px;
    line-height: 1.2;
    text-transform: uppercase;
    letter-spacing: 0.5px;
    transition: color 0.2s ease;
}

.pg-page article:hover .post-item__title a,
.pg-page article:hover h3 a {
    color: #333;
}

/* Data do post */
.pg-page article .post-item__date {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 12px;
    text-transform: uppercase;
    letter-spacing: 1px;
    color: #666;
    margin-bottom: 12px;
    font-weight: 600;
}

/* Resumo do post */
.pg-page article .post-item__summary {
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 15px;
    line-height: 1.6;
    color: #333;
    margin-bottom: 20px;
    flex-grow: 1; /* Empurra o botão para baixo */
}

/* Botão Ler Mais */
.pg-page article .post-item__read-more,
.pg-page article .btn-link {
    display: inline-block;
    margin-top: auto;
    font-family: 'Familjen Grotesk', sans-serif;
    font-size: 14px;
    letter-spacing: 1px;
    color: #000;
    text-decoration: underline;
    text-decoration-color: #EAFE67;
    text-decoration-thickness: 3px;
    font-weight: bold;
    text-transform: uppercase;
    transition: all 0.2s ease;
}

.pg-page article .post-item__read-more:hover,
.pg-page article .btn-link:hover {
    background-color: #EAFE67;
    color: #000;
    text-decoration: none;
    padding: 2px 4px;
    margin: -2px -4px; /* Compensa o padding para não mover */
    border-radius: 4px;
}

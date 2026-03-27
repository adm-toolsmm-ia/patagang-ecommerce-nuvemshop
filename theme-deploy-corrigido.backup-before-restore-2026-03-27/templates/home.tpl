{#
  HOME PAGE V2 - PATAGANG
  Implementado conforme protótipo Adobe XD - Janeiro 2026
  Plano executado: textos, margens, cards, 5 produtos.

  Estrutura:
  1. Hero (split-screen: blueprint + foto)
  2. Vista o Propósito (produtos categoria)
  3. Seja o Primeiro a Conhecer (produtos em desenvolvimento)
#}

{# ============================================
   1ª SEÇÃO - HERO V2
   Background: imagem responsiva (desktop/mobile)
   CTAs: Amarelos sobre cada coluna
   ============================================ #}
<section class="pg-hero-v2 visible-when-content-ready">
    {# Background responsivo #}
    <picture class="pg-hero-v2__bg">
        <source media="(min-width: 768px)" srcset="{{ 'images/home-v2-hero-desktop.png' | static_url }}">
        <img src="{{ 'images/home-v2-hero-mobile.png' | static_url }}"
             alt="Patagang - Muito além do básico"
             loading="eager"
             class="pg-hero-v2__bg-img">
    </picture>

    {# Container dos CTAs #}
    <div class="pg-hero-v2__content">
        <div class="pg-hero-v2__ctas">
            {# CTA 1: Produtos para Cachorro (sobre blueprint) #}
            <a href="/produtos-cachorros" class="pg-button pg-button--highlight">
                PRODUTOS PARA CACHORRO
            </a>

            {# CTA 2: Vista o Propósito (sobre foto) #}
            <a href="/comunidade-vista-patagang" class="pg-button pg-button--highlight">
                VISTA O PROPÓSITO
            </a>
        </div>
    </div>

    {# Seta de scroll #}
    <div class="pg-hero-v2__scroll">
        <svg width="32" height="32" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
            <path d="M6 9L12 15L18 9" stroke="#626262" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
        </svg>
    </div>

    {# Texto SEO oculto #}
    <h1 class="sr-only">Patagang - Acessórios Premium para Cães e Tutores</h1>
    <p class="sr-only">Uma marca pet que vai além. Acessórios com design exclusivo para cães e tutores que buscam estilo e qualidade.</p>
</section>

{# ============================================
   2ª SEÇÃO - VISTA O PROPÓSITO
   Produtos da categoria "Vista Patagang"
   Background: Branco com transição suave para próxima seção
   ============================================ #}
<section class="pg-section pg-section--vista-products visible-when-content-ready">
    <div class="pg-container">

        {# Header da seção #}
        <header class="pg-section__header">
            <h3 class="pg-section__title">VISTA O PROPÓSITO</h3>
            <p class="pg-section__desc">
                Camisetas que carregam o movimento Patagang. Parte de cada venda é destinada à causa animal.
            </p>
        </header>

        {# Grid de Produtos - Busca pela seção primária com filtro de categoria #}
        <div class="pg-products-grid">
            {% set vista_products = [] %}

            {# Tenta buscar produtos da seção primária #}
            {% if sections.primary.products %}
                {% for product in sections.primary.products %}
                    {% set vista_products = vista_products | merge([product]) %}
                {% endfor %}
            {% endif %}

            {# Fallback: busca todos os produtos e filtra pela categoria #}
            {% if vista_products | length == 0 %}
                {% for product in products %}
                    {% if '/comunidade-vista-patagang' in product.category.url or 'Vista' in product.category.name %}
                        {% set vista_products = vista_products | merge([product]) %}
                    {% endif %}
                {% endfor %}
            {% endif %}

            {# Renderiza os produtos (máximo 5) #}
            {% for product in vista_products | slice(0, 5) %}
                <article class="pg-product-card-v2">
                    <a href="{{ product.url }}" class="pg-product-card-v2__link">
                        <div class="pg-product-card-v2__image">
                            {% if product.featured_image %}
                                <img src="{{ product.featured_image | product_image_url('large') }}"
                                     alt="{{ product.name }}"
                                     loading="lazy">
                                {# Segunda imagem para hover (se existir) #}
                                {% if product.images | length > 1 %}
                                    <img src="{{ product.images[1] | product_image_url('large') }}"
                                         alt="{{ product.name }}"
                                         loading="lazy"
                                         class="pg-product-card-v2__img-hover">
                                {% endif %}
                            {% else %}
                                <img src="{{ 'images/placeholder-product.png' | static_url }}"
                                     alt="{{ product.name }}"
                                     loading="lazy">
                            {% endif %}
                        </div>
                    </a>
                    <a href="{{ product.url }}" class="pg-product-card-v2__shop">Shop</a>
                </article>
            {% else %}
                {# Fallback se não houver produtos #}
                <div class="pg-section__empty">
                    <p>Produtos em breve...</p>
                </div>
            {% endfor %}
        </div>

    </div>
</section>

{# ============================================
   3ª SEÇÃO - SEJA O PRIMEIRO A CONHECER
   Produtos com tag "em-desenvolvimento"
   Cards carregados via API JS (fetch dinâmico)
   ============================================ #}

{# Server-side: tenta buscar produtos com tag em-desenvolvimento via Twig #}
{% set dev_products = [] %}
{% set dev_max = 8 %}

{% if sections.primary.products %}
    {% for product in sections.primary.products %}
        {% if dev_products | length < dev_max and product.tags %}
            {% for tag in product.tags %}
                {% if tag == 'em-desenvolvimento' or tag == 'em desenvolvimento' %}
                    {% set dev_products = dev_products | merge([product]) %}
                {% endif %}
            {% endfor %}
        {% endif %}
    {% endfor %}
{% endif %}

{% if dev_products | length == 0 %}
    {% for product in products %}
        {% if dev_products | length < dev_max and product.tags %}
            {% for tag in product.tags %}
                {% if tag == 'em-desenvolvimento' or tag == 'em desenvolvimento' %}
                    {% set dev_products = dev_products | merge([product]) %}
                {% endif %}
            {% endfor %}
        {% endif %}
    {% endfor %}
{% endif %}

<section class="pg-home-dev-section visible-when-content-ready">
    <div class="pg-container">
        
        <header class="pg-section__header">
            <h3 class="pg-section__title">SEJA O PRIMEIRO A CONHECER</h3>

        {# CRITICAL CSS INLINE - Garante que o visual novo carregue sem cache #}
        <style>
            /* Namespace: .pg-reborn-card (Reference 'Vista o Propósito' + Backup Size) */
            .pg-reborn-card {
                display: flex;
                flex-direction: column;
                width: 200px; /* Tamanho fixo e pequeno */
                flex-shrink: 0;
                margin-right: 16px;
                cursor: pointer;
                text-decoration: none !important;
                color: inherit;
                transition: all 0.3s cubic-bezier(0.25, 0.8, 0.25, 1);
                
                /* Estilo Visual 'Vista o Propósito' */
                background: #F6F6F6;
                border-radius: 24px;
                padding: 12px;
                box-sizing: border-box;
                box-shadow: 0 4px 10px rgba(0,0,0,0.03);
            }

            .pg-reborn-card:hover {
                transform: translateY(-6px);
                box-shadow: 0 10px 25px rgba(0,0,0,0.08);
            }

            .pg-reborn-card__content {
                display: flex;
                flex-direction: column;
                height: 100%;
                gap: 12px;
            }

            .pg-reborn-card__image {
                width: 100%;
                aspect-ratio: 1 / 1;
                background: #FFFFFF;
                border-radius: 16px;
                overflow: hidden;
                position: relative;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .pg-reborn-card__image img {
                width: 100%;
                height: 100%;
                object-fit: cover;
                transition: transform 0.5s ease;
                border-radius: 16px;
            }

            .pg-reborn-card:hover .pg-reborn-card__image img {
                transform: scale(1.08);
            }

            .pg-reborn-card__footer {
                display: flex;
                justify-content: center;
                align-items: center;
                margin-top: auto; 
            }

            .pg-reborn-card__btn {
                display: block;
                width: 100%;
                text-align: center;
                background-color: #EAFE67;
                color: #000000;
                font-family: 'Familjen Grotesk', sans-serif;
                font-weight: 700;
                font-size: 11px;
                text-transform: uppercase;
                padding: 10px 4px;
                border-radius: 12px;
                line-height: 1.2;
                transition: background-color 0.2s ease, transform 0.2s ease;
                box-shadow: 0 2px 5px rgba(0,0,0,0.05);
            }

            .pg-reborn-card:hover .pg-reborn-card__btn {
                background-color: #D4E856;
                transform: scale(1.02);
            }

            /* Desktop: Ajuste de scroll padding */
            @media (min-width: 1100px) {
                .pg-dev-carousel__track {
                    padding: 20px 0;
                }
            }

            /* Mobile Adjustments */
            @media (max-width: 768px) {
                .pg-reborn-card {
                    width: 160px;
                    padding: 8px;
                    border-radius: 16px;
                    margin-right: 12px;
                    gap: 8px;
                }
                .pg-reborn-card__image {
                    border-radius: 12px;
                }
                .pg-reborn-card__image img {
                    border-radius: 12px;
                }
                .pg-reborn-card__btn {
                    font-size: 10px;
                    padding: 8px 4px;
                    border-radius: 6px;
                }
            }
        </style>
        </header>

        {# Container isolado para os cards (Carousel) #}
        <div class="pg-dev-carousel" id="dev-carousel">
            <div class="pg-dev-carousel__track" id="dev-carousel-track">
                {# JS vai injetar os cards aqui (.pg-home-dev-card) #}
                
                {# Placeholders apenas para evitar CLS inicial #}
                {% for i in 1..5 %}
                <div class="pg-dev-card--loading" style="width: 160px; height: 200px; background: #f5f5f5; border-radius: 12px; margin-right: 16px; flex-shrink: 0;"></div>
                {% endfor %}
            </div>

            {# Navegacao #}
            <button class="pg-dev-carousel__nav pg-dev-carousel__nav--prev" aria-label="Anterior" style="display:none;">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                    <path d="M15 6L9 12L15 18" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </button>
            <button class="pg-dev-carousel__nav pg-dev-carousel__nav--next" aria-label="Próximo">
                <svg width="20" height="20" viewBox="0 0 24 24" fill="none">
                    <path d="M9 6L15 12L9 18" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                </svg>
            </button>
        </div>

    </div>
</section>

{# JS: Fetch de produtos via API + Carousel scroll #}
<script>
(function() {
    document.addEventListener('DOMContentLoaded', function() {
        var carousel = document.getElementById('dev-carousel');
        if (!carousel) return;
        var track = document.getElementById('dev-carousel-track');
        var btnNext = carousel.querySelector('.pg-dev-carousel__nav--next');
        var btnPrev = carousel.querySelector('.pg-dev-carousel__nav--prev');
        if (!track) return;

        var scrollAmount = 0; 
        var DEV_MAX = 5; // Limite solicitado pelo usuário

        // Placeholder imagem para fallback
        var placeholderImg = '{{ "images/placeholder-coming-soon.png" | static_url }}';

        function getScrollAmount() {
            var firstCard = track.querySelector('.pg-home-dev-card');
            if (firstCard) {
                return firstCard.offsetWidth + 16; 
            }
            return 280;
        }

        function updateNav() {
            if (btnPrev) btnPrev.style.display = track.scrollLeft > 10 ? 'flex' : 'none';
            if (btnNext) btnNext.style.display = (track.scrollLeft + track.clientWidth) < (track.scrollWidth - 10) ? 'flex' : 'none';
        }

        if (btnNext) btnNext.addEventListener('click', function() {
            track.scrollBy({ left: getScrollAmount(), behavior: 'smooth' });
        });
        if (btnPrev) btnPrev.addEventListener('click', function() {
            track.scrollBy({ left: -getScrollAmount(), behavior: 'smooth' });
        });

        track.addEventListener('scroll', updateNav);
        window.addEventListener('resize', updateNav);

        // Busca produtos via API da Nuvemshop (scraping da página de categoria)
        fetchDevProducts();

        function fetchDevProducts() {
            // URL da categoria "Produtos Cachorros" conforme configurado na loja
            var categoryUrl = '/produtos-cachorros';

            fetch(categoryUrl, {
                headers: { 'Accept': 'text/html' }
            })
            .then(function(response) {
                if (!response.ok) throw new Error('Erro ao buscar produtos');
                return response.text();
            })
            .then(function(html) {
                var parser = new DOMParser();
                var doc = parser.parseFromString(html, 'text/html');

                // Busca os items de produto na página da categoria
                var items = doc.querySelectorAll('.js-item-product');
                var devProducts = [];

                items.forEach(function(item) {
                    if (devProducts.length >= DEV_MAX) return;

                    // CORREÇÃO: Busca pela classe NOVA que existe no item.tpl (.pg-card__btn--dev)
                    var devBtn = item.querySelector('.pg-card__btn--dev');
                    
                    if (devBtn) {
                        var nameEl = item.querySelector('.js-item-name');
                        var linkEl = item.querySelector('a'); // Pega o primeiro link
                        var imgEl = item.querySelector('.js-item-image');
                        
                        // Extrai a melhor URL de imagem disponível
                        var imgUrl = '';
                        if (imgEl) {
                            imgUrl = imgEl.getAttribute('src') || '';
                            if (!imgUrl || imgUrl.indexOf('data:') === 0) {
                                imgUrl = imgEl.getAttribute('data-src') || '';
                            }
                            if (!imgUrl) {
                                var srcset = imgEl.getAttribute('data-srcset') || imgEl.getAttribute('srcset') || '';
                                if (srcset) {
                                    imgUrl = srcset.split(',')[0].trim().split(' ')[0];
                                }
                            }
                        }

                        if (nameEl) {
                            devProducts.push({
                                name: nameEl.textContent.trim(),
                                url: linkEl ? linkEl.getAttribute('href') : '#',
                                image: imgUrl
                            });
                        }
                    }
                });

                renderDevProducts(devProducts);
            })
            .catch(function(err) {
                console.warn('Patagang: Erro ao buscar produtos em desenvolvimento:', err);
                renderFallback();
            });
        }

        function renderDevProducts(products) {
            // Remove placeholders de loading
            var loadingCards = track.querySelectorAll('.pg-dev-card--loading');
            loadingCards.forEach(function(card) { card.remove(); });

            if (products.length === 0) {
                renderFallback();
                return;
            }

            products.forEach(function(product) {
                // ESTRUTURA REBORN (Final Fix - Unique Namespace)
                var card = document.createElement('a');
                card.href = escapeHtml(product.url);
                card.className = 'pg-reborn-card'; // Nova classe para evitar conflitos
                card.title = 'Seja o primeiro a conhecer ' + product.name;
                
                var imgSrc = product.image || placeholderImg;

                card.innerHTML = 
                    '<div class="pg-reborn-card__content">' +
                        '<div class="pg-reborn-card__image">' +
                            '<img src="' + escapeHtml(imgSrc) + '" alt="' + escapeHtml(product.name) + '" loading="lazy">' +
                        '</div>' +
                        '<div class="pg-reborn-card__footer">' +
                            '<span class="pg-reborn-card__btn">SEJA O PRIMEIRO A CONHECER</span>' +
                        '</div>' +
                    '</div>';

                track.appendChild(card);
            });

            setTimeout(updateNav, 100);
        }

        function renderFallback() {
            var loadingCards = track.querySelectorAll('.pg-dev-card--loading');
            loadingCards.forEach(function(card) { card.remove(); });
            
            // Se não encontrar nada, esconde a seção para não ficar feio
            var section = document.querySelector('.pg-home-dev-section');
            if(section) section.style.display = 'none';
        }

        function escapeHtml(str) {
            var div = document.createElement('div');
            div.appendChild(document.createTextNode(str));
            return div.innerHTML;
        }
    });
})();
</script>

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

<section class="pg-section pg-section--grid-bg pg-section--coming-soon visible-when-content-ready">
    <div class="pg-container">

        <h3 class="pg-section__title">SEJA O PRIMEIRO A CONHECER</h3>

        {# Carousel horizontal com scroll nativo #}
        <div class="pg-dev-carousel" id="dev-carousel">
            <div class="pg-dev-carousel__track" id="dev-carousel-track">

                {# Server-side rendered cards (se Twig encontrou produtos) #}
                {% for product in dev_products %}
                    <a href="{{ product.url }}" class="pg-dev-card" title="{{ product.name }}">
                        <div class="pg-dev-card__image">
                            {% if product.featured_image %}
                                <img src="{{ product.featured_image | product_image_url('large') }}"
                                     alt="{{ product.name }}"
                                     loading="lazy">
                            {% else %}
                                <img src="{{ 'images/placeholder-product.png' | static_url }}"
                                     alt="{{ product.name }}"
                                     loading="lazy">
                            {% endif %}
                        </div>
                        <div class="pg-dev-card__info">
                            <h3 class="pg-dev-card__name">{{ product.name }}</h3>
                        </div>
                    </a>
                {% endfor %}

                {# Placeholders de loading (exibidos enquanto JS carrega, se Twig não encontrou) #}
                {% if dev_products | length == 0 %}
                    {% for i in 1..5 %}
                        <div class="pg-dev-card pg-dev-card--placeholder pg-dev-card--loading">
                            <div class="pg-dev-card__image">
                                <div class="pg-dev-card__skeleton"></div>
                            </div>
                            <div class="pg-dev-card__info">
                                <h3 class="pg-dev-card__name">Carregando...</h3>
                            </div>
                        </div>
                    {% endfor %}
                {% endif %}

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

        var scrollAmount = 0; {# Calculado dinamicamente baseado no tamanho do card #}
        var DEV_MAX = 8;

        {# Placeholder imagem para fallback #}
        var placeholderImg = '{{ "images/placeholder-coming-soon.png" | static_url }}';

        function getScrollAmount() {
            var firstCard = track.querySelector('.pg-dev-card');
            if (firstCard) {
                return firstCard.offsetWidth + 16; {# largura do card + gap #}
            }
            return 280;
        }

        function updateNav() {
            if (btnPrev) btnPrev.style.display = track.scrollLeft > 10 ? 'flex' : 'none';
            if (btnNext) btnNext.style.display = (track.scrollLeft + track.clientWidth) < (track.scrollWidth - 10) ? 'flex' : 'none';
        }

        if (btnNext) btnNext.addEventListener('click', function() {
            track.scrollBy({ left: getScrollAmount() * 2, behavior: 'smooth' });
        });
        if (btnPrev) btnPrev.addEventListener('click', function() {
            track.scrollBy({ left: -getScrollAmount() * 2, behavior: 'smooth' });
        });

        track.addEventListener('scroll', updateNav);
        window.addEventListener('resize', updateNav);

        {# Verifica se já tem cards reais (server-side) #}
        var existingCards = track.querySelectorAll('.pg-dev-card:not(.pg-dev-card--loading)');
        if (existingCards.length > 0) {
            {# Server-side já encontrou produtos, só inicializa navegação #}
            setTimeout(updateNav, 100);
            return;
        }

        {# Busca produtos via API da Nuvemshop (scraping da página de categoria) #}
        fetchDevProducts();

        function fetchDevProducts() {
            {# A Nuvemshop oferece endpoint JSON para busca de produtos #}
            {# URL da categoria "Produtos Cachorros" conforme configurado na loja #}
            var categoryUrl = '/produtos-cachorros';

            {# Fetch da página da categoria e parsear os produtos #}
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

                {# Busca os items de produto na página da categoria #}
                var items = doc.querySelectorAll('.js-item-product');
                var devProducts = [];

                items.forEach(function(item) {
                    if (devProducts.length >= DEV_MAX) return;

                    {# Verifica se o produto tem o botão "SEJA O PRIMEIRO A CONHECER" #}
                    {# Isso indica que o item.tpl detectou a tag em-desenvolvimento #}
                    var devBtn = item.querySelector('.btn-development');
                    if (devBtn) {
                        var nameEl = item.querySelector('.js-item-name');
                        var linkEl = item.querySelector('.item-link');
                        var imgEl = item.querySelector('.js-item-image');
                        var priceEl = item.querySelector('.js-price-display');

                        {# Extrai a melhor URL de imagem disponível #}
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
                                image: imgUrl,
                                price: priceEl ? priceEl.textContent.trim() : null
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
            {# Remove placeholders de loading #}
            var loadingCards = track.querySelectorAll('.pg-dev-card--loading');
            loadingCards.forEach(function(card) { card.remove(); });

            if (products.length === 0) {
                renderFallback();
                return;
            }

            products.forEach(function(product) {
                var card = document.createElement('a');
                card.href = product.url;
                card.className = 'pg-dev-card';
                card.title = product.name;

                var imgSrc = product.image || placeholderImg;

                card.innerHTML =
                    '<div class="pg-dev-card__image">' +
                        '<img src="' + escapeHtml(imgSrc) + '" alt="' + escapeHtml(product.name) + '" loading="lazy">' +
                    '</div>' +
                    '<div class="pg-dev-card__info">' +
                        '<h3 class="pg-dev-card__name">' + escapeHtml(product.name) + '</h3>' +
                    '</div>';

                track.appendChild(card);
            });

            setTimeout(updateNav, 100);
        }

        function renderFallback() {
            {# Remove placeholders de loading #}
            var loadingCards = track.querySelectorAll('.pg-dev-card--loading');
            loadingCards.forEach(function(card) { card.remove(); });

            for (var i = 0; i < 3; i++) {
                var card = document.createElement('div');
                card.className = 'pg-dev-card pg-dev-card--placeholder';
                card.innerHTML =
                    '<div class="pg-dev-card__image">' +
                        '<img src="' + placeholderImg + '" alt="Produto em desenvolvimento" loading="lazy">' +
                    '</div>' +
                    '<div class="pg-dev-card__info">' +
                        '<h3 class="pg-dev-card__name">Em breve</h3>' +
                    '</div>';
                track.appendChild(card);
            }
            setTimeout(updateNav, 100);
        }

        function escapeHtml(str) {
            var div = document.createElement('div');
            div.appendChild(document.createTextNode(str));
            return div.innerHTML;
        }
    });
})();
</script>

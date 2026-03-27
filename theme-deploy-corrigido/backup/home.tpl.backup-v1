{#
  HOME PAGE - PATAGANG
  Hero + Seção Produto Destaque + Grid
#}

{# BANNER HERO - Background compartilhado com Header via CSS #}
{# CORRIGIDO: Imagem de fundo agora está no CSS (background-image) - Alteração #1 e #3 #}
<section class="hero visible-when-content-ready">
    <div class="hero__container">
        {# Conteúdo do hero: SVG texto + CTA #}
        <div class="hero__content">
            {# Coluna esquerda: Texto HTML para SEO + Imagem Visual #}
            <div class="hero__text-column">
                <div class="hero__text-content">
                    {# Texto visível apenas para SEO e leitores de tela #}
                    <h2 class="hero__title sr-only">MUITO ALÉM DO BÁSICO</h2>
                    <p class="hero__subtitle sr-only">Uma marca pet que vai além. Acessórios com design exclusivo para cães e tutores que buscam estilo e qualidade.</p>

                    {# Imagem visual do banner #}
                    <img
                        src="{{ 'images/banner-dk-1.svg' | static_url }}"
                        alt=""
                        aria-hidden="true"
                        class="hero__svg-image"
                    >
                </div>
            </div>

            {# Coluna direita: CTA #}
            <div class="hero__cta-column">
                <a href="{{ store.products_url }}" class="hero__cta">
                    VER OS PRIMEIROS PRODUTOS
                </a>
            </div>
        </div>

        {# Scroll indicator (seta para baixo) - Posicionado no final do bloco, fora do grid #}
        {# Ícone moderno maior com cor amarela #}
        <div class="hero__scroll-indicator">
            <svg width="40" height="40" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                {# Seta chevron dupla moderna #}
                <path d="M7 13L12 18L17 13" stroke="#EAFE67" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M7 7L12 12L17 7" stroke="#EAFE67" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </div>
    </div>
</section>

{# WRAPPER COM DEGRADÊ AMARELO - Conforme protótipo Adobe XD #}
<div class="yellow-gradient-wrapper visible-when-content-ready">

{# SEÇÃO PRODUTOS DESTAQUE - Layout 2 colunas: 2 produtos destacados #}
<section class="featured-product visible-when-content-ready">
    <div class="featured-product__container">
        {# Grid 2 colunas: produto destacado 1 e produto destacado 2 #}
        <div class="featured-product__grid">

            {# COLUNA ESQUERDA: Primeiro produto destacado #}
            {% set featured_product_1 = null %}
            {% if sections.primary.products and sections.primary.products | length > 0 %}
                {% set featured_product_1 = sections.primary.products | first %}
            {% endif %}

            <div class="featured-product__card-wrapper">
                <div class="featured-product__card">
                    {% if featured_product_1 %}
                        <div class="featured-product__image">
                            <a href="{{ featured_product_1.url }}">
                                <img src="{{ featured_product_1.featured_image | product_image_url('large') }}" alt="{{ featured_product_1.name }}">
                            </a>
                        </div>

                        <a href="{{ featured_product_1.url }}" class="featured-product__btn">
                            Loja
                        </a>
                    {% else %}
                        {# Fallback para imagem estática caso não tenha produtos destacados #}
                        <div class="featured-product__image">
                            <a href="{{ store.products_url }}">
                                <img src="{{ 'images/produto-1.png' | static_url }}" alt="Produto destaque">
                            </a>
                        </div>

                        <a href="{{ store.products_url }}" class="featured-product__btn">
                            Loja
                        </a>
                    {% endif %}
                </div>
            </div>

            {# COLUNA DIREITA: Segundo produto destacado #}
            {% set featured_product_2 = null %}
            {% if sections.primary.products and sections.primary.products | length > 1 %}
                {% set featured_product_2 = sections.primary.products[1] %}
            {% endif %}

            {% if featured_product_2 %}
            <div class="featured-product__card-wrapper">
                <div class="featured-product__card">
                    <div class="featured-product__image">
                        <a href="{{ featured_product_2.url }}">
                            <img src="{{ featured_product_2.featured_image | product_image_url('large') }}" alt="{{ featured_product_2.name }}">
                        </a>
                    </div>

                    <a href="{{ featured_product_2.url }}" class="featured-product__btn">
                        Loja
                    </a>
                </div>
            </div>
            {% endif %}

        </div>
    </div>
</section>

{# SEÇÃO EM DESENVOLVIMENTO - 2 Cards com Blur Effect #}
<section class="coming-soon visible-when-content-ready">
    <div class="coming-soon__container">
        <div class="coming-soon__grid">

            {# Card 1 - Coleira em Desenvolvimento #}
            <a href="/products/coleira" class="coming-soon__card">
                <img src="{{ 'images/produto-1.png' | static_url }}" alt="Coleira em desenvolvimento" class="coming-soon__image">

                <div class="coming-soon__overlay">
                    <div class="coming-soon__frame">
                        <span class="coming-soon__badge">EM DESENVOLVIMENTO</span>
                    </div>
                    <span class="coming-soon__button">Seja o primeiro a conhecer</span>
                </div>
            </a>

            {# Card 2 - Peitoral em Desenvolvimento #}
            <a href="/products/peitoral" class="coming-soon__card">
                <img src="{{ 'images/produto-2.png' | static_url }}" alt="Peitoral em desenvolvimento" class="coming-soon__image">

                <div class="coming-soon__overlay">
                    <div class="coming-soon__frame">
                        <span class="coming-soon__badge">EM DESENVOLVIMENTO</span>
                    </div>
                    <span class="coming-soon__button">Seja o primeiro a conhecer</span>
                </div>
            </a>

        </div>
    </div>
</section>



</div> {# Fim yellow-gradient-wrapper #}

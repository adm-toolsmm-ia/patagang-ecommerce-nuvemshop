{#
  PÁGINA PRODUTOS EM DESENVOLVIMENTO - PATAGANG
  Design baseado no protótipo fornecido
#}

{# HERO SECTION #}
<section class="dev-products-hero">
    <div class="dev-products-hero__container">
        <h1 class="dev-products-hero__title">PRODUTOS EM DESENVOLVIMENTO</h1>
        <p class="dev-products-hero__subtitle">Novidades exclusivas chegando em breve</p>
    </div>
</section>

{# PRODUTOS GRID #}
<section class="dev-products-section">
    <div class="dev-products-section__container">
        <div class="dev-products-grid">
            
            {# Card 1 - Produto em Desenvolvimento #}
            <div class="dev-product-card">
                {# Background com imagem blur #}
                <div class="dev-product-card__background">
                    <img src="{{ 'images/produto-1.png' | static_url }}" alt="Produto em desenvolvimento" class="dev-product-card__bg-image">
                </div>
                
                {# Overlay escuro sutil #}
                <div class="dev-product-card__overlay"></div>
                
                {# Modal central com informações #}
                <div class="dev-product-card__modal">
                    <div class="dev-product-card__frame">
                        <span class="dev-product-card__badge">PRODUTO EM DESENVOLVIMENTO</span>
                    </div>
                    <a href="#newsletter" class="dev-product-card__cta js-scroll-to-newsletter">
                        SEJA O PRIMEIRO A CONHECER
                    </a>
                </div>
            </div>

            {# Card 2 - Produto em Desenvolvimento #}
            <div class="dev-product-card">
                {# Background com imagem blur #}
                <div class="dev-product-card__background">
                    <img src="{{ 'images/produto-2.png' | static_url }}" alt="Produto em desenvolvimento" class="dev-product-card__bg-image">
                </div>
                
                {# Overlay escuro sutil #}
                <div class="dev-product-card__overlay"></div>
                
                {# Modal central com informações #}
                <div class="dev-product-card__modal">
                    <div class="dev-product-card__frame">
                        <span class="dev-product-card__badge">PRODUTO EM DESENVOLVIMENTO</span>
                    </div>
                    <a href="#newsletter" class="dev-product-card__cta js-scroll-to-newsletter">
                        SEJA O PRIMEIRO A CONHECER
                    </a>
                </div>
            </div>

        </div>
    </div>
</section>

{# NEWSLETTER SECTION - Para scroll do CTA #}
<section class="dev-products-newsletter" id="newsletter">
    <div class="dev-products-newsletter__container">
        <div class="dev-products-newsletter__content">
            <h2 class="dev-products-newsletter__title">Faça parte da gang</h2>
            <p class="dev-products-newsletter__text">Cadastre-se para receber em primeira mão quando esses produtos estiverem disponíveis</p>
            
            {# Success/Error Messages #}
            {% if contact and contact.type == 'newsletter' %}
                {% if contact.success %}
                    <div class="alert alert-success mb-3">
                        {{ "¡Gracias por suscribirte! A partir de ahora vas a recibir nuestras novedades en tu email" | translate }}
                    </div>
                {% else %}
                    <div class="alert alert-danger mb-3">
                        {{ "Necesitamos tu email para enviarte nuestras novedades." | translate }}
                    </div>
                {% endif %}
            {% endif %}

            {# Newsletter Form - Nuvemshop Standard #}
            <form class="dev-products-newsletter__form" method="post" action="/winnie-pooh" onsubmit="this.setAttribute('action', '');" data-store="newsletter-form">
                <input
                    type="email"
                    name="email"
                    placeholder="email@email.com"
                    class="dev-products-newsletter__input"
                    required
                    aria-label="Email"
                >
                
                {# Hidden honeypot field for spam protection #}
                <div class="winnie-pooh" style="display: none;">
                    <label for="winnie-pooh-newsletter-dev">{{ "No completar este campo" | translate }}</label>
                    <input id="winnie-pooh-newsletter-dev" type="text" name="winnie-pooh"/>
                </div>
                
                {# Hidden required fields for Nuvemshop newsletter #}
                <input type="hidden" name="name" value="{{ 'Sin nombre' | translate }}" />
                <input type="hidden" name="message" value="{{ 'Pedido de inscripción a newsletter' | translate }}" />
                <input type="hidden" name="type" value="newsletter" />
                
                <button type="submit" name="contact" class="dev-products-newsletter__btn">
                    SUBSCRIBE
                </button>
            </form>
        </div>
    </div>
</section>

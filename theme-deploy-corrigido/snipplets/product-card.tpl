{#
  PRODUCT CARD - Componente Reutilizável
  Usado em grids de produtos
#}

<div class="product-card">
    <a href="{{ product.url }}" class="product-card__link">
        {# Imagem #}
        <div class="product-card__image">
            <img
                src="{{ product.featured_image | product_image_url('medium') }}"
                alt="{{ product.name }}"
                loading="lazy"
            >

            {# Badge de desconto (se houver) #}
            {% if product.compare_at_price > product.price %}
            <span class="product-card__badge">
                -{{ ((product.compare_at_price - product.price) / product.compare_at_price * 100) | round }}%
            </span>
            {% endif %}
        </div>

        {# Informações #}
        <div class="product-card__info">
            <h3 class="product-card__name">{{ product.name }}</h3>

            <div class="product-card__prices">
                {% if product.compare_at_price > product.price %}
                <span class="product-card__price-old">
                    {{ product.compare_at_price | money }}
                </span>
                {% endif %}

                <span class="product-card__price">
                    {{ product.price | money }}
                </span>
            </div>
        </div>
    </a>
</div>

<style>
/* Product Card Styles */
.product-card {
    background-color: var(--color-white);
    border-radius: var(--radius-md);
    overflow: hidden;
    transition: transform 0.2s, box-shadow 0.2s;
    box-shadow: var(--shadow-sm);
}

.product-card:hover {
    transform: translateY(-4px);
    box-shadow: var(--shadow-md);
}

.product-card__link {
    display: block;
    color: inherit;
}

.product-card__image {
    position: relative;
    aspect-ratio: 1 / 1;
    overflow: hidden;
    background-color: var(--color-gray-light);
}

.product-card__image img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    transition: transform 0.3s;
}

.product-card:hover .product-card__image img {
    transform: scale(1.05);
}

.product-card__badge {
    position: absolute;
    top: var(--spacing-md);
    right: var(--spacing-md);
    background-color: var(--color-primary);
    color: var(--color-black);
    padding: var(--spacing-xs) var(--spacing-sm);
    border-radius: var(--radius-sm);
    font-size: var(--font-size-xs);
    font-weight: var(--font-weight-bold);
}

.product-card__info {
    padding: var(--spacing-md);
}

.product-card__name {
    font-size: var(--font-size-base);
    font-weight: var(--font-weight-bold);
    margin-bottom: var(--spacing-sm);
    line-height: 1.3;
    overflow: hidden;
    text-overflow: ellipsis;
    display: -webkit-box;
    -webkit-line-clamp: 2;
    -webkit-box-orient: vertical;
}

.product-card__prices {
    display: flex;
    align-items: center;
    gap: var(--spacing-sm);
}

.product-card__price-old {
    font-size: var(--font-size-sm);
    color: var(--color-gray-dark);
    text-decoration: line-through;
}

.product-card__price {
    font-size: var(--font-size-lg);
    font-weight: var(--font-weight-bold);
    color: var(--color-black);
}
</style>

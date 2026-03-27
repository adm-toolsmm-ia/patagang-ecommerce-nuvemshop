{# /*============================================================================
  #Blog Post Item - Card Moderno Patagang
==============================================================================*/ #}

{% set post_url = post.url %}
{% set post_title = post.title %}
{% set post_excerpt = post.excerpt %}
{% set post_image = post.image %}
{% set post_date = post.date %}

<article class="pg-blog-card">
    <a href="{{ post_url }}" class="pg-blog-card__image">
        {% if post_image %}
            <img 
                src="{{ post_image | static_url | img_url('large') }}" 
                alt="{{ post_title }}"
                class="lazyload fade-in"
                loading="lazy"
            />
        {% else %}
            <img 
                src="{{ 'images/placeholder.png' | static_url }}" 
                alt="{{ post_title }}"
            />
        {% endif %}
    </a>

    <div class="pg-blog-card__content">
        {# Meta informações - data #}
        <div class="pg-blog-card__meta">
            <span class="pg-blog-card__category">Blog</span>
            <span class="pg-blog-card__date">{{ post_date | date('d/m/Y') }}</span>
        </div>

        {# Título #}
        <h2 class="pg-blog-card__title">
            <a href="{{ post_url }}">{{ post_title }}</a>
        </h2>

        {# Resumo #}
        {% if post_excerpt %}
            <p class="pg-blog-card__summary">{{ post_excerpt }}</p>
        {% endif %}

        {# Footer com botão #}
        <div class="pg-blog-card__footer">
            <a href="{{ post_url }}" class="pg-blog-card__link">
                <span>Leia Mais</span>
            </a>
        </div>
    </div>
</article>

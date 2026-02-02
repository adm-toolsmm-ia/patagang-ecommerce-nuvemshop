<article class="pg-blog-card">
    {% if post.has_image %}
        <div class="pg-blog-card__image">
            <a href="{{ post.url }}" title="{{ post.title }}">
                <img src="{{ post.image | static_url }}" data-src="{{ post.image | static_url }}" alt="{{ post.title }}" class="lazyload fade-in">
            </a>
        </div>
    {% endif %}
    
    <div class="pg-blog-card__content">
        <h3 class="pg-blog-card__title">
            <a href="{{ post.url }}" title="{{ post.title }}">{{ post.title }}</a>
        </h3>
        
        <div class="pg-blog-card__summary">
            {% if post.summary %}
                {{ post.summary }}
            {% else %}
                {{ post.content | strip_html | truncate(120) }}
            {% endif %}
        </div>
        
        <div class="pg-blog-card__footer">
            <a href="{{ post.url }}" class="pg-blog-card__link" title="{{ 'Ler mais' | translate }}">
                {{ 'Ler mais' | translate }}
            </a>
        </div>
    </div>
</article>

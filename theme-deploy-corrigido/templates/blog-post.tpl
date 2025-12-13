{# ============================================
   POST DE BLOG - PATAGANG
   Segue o padrão das páginas institucionais
   ============================================ #}

<section class="pg-page">
    <div class="pg-page__container">
        {# Título do post #}
        <h1 class="pg-page__title">{{ post.title }}</h1>
        
        <div class="pg-page__content">
            {# Componente de conteúdo do blog #}
            {% if post.has_image %}
                <div class="pg-blog-post__image fade-in mb-4">
                    <img src="{{ post.image }}" class="img-fluid w-100" alt="{{ post.title }}">
                </div>
            {% endif %}

            <div class="pg-blog-post__date font-small mb-3 text-secondary">
                {{ post.published_at | date("d/m/Y") }}
            </div>

            <div class="pg-blog-post__content user-content">
                {{ post.content }}
            </div>
            
            {# Botões de compartilhamento #}
            <div class="pg-blog-share">
                {% include 'snipplets/social-share.tpl' %}
            </div>
            
            {# Link para voltar ao blog #}
            <div class="pg-blog-back">
                <a href="{{ store.blog_url }}" class="pg-text-link">
                    ← {{ "Volver al blog" | translate }}
                </a>
            </div>
        </div>
    </div>
</section>

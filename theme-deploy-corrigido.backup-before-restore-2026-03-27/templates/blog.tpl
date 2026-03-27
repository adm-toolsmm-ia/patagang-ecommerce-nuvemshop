{# ============================================
   PÁGINA DE BLOG - PATAGANG
   Parte do "O Movimento" - Com navegação por abas
   ============================================ #}

<section class="pg-movimento">
    {# Navegação por Abas - Blog faz parte do O Movimento #}
    <nav class="pg-movimento__nav">
        <div class="pg-movimento__nav-container">
            <a href="/comunidade" class="pg-movimento__tab">
                O Movimento
            </a>
            <a href="/sobre" class="pg-movimento__tab">
                Sobre a Patagang
            </a>

            </a>
            <a href="{{ store.blog_url }}" class="pg-movimento__tab is-active">
                Blog
            </a>
        </div>
    </nav>

    {# Conteúdo do Blog #}
    <div class="pg-movimento__body pg-movimento__body--wide">
        <h1 class="pg-movimento__title">{{ "Blog" | translate }}</h1>

        <div class="pg-movimento__content">
            {# Grid de posts #}
            <div class="row justify-content-center">
                {% for post in blog.posts %}
                    <div class="col-md-6 col-12">
                        {% include 'snipplets/blog/blog-post-item.tpl' %}
                    </div>
                {% endfor %}
            </div>

            {# Paginação #}
            {% if blog.pages > 1 %}
                <div class="row mt-4">
                    <div class="col-12">
                        {% include 'snipplets/grid/pagination.tpl' with {'pages': blog.pages} %}
                    </div>
                </div>
            {% endif %}
        </div>
    </div>
</section>

{# Verifica se é a página de produtos em desenvolvimento #}
{% if page.handle == 'produtos-em-desenvolvimento' %}
    {# Renderiza template customizado para produtos em desenvolvimento #}
    {% include 'produtos-em-desenvolvimento.tpl' %}
{% else %}
    {# ============================================
       Detecta páginas do "O Movimento"
       ============================================ #}
    {% set movimento_pages = ['comunidade', 'sobre'] %}
    {% set is_movimento = page.handle in movimento_pages %}

    {% if is_movimento %}
        {# ============================================
           O MOVIMENTO - Página com Navegação por Abas
           Estilo inspirado na Freitag
           ============================================ #}
        <section class="pg-movimento">
            {# Navegação por Abas #}
            <nav class="pg-movimento__nav">
                <div class="pg-movimento__nav-container">
                    <a href="/comunidade" class="pg-movimento__tab {% if page.handle == 'comunidade' %}is-active{% endif %}">
                        A GANG
                    </a>
                    <a href="/sobre" class="pg-movimento__tab {% if page.handle == 'sobre' %}is-active{% endif %}">
                        Sobre a Patagang
                    </a>

                    </a>
                    <a href="{{ store.blog_url }}" class="pg-movimento__tab">
                        Blog
                    </a>
                </div>
            </nav>

            {# Conteúdo da Página #}
            <div class="pg-movimento__body">
                <h1 class="pg-movimento__title">{{ page.name }}</h1>
                <div class="pg-movimento__content user-content">
                    {{ page.content }}
                </div>
            </div>
        </section>
    {% else %}
        {# ============================================
           PÁGINAS INSTITUCIONAIS NORMAIS - PATAGANG
           Texto direto no fundo, sem card
           (Política, FAQ, etc.)
           ============================================ #}
        <section class="pg-page">
            <div class="pg-page__container">
                {# Título #}
                <h1 class="pg-page__title">{{ page.name }}</h1>

                {# Conteúdo direto no fundo #}
                <div class="pg-page__content user-content">
                    {{ page.content }}
                </div>
            </div>
        </section>
    {% endif %}
{% endif %}

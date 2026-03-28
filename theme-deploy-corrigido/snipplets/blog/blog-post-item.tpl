<article class="post-item">
    <div class="post-item__content">
        {# Constrói a URL correta: /blog/posts/handle #}
        {% set post_url = '/blog/posts/' ~ post.handle %}

        {# Tenta imagem #}
        {% set post_image = post.image %}
        {% if not post_image and post.featured_image %}
            {% set post_image = post.featured_image %}
        {% endif %}

        <a href="{{ post_url }}" title="{{ post.title }}" class="post-item__image-link {% if not post_image %}js-fetch-post-image{% endif %}" data-post-url="{{ post_url }}">
            {% if post_image %}
                <img src="{{ post_image }}" alt="{{ post.title }}" class="post-item__image">
            {% else %}
                {# Placeholder inicial enquanto carrega - Altura fixa para alinhamento #}
                <div class="post-item__image post-item__image--placeholder" style="background: #f0f0f0; display: flex; align-items: center; justify-content: center; color: #ccc; height: 240px;">
                    <span style="font-size: 24px;">...</span>
                </div>
            {% endif %}
        </a>

        <h3 class="post-item__title">
            <a href="{{ post_url }}" title="{{ post.title }}">{{ post.title }}</a>
        </h3>

        <div class="post-item__date">
            {{ post.published_at | date("d/m/Y") }}
        </div>

        <div class="post-item__summary">
             {{ post.summary }}
        </div>

        <a href="{{ post_url }}" class="post-item__read-more">
            {{ 'Ler mais' | translate }}
        </a>

        {% if not post_image %}
        <script>
            (function() {
                var postUrl = "{{ post_url }}";
                // Encontra o container deste post específico
                var script = document.currentScript;
                var container = script.closest('.post-item');

                if (postUrl && container) {
                    // Fetch da página do post para pegar a imagem
                    fetch(postUrl)
                        .then(function(response) {
                            if (!response.ok) throw new Error('Network response was not ok');
                            return response.text();
                        })
                        .then(function(html) {
                            var parser = new DOMParser();
                            var doc = parser.parseFromString(html, 'text/html');

                            // Tenta várias estratégias para encontrar a imagem
                            var imageUrl = null;

                            // 1. Meta tag Open Graph
                            var ogImage = doc.querySelector('meta[property="og:image"]');
                            if (ogImage) imageUrl = ogImage.content;

                            // 2. Primeira imagem do conteúdo
                            if (!imageUrl) {
                                var contentImage = doc.querySelector('.user-content img, .post-body img, .product-description img');
                                if (contentImage) imageUrl = contentImage.src;
                            }

                            // 3. Fallback
                            if (!imageUrl) {
                                var anyImage = doc.querySelector('main img');
                                if (anyImage) imageUrl = anyImage.src;
                            }

                            if (imageUrl) {
                                var link = container.querySelector('.post-item__image-link');
                                var placeholder = container.querySelector('.post-item__image--placeholder');

                                if (link && placeholder) {
                                    var img = document.createElement('img');
                                    img.src = imageUrl;
                                    img.alt = "{{ post.title }}";
                                    img.className = "post-item__image";
                                    // Garantir que a imagem tenha altura fixa e object-fit
                                    img.style.width = "100%";
                                    img.style.height = "240px";
                                    img.style.objectFit = "cover";
                                    img.style.borderRadius = "16px";
                                    img.style.opacity = "0";
                                    img.style.transition = "opacity 0.5s ease";

                                    img.onload = function() {
                                        img.style.opacity = "1";
                                    };

                                    link.replaceChild(img, placeholder);
                                    link.classList.remove('js-fetch-post-image');
                                }
                            }
                        })
                        .catch(function(err) {
                            // Erro silencioso - imagem não carregada
                        });
                }
            })();
        </script>
        {% endif %}
    </div>
</article>

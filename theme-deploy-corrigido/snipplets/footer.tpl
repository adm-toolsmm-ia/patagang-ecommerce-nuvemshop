{#
  FOOTER - Patagang
  Seções: Faça Parte (Newsletter), Marca, Suporte, Redes Sociais
#}

<footer class="footer">
    <div class="footer__container">

        {# Logo Row #}
        <div class="footer__logo-row">
            <img src="{{ 'images/logo-patagang-v2.svg' | static_url }}" alt="Patagang" class="footer__logo-img">
        </div>

        {# Content Row (4 Columns) #}
        <div class="footer__content-row">

            {# Coluna 1: Faça Parte (Newsletter via Pingback) #}
            <div class="footer__col footer__col--newsletter">
                {# Widget Pingback para Newsletter - já tem título próprio #}
                {# Script carregado apenas uma vez aqui para evitar duplicação (usado também no modal) #}
                <div class="footer-pingback-form">
                    <script>
                        {# Carregar widget.js apenas se ainda não foi carregado #}
                        (function() {
                            if (!document.querySelector('script[src*="widget-v2.pingback.com"]')) {
                                var script = document.createElement('script');
                                script.src = 'https://widget-v2.pingback.com/assets/js/widget.js';
                                script.async = true;
                                document.head.appendChild(script);
                            }
                        })();
                    </script>
                    <pb-embeddable-form form_id='707a66d0-defa-4cd4-8dd3-99894dcec614'></pb-embeddable-form>
                </div>
            </div>

            {# Coluna 2: Marca #}
            <div class="footer__col">
                <span class="footer__title">MARCA</span>
                <ul class="footer__list">
                    <li><a href="{{ store.blog_url }}">Blog</a></li>
                    <li><a href="/comunidade">A Gang</a></li>
                    <li><a href="/sobre">Sobre a Patagang</a></li>


                </ul>
            </div>

            {# Coluna 3: Suporte #}
            <div class="footer__col">
                <span class="footer__title">SUPORTE</span>
                <ul class="footer__list">
                    <li><a href="/politica-de-privacidade">Política de Privacidade</a></li>
                    <li><a href="/perguntas-frequentes">Perguntas frequentes</a></li>
                    <li><a href="/trocas-e-devolucoes">Trocas e Devoluções</a></li>
                    <li><a href="/politica-envio">Política de Envio</a></li>
                    <li><a href="https://api.whatsapp.com/send/?phone=5547996263577&text&type=phone_number&app_absent=0" target="_blank" rel="noopener">Fale conosco</a></li>
                </ul>
            </div>

            {# Coluna 4: Redes Sociais + Formas de pagamento (abaixo) #}
            <div class="footer__col">
                <span class="footer__title">REDES SOCIAIS</span>
                <div class="footer__social-icons">
                    {% include "snipplets/social/social-footer.tpl" %}
                    {% if settings.spotify_url %}
                        <a class="social-icon" href="{{ settings.spotify_url }}" target="_blank" rel="noopener noreferrer" aria-label="Spotify {{ store.name }}">
                            {% include "snipplets/svg/spotify.tpl" with {svg_custom_class: "icon-inline icon-2x"} %}
                        </a>
                    {% endif %}
                </div>
                {% if settings.payments_show and settings.payments %}
                <span class="footer__title">Formas de pagamento</span>
                <div class="footer__payments-logos">
                    {% include "snipplets/logos-icons.tpl" with {'payments': true} %}
                </div>
                {% endif %}
            </div>

        </div>

        {# Row secundária: apenas Segurança (Google) #}
        {% if settings.google_security %}
        <div class="footer__secondary">
            <div class="footer__col footer__col--security">
                <span class="footer__title">Segurança</span>
                <div class="footer__security">
                    {% if settings.security_link %}
                        <a href="{{ settings.security_link }}" target="_blank" rel="noopener noreferrer" aria-label="Google Site Seguro {{ store.name }}">
                    {% endif %}
                    {% if settings.security_color == 'white' %}
                        <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'images/google-safe-white.png' | static_url }}" class="custom-seal-img lazyload" alt="Google Site Seguro {{ store.name }}">
                    {% elseif settings.security_color == 'mono' %}
                        <img src="{{ 'images/google-safe-mono.svg' | static_url }}" class="custom-seal-img" alt="Google Site Seguro {{ store.name }}" width="48" height="48">
                    {% else %}
                        <img src="{{ 'images/empty-placeholder.png' | static_url }}" data-src="{{ 'images/google-safe-color.png' | static_url }}" class="custom-seal-img lazyload" alt="Google Site Seguro {{ store.name }}">
                    {% endif %}
                    {% if settings.security_link %}
                        </a>
                    {% endif %}
                </div>
            </div>
        </div>
        {% endif %}

        {# Copyright #}
        <div class="footer__bottom">
            <p class="footer__copyright">
                © {{ "now" | date("Y") }} Patagang. Todos os direitos reservados.
            </p>
        </div>
    </div>
</footer>

<style>
/* Footer Styles */
.footer {
    /* Background: transição suave de cinza para branco */
    /* Inicia no mesmo cinza do background global (#E2E2E2) */
    background: linear-gradient(180deg,
        #E2E2E2 0%,      /* MESMO cinza do background global */
        #ECECEC 20%,     /* Transição suave */
        #F5F5F5 50%,     /* Off-white */
        #FFFFFF 100%     /* Branco puro no final */
    );
    padding: 80px 20px 40px;
    color: #000000;
    font-family: 'Familjen Grotesk', sans-serif;
    margin-top: 0;
    border-top: none !important;
    position: relative;
    z-index: 1;
}

.footer__container {
    max-width: 1400px;
    margin: 0 auto;
}

/* Logo */
.footer__logo-row {
    margin-bottom: 40px;
    text-align: center; /* Center the logo container */
}

.footer__logo-img {
    width: 100%;
    max-width: 600px; /* Mobile: mais compacto */
    display: inline-block;
    height: auto;
}

/* Grid Layout */
.footer__content-row {
    display: grid;
    grid-template-columns: 1fr;
    gap: 40px;
    margin-bottom: 60px;
}

/* Titles */
.footer__title {
    display: block;
    font-size: 16px;
    font-weight: 500;
    text-transform: uppercase;
    margin-bottom: 24px;
    padding-bottom: 8px;
    letter-spacing: 0.5px;
    border-bottom: 1px solid rgba(0, 0, 0, 0.1);
}

/* Lists */
.footer__list {
    list-style: none;
    padding: 0;
    margin: 0;
}

.footer__list li {
    margin-bottom: 8px;
}

.footer__list a {
    color: #000000;
    text-decoration: none;
    font-size: 12px;
    font-weight: 400;
    transition: opacity 0.2s;
}

.footer__list a:hover {
    opacity: 0.7;
}

/* Pingback Form - Estilos para o widget de newsletter */
.footer__col--newsletter {
    display: flex;
    flex-direction: column;
}

.footer-pingback-form {
    max-width: 100%;
}

/* Customização do widget Pingback para combinar com o footer */
.footer-pingback-form pb-embeddable-form {
    --pb-primary-color: #000000;
    --pb-background-color: transparent;
    --pb-text-color: #000000;
    --pb-border-radius: 4px;
    font-family: 'Familjen Grotesk', sans-serif !important;
}

/* Alinha o título do Pingback com os outros títulos */
.footer-pingback-form h2,
.footer-pingback-form h3,
.footer-pingback-form [class*="title"],
.footer-pingback-form [class*="heading"] {
    font-size: 16px !important;
    font-weight: 500 !important;
    text-transform: uppercase !important;
    letter-spacing: 0.5px !important;
    margin-bottom: 20px !important;
    font-family: 'Familjen Grotesk', sans-serif !important;
}

/* Ajusta textos do widget */
.footer-pingback-form p,
.footer-pingback-form label,
.footer-pingback-form span {
    font-size: 12px !important;
    font-family: 'Familjen Grotesk', sans-serif !important;
}

/* Ajusta input e botão */
.footer-pingback-form input[type="email"],
.footer-pingback-form input[type="text"] {
    font-size: 12px !important;
    font-family: 'Familjen Grotesk', sans-serif !important;
    background: transparent !important;
    border: 1px solid #000 !important;
    border-radius: 4px !important;
}

.footer-pingback-form button,
.footer-pingback-form input[type="submit"] {
    background: #000 !important;
    color: #fff !important;
    font-size: 12px !important;
    font-weight: 700 !important;
    font-family: 'Familjen Grotesk', sans-serif !important;
    border-radius: 4px !important;
    text-transform: uppercase !important;
}

/* Redes sociais - ícones em linha */
/* Ícones mais próximos do título "REDES SOCIAIS" */
.footer__title + .footer__social-icons {
    margin-top: -12px;
}

.footer__social-icons {
    display: flex;
    flex-wrap: wrap;
    gap: 16px;
    align-items: center;
}

.footer__social-icons .social-icon {
    color: #000000;
    transition: opacity 0.2s;
}

.footer__social-icons .social-icon:hover {
    opacity: 0.7;
}

.footer__social-icons .social-icon svg {
    width: 24px;
    height: 24px;
}

/* Row secundária: Segurança (Google) */
.footer__secondary {
    display: grid;
    grid-template-columns: 1fr;
    gap: 32px;
    margin-bottom: 48px;
    padding-top: 24px;
    border-top: 1px solid rgba(0, 0, 0, 0.08);
}

/* Selo Google - monocromático */
.footer .footer__security .custom-seal-img {
    max-height: 48px;
    width: auto;
    height: auto;
    filter: grayscale(1);
    opacity: 0.9;
}

/* Bandeiras de pagamento - monocromáticas */
/* Mais espaço entre redes sociais e o bloco Formas de pagamento */
.footer__social-icons + .footer__title {
    margin-top: 1.25rem;
}

.footer .footer__payments-logos {
    display: flex;
    flex-wrap: wrap;
    gap: 16px;
    align-items: center;
    margin-top: 0.5rem;
}

.footer .footer__payments-logos .icon-logo {
    filter: grayscale(1);
    opacity: 0.85;
    max-height: 32px;
    width: auto;
}

/* Copyright */
.footer__bottom {
    /* Removed border-top */
    padding-top: 20px;
    text-align: center;
}

.footer__copyright {
    font-size: 10px;
    opacity: 0.6;
}

/* Responsive */
@media (min-width: 768px) {
    .footer__content-row {
        grid-template-columns: repeat(2, 1fr);
    }
    .footer__secondary {
        grid-template-columns: 1fr 1fr;
    }
}

@media (min-width: 1024px) {
    .footer__content-row {
        grid-template-columns: 1fr 1fr 1fr 1fr; /* 4 colunas equilibradas */
    }

    .footer {
        padding: 80px 40px 40px;
    }

    .footer__logo-img {
        max-width: 1200px; /* Desktop: logo grande conforme protótipo */
    }
}
</style>

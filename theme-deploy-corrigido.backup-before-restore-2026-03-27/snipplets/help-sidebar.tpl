{# FLOATING HELP SIDEBAR #}

{# 1. Floating Button #}
<div class="pg-help-btn js-toggle-help-sidebar">
    <span class="pg-help-btn__text">Posso ajudar?</span>
    <svg class="pg-help-btn__icon" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
        <circle cx="12" cy="12" r="10" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M9.09 9C9.3251 8.33167 9.78915 7.76811 10.4 7.40913C11.0108 7.05016 11.7289 6.91894 12.4272 7.03871C13.1255 7.15849 13.7588 7.52152 14.2151 8.06353C14.6713 8.60553 14.9211 9.29152 14.92 10C14.92 12 11.92 13 11.92 13" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M12 17H12.01" stroke="currentColor" stroke-width="1.5" stroke-linecap="round" stroke-linejoin="round"/>
    </svg>
</div>

{# 2. Overlay #}
<div class="pg-help-overlay js-close-help-sidebar"></div>

{# 3. Sidebar #}
<div class="pg-help-sidebar" id="pg-help-sidebar">
    
    {# Header #}
    <div class="pg-help-sidebar__header">
        <h3 class="pg-help-sidebar__title">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <circle cx="12" cy="12" r="10" stroke="#000" stroke-width="2"/>
                <path d="M9.09 9C9.3251 8.33167 9.78915 7.76811 10.4 7.40913C11.0108 7.05016 11.7289 6.91894 12.4272 7.03871C13.1255 7.15849 13.7588 7.52152 14.2151 8.06353C14.6713 8.60553 14.9211 9.29152 14.92 10C14.92 12 11.92 13 11.92 13" stroke="#000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                <path d="M12 17H12.01" stroke="#000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
            Posso ajudar?
        </h3>
        <button class="pg-help-sidebar__close js-close-help-sidebar" aria-label="Fechar">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                <line x1="18" y1="6" x2="6" y2="18"></line>
                <line x1="6" y1="6" x2="18" y2="18"></line>
            </svg>
        </button>
    </div>

    {# Body #}
    <div class="pg-help-sidebar__body">
        


        {# Grid de Opções #}
        <div class="pg-help-grid">
            
            {# 1. Meus Pedidos #}
            <a href="{{ store.url }}/account/orders" class="pg-help-item">
                {% include "snipplets/svg/shopping-bag.tpl" with {svg_custom_class: "pg-help-item__icon"} %}
                <span class="pg-help-item__text">Meus<br>pedidos</span>
            </a>

            {# 2. Trocas e Devoluções #}
            <a href="https://patagang.troque.app.br/" target="_blank" class="pg-help-item">
                {% include "snipplets/svg/sync-alt.tpl" with {svg_custom_class: "pg-help-item__icon"} %}
                <span class="pg-help-item__text">Trocas e<br>devoluções</span>
            </a>

            {# 3. WhatsApp #}
            <a href="https://api.whatsapp.com/send?phone=5547996263577" target="_blank" class="pg-help-item">
                {% include "snipplets/svg/whatsapp.tpl" with {svg_custom_class: "pg-help-item__icon"} %}
                <span class="pg-help-item__text">Fale no<br>WhatsApp</span>
            </a>

            {# 4. A GANG (Comunidade) #}
            <a href="/comunidade" class="pg-help-item">
                <img src="{{ 'images/logos/logo-mark.svg' | static_url }}" alt="A Gang" class="pg-help-item__icon" loading="lazy">
                <span class="pg-help-item__text">A Gang</span>
            </a>
        </div>



        {# Link Rastrear Pedido (Input visual) #}
        <div class="pg-help-tracking" style="margin-top: 16px;">
            <div class="pg-help-tracking__title">
                {% include "snipplets/svg/truck.tpl" with {svg_custom_class: "icon-inline"} %}
                RASTREAR PEDIDO
            </div>
            <div class="pg-help-tracking__input-group">
                <input type="text" id="pg-track-code" class="pg-help-tracking__input" placeholder="Digite o código..." style="background: #fff;">
                <button type="button" class="pg-help-tracking__btn" id="pg-track-btn">VER</button>
            </div>
            <script>
            document.getElementById('pg-track-btn').addEventListener('click', function() {
                var code = document.getElementById('pg-track-code').value;
                if(code) {
                    window.open('https://rastreamento.correios.com.br/app/index.php?objeto=' + code, '_blank');
                }
            });
            </script>
        </div>

    </div>
</div>

<script>
document.addEventListener("DOMContentLoaded", function() {
    var helpBtn = document.querySelector(".js-toggle-help-sidebar");
    var closeBtns = document.querySelectorAll(".js-close-help-sidebar");
    var sidebar = document.getElementById("pg-help-sidebar");
    var overlay = document.querySelector(".pg-help-overlay");

    if(helpBtn && sidebar && overlay) {
        helpBtn.addEventListener("click", function() {
            sidebar.classList.add("is-active");
            overlay.classList.add("is-active");
            // Hide WhatsApp float button if it exists to avoid overlap
            var whatsappFloat = document.querySelector(".btn-whatsapp");
            if(whatsappFloat) whatsappFloat.style.display = "none";
        });

        closeBtns.forEach(function(btn) {
            btn.addEventListener("click", function() {
                sidebar.classList.remove("is-active");
                overlay.classList.remove("is-active");
                 // Show WhatsApp float button again
                var whatsappFloat = document.querySelector(".btn-whatsapp");
                if(whatsappFloat) whatsappFloat.style.display = "";
            });
        });
    }
});
</script>

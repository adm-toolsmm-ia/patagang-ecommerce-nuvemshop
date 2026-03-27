{# PATAGANG - Modal Newsletter para Captação de Leads #}
{# Usado principalmente na página de produtos em desenvolvimento #}
{# Integrado com Pingback para captação de leads #}

<div class="pg-modal-newsletter js-modal-newsletter" style="display: none;">
    {# Overlay escuro #}
    <div class="pg-modal-newsletter__overlay js-close-newsletter-modal"></div>

    {# Card do Modal #}
    <div class="pg-modal-newsletter__card">
        {# Botão fechar #}
        <button type="button" class="pg-modal-newsletter__close js-close-newsletter-modal" aria-label="Fechar">
            <svg width="24" height="24" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                <path d="M18 6L6 18M6 6L18 18" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
            </svg>
        </button>

        {# Conteúdo com Widget Pingback #}
        <div class="pg-modal-newsletter__content">
            {# Widget Pingback - Formulário de captação de leads #}
            {# Script já carregado no footer, não precisa carregar novamente #}
            <div class="pg-modal-newsletter__pingback-container" id="modal-pingback-container">
                <pb-embeddable-form form_id='d0c3d15d-b1c9-4b4c-9039-57866c5c0aef'></pb-embeddable-form>
            </div>
        </div>
    </div>
</div>

{# Script para focar no campo de email quando o modal abrir #}
<script>
(function() {
    // Observer para quando o modal for aberto
    var modalObserver = new MutationObserver(function(mutations) {
        mutations.forEach(function(mutation) {
            if (mutation.type === 'attributes' && mutation.attributeName === 'style') {
                var modal = document.querySelector('.js-modal-newsletter');
                if (modal && modal.style.display !== 'none') {
                    // Modal foi aberto, tenta focar no input de email
                    setTimeout(function() { focusModalEmailInput(); }, 500);
                    setTimeout(function() { focusModalEmailInput(); }, 1000);
                    setTimeout(function() { focusModalEmailInput(); }, 1500);
                }
            }
        });
    });

    // Função para focar no input de email do modal
    function focusModalEmailInput() {
        var container = document.getElementById('modal-pingback-container');
        if (!container) return;

        var inputs = container.querySelectorAll('input');
        for (var i = 0; i < inputs.length; i++) {
            var input = inputs[i];
            var type = (input.type || '').toLowerCase();
            var name = (input.name || '').toLowerCase();
            var placeholder = (input.placeholder || '').toLowerCase();

            if (type === 'email' || name.indexOf('email') !== -1 ||
                placeholder.indexOf('mail') !== -1 || placeholder.indexOf('e-mail') !== -1) {
                input.focus();
                return;
            }
        }
    }

    // Inicia observação do modal
    var modal = document.querySelector('.js-modal-newsletter');
    if (modal) {
        modalObserver.observe(modal, { attributes: true });
    }
})();
</script>


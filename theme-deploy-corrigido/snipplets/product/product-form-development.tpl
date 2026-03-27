{# PATAGANG - Card Produto em Desenvolvimento #}
{# Este card substitui o card de compra para produtos com tag "em-desenvolvimento" #}

<div class="pg-dev-card">
    {# Marcadores de canto (Brackets em L) #}
    <span class="pg-dev-card__corner pg-dev-card__corner--top-left"></span>
    <span class="pg-dev-card__corner pg-dev-card__corner--top-right"></span>
    <span class="pg-dev-card__corner pg-dev-card__corner--bottom-left"></span>
    <span class="pg-dev-card__corner pg-dev-card__corner--bottom-right"></span>
    
    {# Conteúdo central #}
    <div class="pg-dev-card__content">
        <h3 class="pg-dev-card__title">PRODUTO EM DESENVOLVIMENTO</h3>
        
        <button type="button" class="pg-dev-card__button js-open-newsletter-modal">
            QUERO ENTRAR NA LISTA
        </button>
    </div>
</div>

{# Nome do produto abaixo do card #}
<div class="pg-dev-card__product-info">
    <h1 class="pg-dev-card__product-name">{{ product.name }}</h1>
</div>

{# Accordion com descrição se existir #}
{% if product.description is not empty %}
<div class="pg-product-accordions pg-dev-card__accordions">
    <div class="pg-accordion-item active">
        <button type="button" class="pg-accordion-header">
            <span>{{ "DESCRIÇÃO" | translate }}</span>
            <span class="pg-accordion-icon">×</span>
        </button>
        <div class="pg-accordion-content">
            <div class="user-content">
                {{ product.description }}
            </div>
        </div>
    </div>
</div>
{% endif %}

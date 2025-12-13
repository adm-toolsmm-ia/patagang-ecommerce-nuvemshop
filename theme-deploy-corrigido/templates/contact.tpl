{# ============================================
   PÁGINA DE CONTATO - PATAGANG
   Refatorada para usar o padrão de Card de Login (Request 4)
   ============================================ #}

{% set has_contact_info = store.whatsapp or store.phone or store.email or store.address or store.blog %}
{% set is_order_cancellation_without_id = params.order_cancellation_without_id == 'true' %}

<section class="pg-login-page">
    <div class="pg-login-page__container">
        
        {# Card Centralizado (Estilo Login) #}
        <div class="pg-login-card">
            
            {# Título #}
            <h1 class="pg-login-card__title">{{ "Contato" | translate }}</h1>
            
            {# Intro de contato #}
            {% if store.contact_intro %}
                <p class="pg-login-card__subtitle">{{ store.contact_intro }}</p>
            {% endif %}

            {# Informações de contato (Ícones) #}
            {% if has_contact_info %}
                <div class="pg-text-contact" style="justify-content: center; margin-bottom: 30px; display: flex; gap: 20px; flex-wrap: wrap;">
                    {% if store.whatsapp %}
                        <div class="pg-text-contact__item">
                            {% include "snipplets/svg/whatsapp.tpl" with {svg_custom_class: "pg-text-contact__icon svg-icon-primary"} %}
                            <a href="{{ store.whatsapp }}">{{ store.whatsapp |trim('https://wa.me/') }}</a>
                        </div>
                    {% elseif store.phone %}
                        <div class="pg-text-contact__item">
                            {% include "snipplets/svg/phone.tpl" with {svg_custom_class: "pg-text-contact__icon svg-icon-primary"} %}
                            <a href="tel:{{ store.phone }}">{{ store.phone }}</a>
                        </div>
                    {% endif %}
                    {% if store.email %}
                        <div class="pg-text-contact__item">
                            {% include "snipplets/svg/envelope.tpl" with {svg_custom_class: "pg-text-contact__icon svg-icon-primary"} %}
                            <a href="mailto:{{ store.email }}">{{ store.email }}</a>
                        </div>
                    {% endif %}
                </div>
            {% endif %}

            {# Mensagens de cancelamento #}
            {% if is_order_cancellation %}
                <div class="pg-alert pg-alert--info mb-4" data-component="order-cancellation-disclaimer">
                    <p>{{ "Si te arrepentiste, podés pedir la cancelación enviando este formulario. Tenés como máximo hasta 10 días corridos desde que recibiste el producto." | translate }}</p>
                    <a class="pg-text-link" href="{{ status_page_url_regret }}">{{'Ver detalle de la compra >' | translate}}</a>
                </div>
                {% if has_contact_info %}
                    <p class="mt-4 mb-3 text-center">{{ 'Si tenés problemas con otra compra, contactanos:' | translate }}</p>
                {% endif %}
            {% endif %}

            {% if is_order_cancellation_without_id %}
                <div class="pg-alert pg-alert--info mb-4" data-component="order-cancellation-disclaimer">
                    <p>{{ "Si te arrepentiste de una compra, podés pedir la cancelación enviando este formulario <strong>con tu número de orden.</strong> Tenés como máximo hasta 10 días corridos desde que recibiste el producto." | translate }}</p>
                </div>
            {% endif %}

            {# Produto consultado #}
            {% if product %}  
                <div class="pg-text-product-info mb-4 text-center">
                    <p>{{ "Usted está consultando por el siguiente producto:" | translate }}</p>
                    <p><strong>{{ product.name | a_tag(product.url) }}</strong></p>
                    <img src="{{ product.featured_image | product_image_url('thumb') }}" title="{{ product.name }}" alt="{{ product.name }}" style="max-width: 100px; border-radius: 8px;" />
                </div>
            {% endif %}

            {# Mensagens de sucesso/erro #}
            {% if contact %}
                {% if contact.success %}
                    {% if is_order_cancellation %}
                        <div class="pg-alert pg-alert--success" data-component="order-cancellation-success-message">
                            {{ "¡Tu pedido de cancelación fue enviado!" | translate }} 
                            <br>
                            {{ "Vamos a ponernos en contacto con vos apenas veamos tu mensaje." | translate }}
                            <br> 
                            <strong>{{ "Tu código de trámite es" | translate }} #{{ last_order_id }}</strong>
                        </div>
                    {% else %}
                        <div class="pg-alert pg-alert--success" data-component="contact-success-message">
                            {{ "¡Gracias por contactarnos! Vamos a responderte apenas veamos tu mensaje." | translate }}
                        </div>
                    {% endif %}
                {% else %}
                    <div class="pg-alert pg-alert--error">
                        {{ "Necesitamos tu nombre y un email para poder responderte." | translate }}
                    </div>
                {% endif %}
            {% endif %}

            {# Formulário de contato #}
            <div class="pg-login-card__form">
                {% embed "snipplets/forms/form.tpl" with{form_id: 'contact-form', form_custom_class: 'js-winnie-pooh-form pg-form', form_action: '/winnie-pooh', submit_name: 'contact', submit_text: 'Enviar' | translate, data_store: 'contact-form' } %}
                    {% block form_body %}

                        {# Hidden inputs used to send attributes #}
                        <div class="winnie-pooh hidden">
                            <label for="winnie-pooh">{{ "No completar este campo" | translate }}:</label>
                            <input type="text" id="winnie-pooh" name="winnie-pooh">
                        </div>
                        <input type="hidden" value="{{ product.id }}" name="product"/>
                        {% if is_order_cancellation or is_order_cancellation_without_id %}
                            <input type="hidden" name="type" value="order_cancellation" />
                        {% else %}
                            <input type="hidden" name="type" value="contact" />
                        {% endif %}

                        {# Name input #}
                        <div class="pg-form-group">
                            <label for="name" class="pg-form-label">{{ 'Nombre' | translate }}</label>
                            <input type="text" id="name" name="name" class="pg-form-input" value="{{ contact.name }}" required>
                        </div>

                        {# Email input #}
                        <div class="pg-form-group">
                            <label for="email" class="pg-form-label">{{ 'Email' | translate }}</label>
                            <input type="email" id="email" name="email" class="pg-form-input" value="{{ contact.email }}" required>
                        </div>

                        {% if not is_order_cancellation %}
                            {# Phone input #}
                            <div class="pg-form-group">
                                <label for="phone" class="pg-form-label">{{ 'Teléfono' | translate }}</label>
                                <input type="tel" id="phone" name="phone" class="pg-form-input" value="{{ contact.phone }}">
                            </div>

                            {# Message textarea #}
                            <div class="pg-form-group">
                                <label for="message" class="pg-form-label">{{ 'Mensaje' | translate }}</label>
                                <textarea id="message" name="message" class="pg-form-input" rows="5" required>{{ contact.message }}</textarea>
                            </div>
                        {% endif %}

                    {% endblock %}
                {% endembed %}
            </div>
        </div>
    </div>
</section>

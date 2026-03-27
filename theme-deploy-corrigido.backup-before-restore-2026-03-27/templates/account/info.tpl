{# PATAGANG - Meus Dados (Info) #}
<section class="pg-account-page">
    <div class="pg-account-page__container">
        <div class="pg-account-card">
            {# Titulo #}
            <h1 class="pg-account-card__title">{{ "Meus Dados" | translate }}</h1>

            <div class="row justify-content-md-center">
                <div class="col-md-8">
                    {% embed "snipplets/forms/form.tpl" with{form_id: 'info-form', submit_text: 'Salvar alteracoes' | translate } %}
                        {% block form_body %}

                            {# Name input #}

                            {% embed "snipplets/forms/form-input.tpl" with{type_text: true, input_for: 'name', input_value: result.name | default(customer.name), input_name: 'name', input_id: 'name', input_label_text: 'Nome' | translate } %}
                                {% block input_form_alert %}
                                    {% if result.errors.name %}
                                        <div class="alert alert-danger">{{ 'Precisamos do seu nome para atualizar suas informacoes.' | translate }}</div>
                                    {% endif %}
                                {% endblock input_form_alert %}
                            {% endembed %}

                            {# Email input #}

                            {% embed "snipplets/forms/form-input.tpl" with{type_email: true, input_for: 'email', input_value: result.email | default(customer.email), input_name: 'email', input_id: 'email', input_label_text: 'Email' | translate } %}
                                {% block input_form_alert %}
                                    {% if result.errors.email == 'exists' %}
                                        <div class="alert alert-danger">{{ 'Encontramos outra conta que ja usa este email. Tente usar outro.' | translate }}</div>
                                    {% elseif result.errors.email %}
                                        <div class="alert alert-danger">{{ 'Precisamos do seu email para atualizar suas informacoes.' | translate }}</div>
                                    {% endif %}
                                {% endblock input_form_alert %}
                            {% endembed %}

                            {# Phone input #}

                            {% embed "snipplets/forms/form-input.tpl" with{type_tel: true, input_for: 'phone', input_value: result.phone | default(customer.phone), input_name: 'phone', input_id: 'phone', input_label_text: 'Telefone' | translate } %}
                            {% endembed %}

                        {% endblock %}
                    {% endembed %}
                </div>
            </div>
        </div>
    </div>
</section>

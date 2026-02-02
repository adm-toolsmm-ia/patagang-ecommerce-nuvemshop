{# PATAGANG - Editar Endereco #}
<section class="pg-account-page">
    <div class="pg-account-page__container">
        <div class="pg-account-card">
            {# Titulo #}
            <h1 class="pg-account-card__title">{{ "Editar Endereco" | translate }}</h1>

            <div class="row justify-content-md-center">
                <div class="col-md-8">
                    {% embed "snipplets/forms/form.tpl" with{form_id: 'address-form', submit_text: 'Salvar alteracoes' | translate } %}
                        {% block form_body %}

                            {# Name input #}

                            {% embed "snipplets/forms/form-input.tpl" with{type_text: true, input_for: 'name', input_value: result.name | default(address.name), input_name: 'name', input_id: 'name', input_label_text: 'Nome (apelido)' | translate, input_placeholder: 'ex.: Trabalho' | translate } %}
                                {% block input_form_alert %}
                                    {% if result.errors.name %}
                                        <div class="alert alert-danger">{{ 'Precisamos do seu nome para atualizar suas informacoes.' | translate }}</div>
                                    {% endif %}
                                {% endblock input_form_alert %}
                            {% endembed %}

                            {# Address input #}

                            {% if current_language.country == 'BR' %}
                                {% set address_placeholder = 'ex.: Rua das Flores' | translate %}
                            {% else %}
                                {% set address_placeholder = 'ex.: Av. Pueyrredon 1234, CABA' | translate %}
                            {% endif %}

                            {% embed "snipplets/forms/form-input.tpl" with{type_text: true, input_for: 'address', input_value: result.address | default(address.address), input_name: 'address', input_id: 'address', input_label_text: 'Endereco' | translate, input_placeholder: address_placeholder } %}
                                {% block input_form_alert %}
                                    {% if result.errors.address %}
                                        <div class="alert alert-danger">{{ 'Precisamos do seu endereco para atualizar suas informacoes.' | translate }}</div>
                                    {% endif %}
                                {% endblock input_form_alert %}
                            {% endembed %}

                            {% if current_language.country == 'BR' %}

                                {# Address number #}

                                {% embed "snipplets/forms/form-input.tpl" with{type_number: true, input_for: 'number', input_value: result.number | default(address.number), input_name: 'number', input_id: 'number', input_label_text: 'Numero' | translate, input_placeholder: 'ex.: 1234' | translate } %}
                                    {% block input_form_alert %}
                                        {% if result.errors.number %}
                                            <div class="alert alert-danger">{{ 'Precisamos do numero para atualizar suas informacoes.' | translate }}</div>
                                        {% endif %}
                                    {% endblock input_form_alert %}
                                {% endembed %}

                                {# Address Floor #}

                                {% embed "snipplets/forms/form-input.tpl" with{type_number: true, input_for: 'floor', input_value: result.floor | default(address.floor), input_name: 'floor', input_id: 'floor', input_label_text: 'Complemento' | translate } %}
                                    {% block input_form_alert %}
                                        {% if result.errors.floor %}
                                            <div class="alert alert-danger">{{ 'Precisamos do complemento para atualizar suas informacoes.' | translate }}</div>
                                        {% endif %}
                                    {% endblock input_form_alert %}
                                {% endembed %}

                                {# Address Locality #}

                                {% embed "snipplets/forms/form-input.tpl" with{type_text: true, input_for: 'locality', input_value: result.locality | default(address.locality), input_name: 'locality', input_id: 'locality', input_label_text: 'Bairro' | translate, input_placeholder: 'ex.: Centro' | translate } %}
                                    {% block input_form_alert %}
                                        {% if result.errors.locality %}
                                            <div class="alert alert-danger">{{ 'Precisamos do bairro para atualizar suas informacoes.' | translate }}</div>
                                        {% endif %}
                                    {% endblock input_form_alert %}
                                {% endembed %}

                            {% endif %}

                            {# Address Zipcode #}

                            {% embed "snipplets/forms/form-input.tpl" with{type_tel: true, input_for: 'zipcode', input_value: result.zipcode | default(address.zipcode), input_name: 'zipcode', input_id: 'zipcode', input_label_text: 'CEP' | translate, input_placeholder: 'ex.: 01001-000' | translate } %}
                                {% block input_form_alert %}
                                    {% if result.errors.zipcode %}
                                        <div class="alert alert-danger">{{ 'Informe seu CEP' | translate }}</div>
                                    {% endif %}
                                {% endblock input_form_alert %}
                            {% endembed %}


                           {# Address City #}

                            {% embed "snipplets/forms/form-input.tpl" with{type_text: true, input_for: 'city', input_value: result.city | default(address.city), input_name: 'city', input_id: 'city', input_label_text: 'Cidade' | translate, input_placeholder: 'ex.: Sao Paulo' | translate } %}
                                {% block input_form_alert %}
                                    {% if result.errors.city %}
                                        <div class="alert alert-danger">{{ 'Precisamos da sua cidade para atualizar suas informacoes.' | translate }}</div>
                                    {% endif %}
                                {% endblock input_form_alert %}
                            {% endembed %}

                           {# Address Province #}

                            {% embed "snipplets/forms/form-input.tpl" with{type_text: true, input_for: 'province', input_value: result.province | default(address.province), input_name: 'province', input_id: 'province', input_label_text: 'Estado' | translate, input_placeholder: 'ex.: SP' | translate } %}
                                {% block input_form_alert %}
                                    {% if result.errors.province %}
                                        <div class="alert alert-danger">{{ 'Precisamos do seu estado para atualizar suas informacoes.' | translate }}</div>
                                    {% endif %}
                                {% endblock input_form_alert %}
                            {% endembed %}


                            {# Address Country #}

                            {% embed "snipplets/forms/form-select.tpl" with{select_for: 'country', select_name: 'country', select_id: 'country', select_label: 'Pais' | translate } %}
                                {% block select_options %}{{ country_options }}{% endblock select_options %}
                                {% block input_form_alert %}
                                    {% if result.errors.country %}
                                        <div class="alert alert-danger">{{ 'Precisamos do seu pais para atualizar suas informacoes.' | translate }}</div>
                                    {% endif %}
                                {% endblock input_form_alert %}
                            {% endembed %}


                            {# Phone input #}

                            {% embed "snipplets/forms/form-input.tpl" with{type_tel: true, input_for: 'phone', input_value: result.phone | default(address.phone), input_name: 'phone', input_id: 'phone', input_label_text: 'Telefone' | translate, input_placeholder: 'ex.: 11971023030' | translate } %}
                                {% block input_form_alert %}
                                    {% if result.errors.phone %}
                                        <div class="alert alert-danger">{{ 'Precisamos do seu telefone para atualizar suas informacoes.' | translate }}</div>
                                    {% endif %}
                                {% endblock input_form_alert %}
                            {% endembed %}

                        {% endblock %}
                    {% endembed %}
                </div>
            </div>
        </div>
    </div>
</section>

{# PATAGANG - Meus Enderecos #}
<section class="pg-account-page">
    <div class="pg-account-page__container">
        <div class="pg-account-card">
            {# Titulo #}
            <h1 class="pg-account-card__title">{{ "Meus Enderecos" | translate }}</h1>

            <div class="row justify-content-md-center pt-3">
                {% for address in customer.addresses %}
                    {% if loop.first %}
                        {# User addresses listed - Main Address #}
                        <div class="col-md-4 text-center">
                            <h4 class="h5 mb-3">{{ 'Principal' | translate }}</h4>
                            <hr class="divider my-3">
                            <div class="row justify-content-md-center">
                    {% elseif loop.index == 2 %}
                        {# User addresses listed - Other Addresses #}
                        <div class="col-md-8 text-center">
                            <h4 class="h5 mb-3">{{ 'Outros enderecos' | translate }}</h4>
                            <hr class="divider my-3">
                            <div class="row justify-content-md-center">
                    {% endif %}
                                <div class="col{% if not loop.first %}-md-4 {% endif %} mb-4">
                                    <p>{{ address | format_address }}</p>
                                    <p>
                                        {{ 'Editar' | translate | a_tag(store.customer_address_url(address), {class: 'btn-link'}) }}
                                    </p>
                                    {% if loop.first %}
                                        <a class="btn btn-primary btn-small my-4" href="{{ store.customer_new_address_url }}"> {{ 'Adicionar novo endereco' | translate }}</a>
                                    {% endif %}
                                </div>
                    {% if loop.first %}
                            </div>
                        </div>
                    {% elseif loop.last %}
                            </div>
                        </div>
                    {% endif %}
                {% endfor %}
            </div>
        </div>
    </div>
</section>

{% for sn in ['instagram', 'facebook', 'youtube', 'tiktok', 'twitter', 'pinterest'] %}
    {% set sn_url = attribute(store, sn) %}
    {% if sn == 'tiktok' %}
        {% set sn_url = 'https://www.tiktok.com/@pata_gang' %}
    {% endif %}
    {% if sn_url %}
        <a class="social-icon" href="{{ sn_url }}" target="_blank" rel="noopener noreferrer" aria-label="{{ sn }} {{ store.name }}">
            {% if sn == "facebook" %}
                {% set social_network = 'facebook-f' %}
            {% else %}
                {% set social_network = sn %}
            {% endif %}
            {% include "snipplets/svg/" ~ social_network ~ ".tpl" with {svg_custom_class: "icon-inline icon-2x"} %}
        </a>
    {% endif %}
{% endfor %}
{% set linkedin_url = settings.linkedin_account is iterable ? (settings.linkedin_account[0] ?? '') : (settings.linkedin_account | default('')) %}
{% if linkedin_url and linkedin_url != 'Array' %}
    <a class="social-icon" href="{{ linkedin_url }}" target="_blank" rel="noopener noreferrer" aria-label="linkedin {{ store.name }}">
        {% include "snipplets/svg/linkedin.tpl" with {svg_custom_class: "icon-inline icon-2x"} %}
    </a>
{% endif %}

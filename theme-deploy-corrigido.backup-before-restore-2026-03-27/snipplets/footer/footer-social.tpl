{% set has_social_network = store.facebook or store.instagram or store.tiktok or store.youtube or store.pinterest or store.twitter %}
{% if has_social_network %}
  <section class="pg-footer__column">
    <span class="footer__title">{{ 'Redes Sociais' | translate }}</span>
    <div class="pg-footer__social-links">
      {% include "snipplets/social/social-links.tpl" %}
    </div>
  </section>
{% endif %}

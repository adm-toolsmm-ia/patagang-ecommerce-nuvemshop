{% set is_newsletter_request = contact and contact.type == 'newsletter' %}
<section class="pg-footer__column pg-footer__column--newsletter">
  <span class="footer__title">{{ 'Faça Parte' | translate }}</span>
  <p>{{ settings.footer_newsletter_text | default('Receba novidades, lançamentos limitados e colaborações da PataGang direto no seu e-mail.') }}</p>

  {% if is_newsletter_request %}
    {% if contact.success %}
      <div class="pg-footer__alert pg-footer__alert--success">{{ 'Assinatura confirmada! Agora você faz parte da nossa matilha.' | translate }}</div>
    {% else %}
      <div class="pg-footer__alert pg-footer__alert--error">{{ 'Precisamos de um e-mail válido para enviar nossas novidades.' | translate }}</div>
    {% endif %}
  {% endif %}

  <form method="post" action="/winnie-pooh" onsubmit="this.setAttribute('action', '');" class="pg-footer__form" data-store="newsletter-form">
    <label class="sr-only" for="pg-footer-email">{{ 'E-mail' | translate }}</label>
    <input id="pg-footer-email" type="email" name="email" placeholder="{{ 'Digite seu e-mail' | translate }}" required>
    <div class="winnie-pooh" style="display:none;">
      <label for="winnie-pooh-footer">{{ 'Não preencha este campo' | translate }}</label>
      <input id="winnie-pooh-footer" type="text" name="winnie-pooh" />
    </div>
    <input type="hidden" name="name" value="{{ 'Sem nome' | translate }}" />
    <input type="hidden" name="message" value="{{ 'Pedido de inscrição na newsletter' | translate }}" />
    <input type="hidden" name="type" value="newsletter" />
    <button type="submit" class="pg-button pg-button--primary">{{ 'Enviar' | translate }}</button>
  </form>
</section>

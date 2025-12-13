{# ============================================
   PATAGANG - SELETOR DE ONG PARA DOAÇÃO
   5% do valor da compra será doado para a ONG selecionada
   ============================================ #}

{% set ongs = [
  { id: 'guerreiro-caramelo', name: 'ONG Guerreiro Caramelo' }
] %}

<div class="pg-ong-selector js-ong-selector" data-component="ong-selector">
  <span class="pg-ong-selector__label">5% doado para:</span>
  <select name="selected_ong" class="pg-ong-selector__select js-ong-input">
    {% for ong in ongs %}
      <option value="{{ ong.id }}" {% if loop.first %}selected{% endif %}>
        {{ ong.name }}
      </option>
    {% endfor %}
  </select>
  <input type="hidden" name="donation_ong" id="selected-ong-value" value="guerreiro-caramelo" />
</div>

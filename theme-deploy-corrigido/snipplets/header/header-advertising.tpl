<section class="section-advertising">
	{% if settings.ad_bar and settings.ad_text %}
		<div class="section-advertising__marquee">
			{% if settings.ad_url %}
				<a class="link-contrast section-advertising__link" href="{{ settings.ad_url | setting_url }}">
			{% endif %}
			<div class="section-advertising__track">
				<div class="section-advertising__copy">
					{% if settings.ad_text contains '|' %}
						{% assign phrases = settings.ad_text | split: '|' %}
						{% for phrase in phrases %}
							<span class="section-advertising__phrase">{{ phrase | strip }}</span>
						{% endfor %}
					{% else %}
						<span class="section-advertising__phrase">{{ settings.ad_text }}</span>
					{% endif %}
				</div>
			</div>
			{% if settings.ad_url %}
				</a>
			{% endif %}
		</div>
	{% endif %}
</section>


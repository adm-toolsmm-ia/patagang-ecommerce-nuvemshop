<section class="section-advertising">
	{% if settings.ad_bar and settings.ad_text %}
		<div class="section-advertising__marquee">
			{% if settings.ad_url %}
				<a class="link-contrast section-advertising__link" href="{{ settings.ad_url | setting_url }}">
			{% endif %}
			<div class="section-advertising__track">
				<span class="section-advertising__copy">{% for i in 1..4 %}{{ settings.ad_text }}{% if not loop.last %}<span class="section-advertising__sep" aria-hidden="true"> • </span>{% endif %}{% endfor %}</span><span class="section-advertising__sep" aria-hidden="true"> • </span><span class="section-advertising__copy">{% for i in 1..4 %}{{ settings.ad_text }}{% if not loop.last %}<span class="section-advertising__sep" aria-hidden="true"> • </span>{% endif %}{% endfor %}</span>
			</div>
			{% if settings.ad_url %}
				</a>
			{% endif %}
		</div>
	{% endif %}
</section>

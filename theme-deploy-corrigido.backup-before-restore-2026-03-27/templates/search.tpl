{% paginate by 12 %}

<section class="pg-search-page">
	<div class="pg-search-page__container">
		
		<div class="pg-search-page__header">
			<h1 class="pg-search-page__title">{{ "Resultados de búsqueda" | translate }}</h1>
			{% if query %}
				<p class="pg-search-page__term">"{{ query }}"</p>
			{% endif %}
		</div>

		<div class="pg-search-page__body">
			{% if products %}
				<div class="js-product-table pg-product-grid">
					{% include 'snipplets/product_grid.tpl' %}
				</div>
				{% include 'snipplets/grid/pagination.tpl' with { infinite_scroll: true } %}
			{% else %}
				<div class="pg-search-page__empty text-center">
					<h3 class="pg-search-page__empty-title">{{ "No hubo resultados para tu búsqueda" | translate }}</h3>
					<p>{{ "Prueba con otros términos o navega por nuestras categorías." | translate }}</p>
				</div>
			{% endif %}
		</div>
	</div>
</section>

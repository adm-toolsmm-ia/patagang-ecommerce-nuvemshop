{# PATAGANG - Product Detail Page (PDP) #}

{# Identity Banner - Minimalist Patagang brand statement (separate from product section) #}
{% include 'snipplets/product/product-identity-banner.tpl' %}

<div id="single-product" class="js-has-new-shipping js-product-detail js-product-container js-shipping-calculator-container pg-pdp-container" data-variants="{{product.variants_object | json_encode }}" data-store="product-detail">

    {# Informative Banner - Desconto e outras informações (acima das imagens/card) #}
    {% include 'snipplets/product/product-informative-banner.tpl' %}

    <div class="row section-single-product g-0">
        <div class="col-12 col-lg-7 pg-pdp-image-col" data-store="product-image-{{ product.id }}">
        	{% include 'snipplets/product/product-image.tpl' %}
        </div>
        <div class="col-12 col-lg-5 pg-pdp-info-col" data-store="product-info-{{ product.id }}">
            {# Marca d'água do logo cachorro - elemento real para garantir visibilidade #}
            <img src="{{ 'images/logos/logo-mark.svg' | static_url }}" 
                 alt="" 
                 class="pg-pdp-watermark" 
                 aria-hidden="true"
                 loading="lazy">
            <div class="pg-pdp-info-card">
            	{% include 'snipplets/product/product-form.tpl' %}
            </div>
        </div>
    </div>
    {# Container para FB Comments e Reviews - SOMENTE SE HABILITADO #}
    {% if settings.show_product_fb_comment_box %}
        <div class="container pg-pdp-extras-container">
            <div class="fb-comments section-fb-comments" data-href="{{ product.social_url }}" data-num-posts="5" data-width="100%"></div>
        </div>
    {% endif %}

	{% if product.images_count > 0 %}
	{# ============================================================================
	   MODAL CUSTOMIZADO - Galeria Fullscreen com Thumbnails
	   aria-hidden: Dynamic toggle via JS (see store.js.tpl)
	============================================================================ #}
	<div id="pg-modal-gallery" class="pg-modal-gallery" aria-hidden="true" role="dialog" aria-modal="true" aria-label="Visualizador de imagens do produto">
		<div class="pg-modal-backdrop js-close-modal-gallery"></div>
		<div class="pg-modal-container">
			{# Sidebar com Thumbnails #}
			<div class="pg-modal-sidebar">
				<div class="pg-modal-thumbs">
					{% for image in product.images %}
					<button 
						class="pg-modal-thumb js-modal-thumb {% if loop.first %}is-active{% endif %}" 
						data-thumb-index="{{ loop.index0 }}"
						data-image-original="{{ image | product_image_url('original') }}"
						data-image-large="{{ image | product_image_url('huge') }}">
						<img 
							src="{{ image | product_image_url('small') }}" 
							alt="{{ image.alt | default(product.name ~ ' foto ' ~ loop.index) }}"
							loading="lazy"
						/>
					</button>
					{% endfor %}
				</div>
			</div>
			{# Imagem Principal #}
			<div class="pg-modal-main">
				<img 
					id="pg-modal-main-image" 
					class="pg-modal-main-img" 
					src="{{ product.images | first | product_image_url('original') }}" 
					alt="{{ product.name }}"
				/>
				{# Navegação com setas #}
				<button class="pg-modal-nav pg-modal-nav--prev js-modal-nav" data-direction="prev" aria-label="Anterior">
					<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
						<polyline points="15 18 9 12 15 6"></polyline>
					</svg>
				</button>
				<button class="pg-modal-nav pg-modal-nav--next js-modal-nav" data-direction="next" aria-label="Próximo">
					<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
						<polyline points="9 18 15 12 9 6"></polyline>
					</svg>
				</button>
			</div>
			{# Botão Fechar #}
			<button class="pg-modal-close js-close-modal-gallery" aria-label="Fechar">
				<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
					<line x1="18" y1="6" x2="6" y2="18"></line>
					<line x1="6" y1="6" x2="18" y2="18"></line>
				</svg>
			</button>
			{# Contador #}
			<div class="pg-modal-counter">
				<span id="pg-modal-current">1</span> / <span id="pg-modal-total">{{ product.images_count }}</span>
			</div>
		</div>
	</div>
	{% endif %}

</div>

{# Related products #}
{% include 'snipplets/product/product-related.tpl' %}

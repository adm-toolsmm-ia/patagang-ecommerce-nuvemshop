{% set has_multiple_slides = product.images_count > 1 or product.video_url %}

{% if product.images_count > 0 %}
	{# ============================================================================
	   PATAGANG - Galeria de Imagens do Produto
	   Desktop: Coluna vertical com todas as imagens
	   Mobile: Carousel horizontal (Swiper)
	============================================================================ #}
	
	{# DESKTOP: Grid Vertical de Imagens #}
	<div class="pg-gallery-container d-none d-lg-block">
		<div class="pg-gallery-grid">
			{% for image in product.images %}
			<div class="pg-gallery-item" data-image-index="{{ loop.index0 }}">
				<a href="#" 
				   class="pg-gallery-link js-open-modal-gallery" 
				   data-image-index="{{ loop.index0 }}"
				   data-image-original="{{ image | product_image_url('original') }}"
				   data-image-large="{{ image | product_image_url('huge') }}">
					<img
						src="{{ image | product_image_url('huge') }}"
						{% if loop.first %}fetchpriority="high"{% endif %}
						alt="{{ image.alt | default(product.name) }}"
						class="pg-gallery-img"
						loading="{% if loop.first %}eager{% else %}lazy{% endif %}"
					/>
					<div class="pg-gallery-zoom-icon">
						<svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2">
							<circle cx="11" cy="11" r="8"></circle>
							<line x1="21" y1="21" x2="16.65" y2="16.65"></line>
							<line x1="11" y1="8" x2="11" y2="14"></line>
							<line x1="8" y1="11" x2="14" y2="11"></line>
						</svg>
					</div>
				</a>
			</div>
			{% endfor %}
		</div>
		{% include 'snipplets/labels.tpl' with {'product_detail': true} %}
	</div>

	{# MOBILE: Carousel Swiper (mantido) #}
	<div class="product-image-container col-12 p-0 d-lg-none">
		<div class="js-swiper-product swiper-container" data-product-images-amount="{{ product.images_count }}">
			{% include 'snipplets/labels.tpl' with {'product_detail': true} %}
		    <div class="swiper-wrapper">
		    	{% for image in product.images %}
		         <div class="swiper-slide js-product-slide slider-slide" data-image="{{image.id}}" data-image-position="{{loop.index0}}">
		         	<a href="#"
		         	   class="js-open-modal-gallery js-product-slide-link d-block position-relative pg-aspect-ratio-container"
		         	   data-image-index="{{ loop.index0 }}"
		         	   data-aspect-ratio="{{ image.dimensions['width'] / image.dimensions['height'] }}"
		         	   style="width: 100%; display: block;">

						{% set apply_lazy_load = not loop.first %}

						{% if apply_lazy_load %}
							{% set product_image_src = 'data:image/gif;base64,R0lGODlhAQABAAAAACH5BAEKAAEALAAAAAABAAEAAAICTAEAOw==' %}
						{% else %}
							{% set product_image_src = image | product_image_url('large') %}
						{% endif %}

						<img
							src="{{ image | product_image_url('large') }}"
							srcset='{{  image | product_image_url('large') }} 480w, {{  image | product_image_url('huge') }} 640w, {{  image | product_image_url('original') }} 1024w'
							class="js-product-slide-img product-slider-image img-absolute img-absolute-centered"
							{% if not apply_lazy_load %}fetchpriority="high"{% endif %}
							{% if apply_lazy_load %}loading="lazy"{% endif %}
							{% if image.dimensions.width and image.dimensions.height %}width="{{ image.dimensions.width }}" height="{{ image.dimensions.height }}"{% endif %}
							{% if image.alt %}alt="{{image.alt}}"{% endif %} />
	        	</a>
 				</div>
				{% endfor %}
				{% include 'snipplets/product/product-video.tpl' %}
			</div>
		{% if has_multiple_slides %}
			{# Mobile navigation buttons #}
			<div class="js-swiper-product-button-prev swiper-button-prev pg-nav-btn pg-nav-btn--prev">
				<img src="{{ 'images/logos/logo-mark.svg' | static_url }}" alt="Anterior" class="pg-nav-btn__logo">
			</div>
			<div class="js-swiper-product-button-next swiper-button-next pg-nav-btn pg-nav-btn--next">
				<img src="{{ 'images/logos/logo-mark.svg' | static_url }}" alt="Próximo" class="pg-nav-btn__logo">
			</div>
		{% endif %}
			<div class="js-swiper-product-pagination swiper-pagination"></div>
		</div>
	</div>


{% endif %}

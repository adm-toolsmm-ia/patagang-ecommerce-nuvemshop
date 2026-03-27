{# PATAGANG - Reset Password Page #}
<section class="pg-login-page">
	<div class="pg-login-page__container">
		{# Card de Reset #}
		<div class="pg-login-card">
			{# Título #}
			<h1 class="pg-login-card__title">{{ 'Alterar Senha' | translate }}</h1>
			<p class="pg-login-card__subtitle">{{ 'Vamos enviar um e-mail para você alterar sua senha.' | translate }}</p>
			
			{# Mensagens de feedback #}
			<div class="pg-login-card__messages">
				{% if success %}
					<div class="pg-alert pg-alert--success">
						<p>{{ 'E-mail enviado com sucesso para {1}' | translate(email) }}</p>
					</div>
				{% endif %}

				{% if failure %}
					<div class="pg-alert pg-alert--error">
						<p>{{ 'Não encontramos nenhuma conta com este e-mail. Verifique se digitou corretamente.' | translate }}</p>
					</div>
				{% endif %}
			</div>
			
			{# Formulário #}
			<form id="resetpass-form" action="" method="post" data-store="account-reset">
				<div class="pg-login-card__form">
					
					{# Campo Email #}
					<div class="pg-form-group">
						<label for="email" class="pg-form-label">{{ 'E-mail' | translate }}</label>
						<input type="email" 
							   id="email" 
							   name="email" 
							   class="pg-form-input js-account-input" 
							   value="{{ email }}"
							   placeholder="seu@email.com"
							   required>
					</div>
					
					{# Botão Enviar #}
					<button type="submit" class="pg-login-card__button">
						{{ 'Enviar e-mail' | translate }}
					</button>
				</div>
			</form>
			
			{# Link Voltar #}
			<div class="pg-login-card__footer text-center mt-3">
				<a href="{{ store.customer_login_url }}" class="pg-login-card__link">
					{{ 'Voltar para o Login' | translate }}
				</a>
			</div>
		</div>
	</div>
</section>
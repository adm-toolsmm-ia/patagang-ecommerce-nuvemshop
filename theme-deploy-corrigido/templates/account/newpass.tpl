{# PATAGANG - New Password Page #}
{% set is_account_activation = action == 'account_activation' %}

<section class="pg-login-page">
	<div class="pg-login-page__container">
		{# Card de Nova Senha #}
		<div class="pg-login-card">
			{# Título #}
			<h1 class="pg-login-card__title">
				{{ (is_account_activation ? 'Ativar Conta' : 'Alterar Senha') | translate }}
			</h1>
			
			<div class="pg-login-card__messages">
				{% if link_expired %}
					{# Link Expirado #}
					<div class="pg-alert pg-alert--error">
						<p class="font-weight-bold mb-2">
							{{ (is_account_activation ? 'O link de ativação expirou.' : 'O link de alteração de senha expirou.') | translate }}
						</p>
						
						{% if is_account_activation %}
							<p>{{ 'Entre em contato conosco para receber um novo link.' | translate }}</p>
							{% include "snipplets/contact-links.tpl" with {phone_and_mail_only: true} %}
						{% else %}
							<p>{{ 'Digite seu e-mail para receber um novo link.' | translate }}</p>
							<a href="{{ store.customer_reset_password_url }}" class="pg-login-card__link mt-2 d-inline-block">
								{{ 'Solicitar novo link' | translate }}
							</a>
						{% endif %}
					</div>
				
				{% elseif failure %}
					{# Erro Senhas não conferem #}
					<div class="pg-alert pg-alert--error">
						<p>{{ 'As senhas não conferem. Tente novamente.' | translate }}</p>
					</div>

				{% else %}
					{# Formulário #}
					<p class="pg-login-card__subtitle">
						{{ 'Crie uma nova senha para sua conta.' | translate }}
					</p>

					<form id="newpass-form" action="" method="post" data-store="account-new-password">
						<div class="pg-login-card__form">
							
							{# Senha #}
							<div class="pg-form-group">
								<label for="password" class="pg-form-label">{{ 'Nova Senha' | translate }}</label>
								<input type="password" 
									   id="password" 
									   name="password" 
									   class="pg-form-input js-account-input" 
									   placeholder="••••••••"
									   required>
							</div>

							{# Confirmar Senha #}
							<div class="pg-form-group">
								<label for="password_confirm" class="pg-form-label">{{ 'Confirmar Senha' | translate }}</label>
								<input type="password" 
									   id="password_confirm" 
									   name="password_confirm" 
									   class="pg-form-input js-account-input" 
									   placeholder="••••••••"
									   required>
							</div>
							
							{# Botão Submit #}
							<button type="submit" class="pg-login-card__button">
								{{ (is_account_activation ? 'Ativar Conta' : 'Alterar Senha') | translate }}
							</button>
						</div>
					</form>
				{% endif %}
			</div>
		</div>
	</div>
</section>
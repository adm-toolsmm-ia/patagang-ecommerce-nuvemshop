{# PATAGANG - Login Page #}
<section class="pg-login-page">
	<div class="pg-login-page__container">
		{# Card de Login #}
		<div class="pg-login-card">
			{# Título #}
			<h1 class="pg-login-card__title">{{ 'Login' | translate }}</h1>
			<p class="pg-login-card__subtitle">{{ 'Entre na sua conta PataGang' | translate }}</p>
			
			{# Mensagens de validação #}
			<div class="pg-login-card__messages">
				{% if account_validation == 'success' %}
					<div class="pg-alert pg-alert--success">
						<p>{{ "Sua conta foi criada com sucesso!" | translate }}</p>
					</div>
				{% elseif account_validation == 'expired' %}
					<div class="pg-alert pg-alert--error">
						<p>{{ "Seu link de validação expirou." | translate }}</p>
					</div>
					<div class="text-center mb-3">
						<span class="js-resend-validation-link pg-login-card__link">{{ "Enviar link novamente" | translate }}</span>
					</div>
				{% elseif account_validation == 'pending' %}
					<div class="pg-alert pg-alert--warning">
						<p>{{ "Valide seu email usando o link que enviamos para <strong>{1}</strong> quando criou sua conta." | t(customer_email) }}</p>
					</div>
					<div class="text-center mb-3">
						<p class="font-small">{{ "Não encontrou?" | translate }} <span class="js-resend-validation-link pg-login-card__link">{{ "Enviar link novamente" | translate }}</span></p>
					</div>
				{% endif %}
				<div class="js-resend-validation-success pg-alert pg-alert--success" style="display:none">
					<p>{{ "Link enviado com sucesso!" | translate }}</p>
				</div>
				<div class="js-resend-validation-error pg-alert pg-alert--error" style="display:none">
					<p>{{ "Não foi possível enviar o email, tente novamente em alguns minutos." | translate }}</p>
				</div>
				<div class="js-too-many-attempts pg-alert pg-alert--error" style="display:none">
					<p>
						{{ 'Você excedeu o número de tentativas permitidas. <br> Tente novamente em' | translate }}
						<span class="js-too-many-attempts-countdown"></span>
					</p>
				</div>
			</div>
			
			{# Formulário de Login #}
			<form id="login-form" action="" method="post" data-store="account-login">
				<div class="pg-login-card__form">
					{# Campo Email #}
					<div class="pg-form-group">
						<label for="email" class="pg-form-label">{{ 'E-mail' | translate }}</label>
						<input type="email" 
							   id="email" 
							   name="email" 
							   class="pg-form-input js-account-input" 
							   value="{{ result.email }}"
							   placeholder="seu@email.com"
							   required>
					</div>
					
					{# Campo Senha #}
					<div class="pg-form-group">
						<label for="password" class="pg-form-label">{{ 'Senha' | translate }}</label>
						<input type="password" 
							   id="password" 
							   name="password" 
							   class="pg-form-input js-account-input" 
							   placeholder="••••••••"
							   required>
					</div>
					
					{# Link Esqueci a Senha #}
					<div class="pg-login-card__forgot">
						<a href="{{ store.customer_reset_password_url }}" class="pg-login-card__link">
							{{ 'Esqueceu sua senha?' | translate }}
						</a>
					</div>
					
					{# Erro de Login #}
					{% if result.invalid %}
						<div class="pg-alert pg-alert--error">
							{{ 'E-mail ou senha incorretos. Verifique seus dados e tente novamente.' | translate }}
						</div>
					{% endif %}
					
					{# Botão de Login #}
					<button type="submit" class="pg-login-card__button">
						{{ 'Entrar' | translate }}
					</button>
				</div>
			</form>
			
			{# Link Criar Conta #}
			{% if 'mandatory' not in store.customer_accounts %}
				<div class="pg-login-card__register">
					<p>{{ "Ainda não tem conta?" | translate }}</p>
					<a href="{{ store.customer_register_url }}" class="pg-login-card__register-link">
						{{ "Criar conta" | translate }}
					</a>
				</div>
			{% endif %}
		</div>
	</div>
</section>

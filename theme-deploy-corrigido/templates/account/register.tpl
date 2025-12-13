{# PATAGANG - Register Page #}
<section class="pg-login-page">
	<div class="pg-login-page__container">
		{# Card de Cadastro #}
		<div class="pg-login-card">
			{# Título #}
			<h1 class="pg-login-card__title">{{ 'Criar conta' | translate }}</h1>
			<p class="pg-login-card__subtitle">{{ 'Compre mais rápido e acompanhe seus pedidos em um só lugar!' | translate }}</p>
			
			{# Mensagens de validação #}
            {% if account_validation == 'pending' %}
                <div class="pg-login-card__messages">
                    <div class="pg-alert pg-alert--warning">
                        <h4 class="weight-strong mb-1">{{ "¡Estás a un paso de crear tu cuenta!" | translate }}</h4>
                        <p>{{ "Te enviamos un link a <strong>{1}</strong> para que valides tu email." | t(customer_email) }}</p>
                    </div>
                    <div class="text-center mb-3">
                        <p class="font-small">{{ "¿Todavía no lo recibiste?" | translate }} <span class="js-resend-validation-link pg-login-card__link">{{ "Enviar link de nuevo" | translate }}</span></p>
                    </div>
                    <div class="js-resend-validation-success pg-alert pg-alert--success" style="display:none">
                        <p>{{ "¡El link fue enviado correctamente!" | translate }}</p>
                    </div>
                    <div class="js-resend-validation-error pg-alert pg-alert--error" style="display:none">
                        <p>{{ "No pudimos enviar el email, intentalo de nuevo en unos minutos." | translate }}</p>
                    </div>
                </div>
            {% else %}
			
                {# Formulário de Cadastro #}
                <form id="login-form" action="" method="post" data-store="account-register">
                    <div class="pg-login-card__form">
                        
                        {# Campo Nome #}
                        <div class="pg-form-group">
                            <label for="name" class="pg-form-label">{{ 'Nome' | translate }}</label>
                            <input type="text" 
                                   id="name" 
                                   name="name" 
                                   class="pg-form-input js-account-input" 
                                   value="{{ result.name }}"
                                   placeholder="{{ 'ex.: Maria Perez' | translate }}"
                                   required>
                            {% if result.errors.name %}
                                <div class="pg-alert pg-alert--error mt-2">{{ 'Usamos seu nome para identificar seus pedidos.' | translate }}</div>
                            {% endif %}
                        </div>

                        {# Campo Email #}
                        <div class="pg-form-group">
                            <label for="email" class="pg-form-label">{{ 'E-mail' | translate }}</label>
                            <input type="email" 
                                   id="email" 
                                   name="email" 
                                   class="pg-form-input js-account-input" 
                                   value="{{ result.email }}"
                                   placeholder="{{ 'ex.: seunome@email.com.br' | translate }}"
                                   required>
                            {% if result.errors.email == 'exists' %}
                                <div class="pg-alert pg-alert--error mt-2">{{ 'Encontramos outra conta que já usa este email. Tente usar outro ou faça login.' | translate }}</div>
                            {% elseif result.errors.email %}
                                <div class="pg-alert pg-alert--error mt-2">{{ 'Precisamos de um email válido para criar sua conta.' | translate }}</div>
                            {% endif %}
                        </div>

                        {# Campo Telefone #}
                        <div class="pg-form-group">
                            <label for="phone" class="pg-form-label">{{ 'Telefone (opcional)' | translate }}</label>
                            <input type="tel" 
                                   id="phone" 
                                   name="phone" 
                                   class="pg-form-input js-account-input" 
                                   value="{{ result.phone }}"
                                   placeholder="{{ 'ex.: 11971023030' | translate }}">
                        </div>
                        
                        {# Campo Senha #}
                        <div class="pg-form-group">
                            <label for="password" class="pg-form-label">{{ 'Senha' | translate }}</label>
                            <input type="password" 
                                   id="password" 
                                   name="password" 
                                   class="pg-form-input js-account-input" 
                                   required>
                            {% if result.errors.password == 'required' %}
                                <div class="pg-alert pg-alert--error mt-2">{{ 'Precisamos de uma senha para registrar você.' | translate }}</div>
                            {% endif %}
                        </div>

                        {# Campo Confirmar Senha #}
                        <div class="pg-form-group">
                            <label for="password_confirmation" class="pg-form-label">{{ 'Confirmar Senha' | translate }}</label>
                            <input type="password" 
                                   id="password_confirmation" 
                                   name="password_confirmation" 
                                   class="pg-form-input js-account-input" 
                                   required>
                            {% if result.errors.password == 'confirmation' %}
                                <div class="pg-alert pg-alert--error mt-2">{{ 'As senhas não coincidem.' | translate }}</div>
                            {% endif %}
                        </div>

                        {# Recaptcha #}
                        <div class="g-recaptcha mb-3" data-sitekey="{{recaptchaSiteKey}}" data-callback="recaptchaCallback"></div>
                        
                        {# Botão de Cadastro #}
                        <button type="submit" class="pg-login-card__button js-recaptcha-button" disabled>
                            {{ 'Cadastre-se' | translate }}
                        </button>
                    </div>
                </form>
                
                {# Link Login #}
                <div class="pg-login-card__register">
                    <p>{{ "Já tem uma conta?" | translate }}</p>
                    <a href="{{ store.customer_login_url }}" class="pg-login-card__register-link">
                        {{ "Entrar" | translate }}
                    </a>
                </div>

            {% endif %}
		</div>
	</div>
</section>
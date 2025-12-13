/**
 * PATAGANG - Smooth Scroll para Newsletter
 * 
 * Adiciona comportamento de scroll suave para links que direcionam
 * à seção de newsletter, com auto-foco no campo de email.
 */

(function() {
    'use strict';
    
    /**
     * Função para scroll suave até um elemento
     * @param {HTMLElement} element - Elemento alvo do scroll
     * @param {number} duration - Duração da animação em ms
     */
    function smoothScrollTo(element, duration) {
        const targetPosition = element.getBoundingClientRect().top + window.pageYOffset;
        const startPosition = window.pageYOffset;
        const distance = targetPosition - startPosition;
        let startTime = null;

        function animation(currentTime) {
            if (startTime === null) startTime = currentTime;
            const timeElapsed = currentTime - startTime;
            const run = ease(timeElapsed, startPosition, distance, duration);
            window.scrollTo(0, run);
            if (timeElapsed < duration) requestAnimationFrame(animation);
        }

        // Função de easing para animação suave
        function ease(t, b, c, d) {
            t /= d / 2;
            if (t < 1) return c / 2 * t * t + b;
            t--;
            return -c / 2 * (t * (t - 2) - 1) + b;
        }

        requestAnimationFrame(animation);
    }

    /**
     * Inicializa os event listeners para scroll suave
     */
    function init() {
        // Aguarda o DOM estar pronto
        if (document.readyState === 'loading') {
            document.addEventListener('DOMContentLoaded', attachScrollListeners);
        } else {
            attachScrollListeners();
        }
    }

    /**
     * Foca no campo de email do widget Pingback
     */
    function focusPingbackEmailInput() {
        var attempts = 0;
        var maxAttempts = 20;
        
        function tryFocus() {
            attempts++;
            
            // Tenta encontrar o input de email dentro do widget Pingback
            // O widget pode usar diferentes seletores
            var emailInput = document.querySelector('input[type="email"]') ||
                             document.querySelector('input[name="email"]') ||
                             document.querySelector('input[placeholder*="mail"]') ||
                             document.querySelector('input[placeholder*="e-mail"]');
            
            if (emailInput) {
                emailInput.focus();
                emailInput.scrollIntoView({ behavior: 'smooth', block: 'center' });
                return;
            }
            
            // Se não encontrou e não atingiu limite, tenta novamente
            if (attempts < maxAttempts) {
                setTimeout(tryFocus, 200);
            }
        }
        
        tryFocus();
    }

    /**
     * Anexa listeners aos links de scroll
     */
    function attachScrollListeners() {
        const scrollLinks = document.querySelectorAll('.js-scroll-to-newsletter');
        
        scrollLinks.forEach(function(link) {
            link.addEventListener('click', function(e) {
                e.preventDefault();
                
                const newsletter = document.getElementById('newsletter');
                
                if (newsletter) {
                    // Scroll suave até a seção
                    smoothScrollTo(newsletter, 800);
                    
                    // Foca no input de email do Pingback após o scroll
                    setTimeout(function() {
                        focusPingbackEmailInput();
                    }, 900); // Aguarda scroll completar
                }
            });
        });
    }

    // Inicializa o script
    init();
})();

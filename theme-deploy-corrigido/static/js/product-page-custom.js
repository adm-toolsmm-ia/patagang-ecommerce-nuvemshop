/**
 * PATAGANG - Product Page Custom Interactions
 * Accordion functionality and custom variant selectors
 */

document.addEventListener('DOMContentLoaded', function () {

    // ============================================================================
    // Accordion Functionality - Toggle individual accordions
    // ============================================================================
    const accordionHeaders = document.querySelectorAll('.pg-accordion-header');

    accordionHeaders.forEach(header => {
        header.addEventListener('click', function () {
            const accordionItem = this.closest('.pg-accordion-item');
            const icon = this.querySelector('.pg-accordion-icon');
            const isActive = accordionItem.classList.contains('active');

            // Toggle current accordion (não fecha os outros)
            if (isActive) {
                accordionItem.classList.remove('active');
                if (icon) icon.textContent = '+';
            } else {
                accordionItem.classList.add('active');
                if (icon) icon.textContent = '×';
            }
        });
    });

    // ============================================================================
    // Custom Variant Selectors
    // ============================================================================

    // Color swatches
    const colorSwatches = document.querySelectorAll('.pg-color-swatch');
    colorSwatches.forEach(swatch => {
        swatch.addEventListener('click', function (e) {
            e.preventDefault();
            const variationId = this.dataset.variationId;
            const optionId = this.dataset.option;

            // Remove active class from all swatches in this group
            document.querySelectorAll(`[data-variation-id="${variationId}"].pg-color-swatch`).forEach(s => {
                s.classList.remove('active');
            });

            // Add active class to clicked swatch
            this.classList.add('active');

            // Update hidden select
            const select = document.querySelector(`select[name="variation[${variationId}]"]`);
            if (select) {
                select.value = optionId;
                // Trigger change event for Nuvemshop handlers
                const event = new Event('change', { bubbles: true });
                select.dispatchEvent(event);
            }
        });
    });

    // Size buttons
    const sizeButtons = document.querySelectorAll('.pg-size-btn');
    sizeButtons.forEach(button => {
        button.addEventListener('click', function (e) {
            e.preventDefault();
            const variationId = this.dataset.variationId;
            const optionId = this.dataset.option;

            // Remove active class from all buttons in this group
            document.querySelectorAll(`[data-variation-id="${variationId}"].pg-size-btn`).forEach(btn => {
                btn.classList.remove('active');
            });

            // Add active class to clicked button
            this.classList.add('active');

            // Update hidden select
            const select = document.querySelector(`select[name="variation[${variationId}]"]`);
            if (select) {
                select.value = optionId;
                // Trigger change event for Nuvemshop handlers
                const event = new Event('change', { bubbles: true });
                select.dispatchEvent(event);
            }
        });
    });

    // ============================================================================
    // Sync custom selectors with Nuvemshop variant changes
    // ============================================================================
    const variantSelects = document.querySelectorAll('.js-variation-option');
    variantSelects.forEach(select => {
        select.addEventListener('change', function () {
            const variationId = this.dataset.variationId;
            const selectedValue = this.value;

            // Update color swatch if exists
            const colorSwatch = document.querySelector(`.pg-color-swatch[data-variation-id="${variationId}"][data-option="${selectedValue}"]`);
            if (colorSwatch) {
                document.querySelectorAll(`[data-variation-id="${variationId}"].pg-color-swatch`).forEach(s => {
                    s.classList.remove('active');
                });
                colorSwatch.classList.add('active');
            }

            // Update size button if exists
            const sizeButton = document.querySelector(`.pg-size-btn[data-variation-id="${variationId}"][data-option="${selectedValue}"]`);
            if (sizeButton) {
                document.querySelectorAll(`[data-variation-id="${variationId}"].pg-size-btn`).forEach(btn => {
                    btn.classList.remove('active');
                });
                sizeButton.classList.add('active');
            }
        });
    });
});

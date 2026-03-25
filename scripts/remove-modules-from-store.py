#!/usr/bin/env python3
"""
Story 8.5 Priority 2: Remove modularized sections from store.js.tpl

Sections to remove:
1. #Notifications (lines ~87-165)
2. #Utilities: cleanURLHash + goBackBrowser (~200-219)
3. #Utilities: modalOpen function (~267-318)
4. #Forms (lines ~2823-2857)
5. #Footer (lines ~2859-2869)

Each section is replaced with a comment indicating it was moved to modules/
"""

import re

# Read original file
with open('theme-deploy-corrigido/static/js/store.js.tpl', 'r', encoding='utf-8') as f:
    content = f.read()

# Pattern 1: Remove #Notifications section (lines 87-165)
pattern_notifications = r'{#/\*=+\s*#Notifications\s*=+\*/\s*#}.*?{% endif %}\s*(?={#/\*=+\s*#Modals)'
content = re.sub(pattern_notifications, '{# Story 8.5 Priority 2: #Notifications moved to modules/notifications.js #}\n\n\t', content, flags=re.DOTALL)

# Pattern 2: Remove cleanURLHash + goBackBrowser functions (around lines 202-219)
pattern_util_1 = r'{# Clean url hash function #}.*?if\(window\.location\.href\.indexOf\("modal-fullscreen"\) > -1\) \{[^}]*cleanURLHash\(\);[^}]*\}'
content = re.sub(pattern_util_1, '{# Story 8.5 Priority 2: URL hash utilities moved to modules/utilities.js #}', content, flags=re.DOTALL)

# Pattern 3: Remove modalOpen function and hash change handler (around lines 267-318)
pattern_util_2 = r'modalOpen = function\(modal_id, openType\).*?(?=\s*{#/\*=+\s*#Shipping calculator)'
content = re.sub(pattern_util_2, '{# Story 8.5 Priority 2: Modal functions moved to modules/utilities.js #}\n\n\t', content, flags=re.DOTALL)

# Pattern 4: Remove #Forms section (lines ~2823-2857)
pattern_forms = r'{#/\*=+\s*#Forms\s*=+\*/\s*#}.*?(?={#/\*=+\s*#Footer)'
content = re.sub(pattern_forms, '{# Story 8.5 Priority 2: #Forms moved to modules/forms.js #}\n\n\t', content, flags=re.DOTALL)

# Pattern 5: Remove #Footer section (lines ~2859-2869)
pattern_footer = r'{#/\*=+\s*#Footer\s*=+\*/\s*#}.*?{% endif %}\s*(?={#/\*=+)'
content = re.sub(pattern_footer, '{# Story 8.5 Priority 2: #Footer moved to modules/footer.js #}\n\n\t', content, flags=re.DOTALL)

# Write modified file
with open('theme-deploy-corrigido/static/js/store.js.tpl', 'w', encoding='utf-8') as f:
    f.write(content)

print("✓ Removidas as 4 seções de store.js.tpl")
print("✓ Backup em: store.js.tpl.backup.v1.5.76")
print("✓ Arquivo original:", open('theme-deploy-corrigido/static/js/store.js.tpl.backup.v1.5.76').read().count('\n'), "linhas")
print("✓ Arquivo novo:", content.count('\n'), "linhas")
print("✓ Linhas removidas:", open('theme-deploy-corrigido/static/js/store.js.tpl.backup.v1.5.76').read().count('\n') - content.count('\n'))

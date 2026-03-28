const fs = require('fs');
const content = fs.readFileSync('theme-deploy-corrigido/static/css/style-async.scss.tpl');
let errors = 0;
for (let i = 0; i < content.length; i++) {
    if (content[i] > 126) {
        errors++;
        console.log(`Char ${content[i]} at offset ${i} (Around Line: ${content.toString('utf-8', 0, i).split('\n').length})`);
    }
}
if (errors === 0) console.log('Clean of non-ASCII characters');
else console.log(`Total non-ASCII: ${errors}`);

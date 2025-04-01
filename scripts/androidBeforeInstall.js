// adding options from project-custom file in platformpath to default proguard-custom file in pluginpath
let fs = require('fs');
let path = require('path');

module.exports = function (ctx) {
    const projectRoot = ctx.opts.projectRoot;
    const pluginDir = ctx.opts.plugin.dir;
    const sourceProguardFile = path.join(pluginDir, 'proguard-custom.txt');
    const projectProguardFile = path.join(projectRoot, 'proguard-custom.txt');
    const destProguardFile = path.join(projectRoot, '/platforms/android/app/src/main/assets/www/proguard-custom.txt');
    try {
        let baseFile = fs.readFileSync(sourceProguardFile, 'utf8');
        if (fs.existsSync(projectProguardFile)) {
            const customFile = fs.readFileSync(projectProguardFile, 'utf8');
            baseFile += '\r\n'+customFile;
        }
        fs.writeFileSync(destProguardFile, baseFile);
    }catch(err) {
        console.error(err);
    }  
};
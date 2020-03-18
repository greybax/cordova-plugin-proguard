// adding options from project-custom file in platformpath to default proguard-custom file in pluginpath
let fs = require('fs');
let path = require('path');

module.exports = function (ctx) {
  const projectRoot = ctx.opts.projectRoot;
  const pluginDir = ctx.opts.plugin.dir;
  const targetProguardFile = path.join(pluginDir, 'proguard-custom.txt');
  const projectProguardFile = path.join(projectRoot, 'proguard-custom.txt');

  try {
    if (fs.existsSync(projectProguardFile)) {
      const data = fs.readFileSync(projectProguardFile, 'utf8');
      fs.appendFileSync(targetProguardFile, data);
      console.log('Added optional proguard-rules to proguardFile.');
    } else {
      console.log('No optional proguard-custom.txt found in projectRoot: ' + projectRoot);
    }
  } catch(err) {
    console.error(err);
  }
};
// adding options to proguard-custom file
let fs = require('fs');
let path = require('path');

module.exports = function (ctx) {
  let pluginDir = ctx.opts.plugin.dir;
  let proguardFile = path.join(pluginDir, 'proguard-custom.txt');
  let keepBillingContent = '-keep class com.android.vending.billing.** { *; }\n';
  let searchArr = process.argv;//get cordova command line arguments
  let getPreferenceValue = function (name) {
    let found = searchArr.find(element => element.indexOf(name + '=') > -1);
    if (!found) {
      return false;
    }
    let val = found.split('=')[1];
    if (val === 'true') {
      return true;
    }
    return false;
  };

  let addToProguard = function (str) {
    fs.appendFileSync(proguardFile, str);
  };

  let HAS_BILLING = getPreferenceValue('HAS_BILLING');
  if (HAS_BILLING) {
    addToProguard(keepBillingContent);
  }
  console.log('HAS_BILLING proguard set: ' + HAS_BILLING);
};

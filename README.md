# cordova-plugin-proguard

[![NPM version][npm-image]][npm-url]

> Cordova plugin which activates ProGuard and minification for debug and release builds in your cordova mobile application.

## What is ProGuard?

> ProGuard is the open source optimizer for Java bytecode

You can read more about it on [ProGuard official website](https://www.guardsquare.com/en/proguard) and on [android developer portal](https://developer.android.com/studio/build/shrink-code.html)

## How to use

- If you already have installed [Android Studio](https://developer.android.com/studio/index.html) then seems you already have installed ProGuard on your machine. If no, then  you should download and install it manually from [ProGuard official website](https://www.guardsquare.com/en/proguard).
- ```cordova plugin add cordova-plugin-proguard``` - this command will configure your `build.gradle` file and copy `proguard-custom.txt` to `${androidPlatformDirectory}/assets/www/proguard-custom.txt`

## Customization

`proguard-custom.txt` file contains some basic rules for your cordova mobile app. Feel free to [fork this repo](https://github.com/greybax/cordova-plugin-proguard/fork) and modify it as you want. 

You can also to check out some [Android ProGuard snippets](https://github.com/krschultz/android-proguard-snippets)

## History
 - v1.0.0 - supports Cordova version <7
 - v2.0.0 - supports Cordova version 7+ (thanks to @SujitSingh)

## License

MIT © [Aleksandr Filatov](https://alfilatov.com)

[npm-url]: https://npmjs.org/package/cordova-plugin-proguard
[npm-image]: https://img.shields.io/npm/v/cordova-plugin-proguard.svg

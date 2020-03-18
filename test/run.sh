#!/bin/bash
set -e
set -o xtrace

# Set variables: PLUGIN_DIR, TEST_DIR, BUILD_DIR
cd "$(dirname "$0")/.."
ROOT_DIR="$(pwd)"
TEST_DIR="$ROOT_DIR/test"
BUILD_DIR="${BUILD_DIR:-/tmp/build-$RANDOM}"

# Create and enter the build directory
rm -fr "$BUILD_DIR"
cd "$TEST_DIR"

# Command line parameters
BUNDLE_ID="$1"
IAP_ID="$2"

#PLUGIN_URL="git://github.com/j3k0/PhoneGap-InAppPurchase-iOS.git#unified"
PLUGIN_URL="$ROOT_DIR"

if [ "x$IAP_ID" = "x" ] || [ "x$1" = "x--help" ]; then
    echo
    echo "usage: $0 <bundle_id> <iap_id>"
    echo
    echo "This will generate a cordova project using Cordova $TEST_VERSION (required)."
    echo
    echo "example:"
    echo "    \$ $0 com.greybax.progplugintest progplugintest"
    echo
    exit 1
fi

# Add cordova to PATH
export PATH="$ROOT_DIR/node_modules/.bin:$PATH"

# Create a project
cordova create "$BUILD_DIR" "$BUNDLE_ID" Test

cd "$BUILD_DIR"

echo Prepare platforms
cordova platform add android || exit 1

# copy dummy
echo Copy customrules
CUSTOM_RULES="$TEST_DIR/txt/proguard-custom.txt"
cp "$CUSTOM_RULES" "$BUILD_DIR/"

echo Add Proguard plugin
cordova plugin add "$PLUGIN_URL" || exit 1

# Add console debug
# cordova plugin add https://github.com/apache/cordova-plugin-console.git || exit 1

# Check existance of the plugins files
function hasFile() {
    if test -e "$1"; then
       echo "File $1 installed."
    else
       echo "ERROR: File $1 is missing."
       echo
       echo " => it can be found at the following locations:"
       find "$BUILD_DIR" -name "$(basename "$1")"
       echo
       EXIT=1
    fi
}

# Compile for Android
echo "Android build..."
if ! cordova build android 2>&1 > $BUILD_DIR/build-android.txt; then
    tail -500 $BUILD_DIR/build-android.txt
    exit 1
fi
tail -20 $BUILD_DIR/build-android.txt

echo "Check Android installation"

# check Proguard custom file has been installed
PROGUARD_CUSTOM_FILE="$BUILD_DIR/platforms/android/app/src/main/assets/www/proguard-custom.txt"
if test ! -e "$PROGUARD_CUSTOM_FILE"; then
  echo "ERROR: Proguard-custom file not found."
  EXIT=1
fi

hasFile "$PROGUARD_CUSTOM_FILE"

# finally test if the extra rules are in place in the default proguard-custom.txt file
EXTRA_RULES=$(<$CUSTOM_RULES)

echo "Extra rules in proguard check"
echo "$EXTRA_RULES"

if grep "$EXTRA_RULES" "$PROGUARD_CUSTOM_FILE" > /dev/null; then
  echo "CUSTOM RULES successfully added has been setup."
else
  echo "ERROR: SOMETHING WENT WRONG."
  EXIT=1
fi

if [ "x$EXIT" != "x1" ]; then
  echo "Great! Everything looks good.";
fi

exit $EXIT

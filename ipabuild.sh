#!/bin/bash

set -e

cd "$(dirname "$0")"

WORKING_LOCATION="$(pwd)"
APPLICATION_NAME=noti
PLATFORM=iOS
SDK=iphoneos
if [[ $* == *--debug* ]]; then
    TARGET=Debug
else
    TARGET=Release
fi

echo "[*] Building $APPLICATION_NAME ($TARGET)..."

if [ ! -d "build" ]; then
    mkdir build
fi

cd build

xcodebuild -project "$WORKING_LOCATION/$APPLICATION_NAME.xcodeproj" \
    -scheme "$APPLICATION_NAME" \
    -configuration "$TARGET" \
    -derivedDataPath "$WORKING_LOCATION/build/DerivedDataApp" \
    -destination "generic/platform=$PLATFORM" \
    clean build \
    CODE_SIGN_IDENTITY="" CODE_SIGNING_REQUIRED=NO CODE_SIGN_ENTITLEMENTS="" CODE_SIGNING_ALLOWED="NO"

DD_APP_PATH="$WORKING_LOCATION/build/DerivedDataApp/Build/Products/"$TARGET"-$SDK/$APPLICATION_NAME.app"
TARGET_APP="$WORKING_LOCATION/build/$APPLICATION_NAME.app"
if [ ! -d "$DD_APP_PATH" ]; then
    echo "[!] Build failed. Application path not found: $DD_APP_PATH"
    exit 1
fi
cp -r "$DD_APP_PATH" "$TARGET_APP"

echo "[*] Removing code signature"
codesign --remove "$TARGET_APP" || echo "[!] Failed to remove code signature"
if [ -e "$TARGET_APP/_CodeSignature" ]; then
    rm -rf "$TARGET_APP/_CodeSignature"
fi
if [ -e "$TARGET_APP/embedded.mobileprovision" ]; then
    rm -rf "$TARGET_APP/embedded.mobileprovision"
fi

# Add entitlements
echo "[*] Adding entitlements"
ldid -S"$WORKING_LOCATION/$APPLICATION_NAME/$APPLICATION_NAME.entitlements" "$TARGET_APP/$APPLICATION_NAME" || echo "[!] Failed to add entitlements"

echo "[*] Packaging..."
mkdir -p Payload
cp -r $APPLICATION_NAME.app Payload/$APPLICATION_NAME.app

if [[ $* != *--debug* ]]; then
    strip Payload/$APPLICATION_NAME.app/$APPLICATION_NAME || echo "[!] Failed to strip symbols"
fi

zip -vr $APPLICATION_NAME.tipa Payload || echo "[!] Failed to create zip package"
rm -rf $APPLICATION_NAME.app
rm -rf Payload

echo "[*] Packaging complete. The package is available as $APPLICATION_NAME.tipa"

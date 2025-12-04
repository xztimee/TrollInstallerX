#!/usr/bin/env bash

set -e

xcodebuild -configuration Release -derivedDataPath DerivedData/LuiseInstallerX -destination 'generic/platform=iOS' -scheme LuiseInstallerX CODE_SIGNING_ALLOWED="NO" CODE_SIGNING_REQUIRED="NO" CODE_SIGN_IDENTITY=""
cp Resources/ents.plist DerivedData/LuiseInstallerX/Build/Products/Release-iphoneos/
pushd DerivedData/LuiseInstallerX/Build/Products/Release-iphoneos
rm -rf Payload LuiseInstallerX.ipa
mkdir Payload
cp -r LuiseInstallerX.app Payload
ldid -Sents.plist Payload/LuiseInstallerX.app
zip -qry LuiseInstallerX.ipa Payload
popd
cp DerivedData/LuiseInstallerX/Build/Products/Release-iphoneos/LuiseInstallerX.ipa .
rm -rf Payload
open -R LuiseInstallerX.ipa

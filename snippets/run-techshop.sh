#!/usr/bin/env bash
# Run either TechShop build on the Simulator. Both install as bundle id com.techshop.ios,
# so your tests target either one. Section 3.8.
set -e

# --- React Native (Expo) build ----------------------------------------------
# Broken:  techshop/reactnative-broken   Fixed: techshop/reactnative-fixed
run_rn() {
  cd "$1"
  npm install
  npx expo start --ios      # boots the Simulator and installs the app
}

# --- SwiftUI build ----------------------------------------------------------
# Broken:  techshop/swiftui-broken       Fixed: techshop/swiftui-fixed
run_swiftui() {
  cd "$1"
  xcodegen generate         # creates TechShop.xcodeproj from project.yml
  open TechShop.xcodeproj    # then pick an iPhone Simulator and press Run (Cmd-R)
}

# Examples:
#   ./run-techshop.sh   (then call the function you want)
# run_rn ../techshop/reactnative-broken
# run_swiftui ../techshop/swiftui-broken

echo "Source this file and call run_rn <dir> or run_swiftui <dir>."

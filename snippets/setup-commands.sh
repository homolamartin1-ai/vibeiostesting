#!/usr/bin/env bash
# TechShop iOS — full setup, in order. Run the lines you need; do not blind-run the file.
# Section 3. You need a Mac. iOS testing requires macOS + Xcode.

# --- 1. Xcode + command line tools -------------------------------------------
# Install Xcode from the App Store first, open it once, accept the license. Then:
xcode-select --install                 # command line tools (skip if already installed)
sudo xcodebuild -license accept
xcodebuild -version                    # verify
xcrun simctl list devices              # see available Simulators

# Boot an iPhone Simulator:
xcrun simctl boot "iPhone 16" || true
open -a Simulator

# --- 2. Homebrew + Node ------------------------------------------------------
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install node
node -v && npm -v

# --- 3. XcodeGen (to generate the SwiftUI app project) ----------------------
brew install xcodegen

# --- 4. Maestro -------------------------------------------------------------
curl -fsSL "https://get.maestro.mobile.dev" | bash
maestro -v

# --- 5. Appium + the iOS (XCUITest) driver ----------------------------------
npm install -g appium
appium -v
appium driver install xcuitest
appium driver list --installed
# Doctor: checks your whole iOS setup and points at anything missing.
appium driver doctor xcuitest

# --- 6. Python for the Appium suite -----------------------------------------
python3 -m pip install --upgrade pip
python3 -m pip install Appium-Python-Client pytest

# --- 7. Antigravity ---------------------------------------------------------
# Install the Antigravity IDE from its site, then connect the mobile MCP
# (see mobile-mcp-config.json and docs/setup-07-mobile-mcp.md).

echo "Setup checks complete. See docs/setup-01..07 for details and troubleshooting."

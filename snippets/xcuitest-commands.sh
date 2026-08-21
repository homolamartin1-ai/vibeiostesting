#!/usr/bin/env bash
# XCUITest reference. Section 10. Runs through Xcode's build system.

# Run the UI tests on a Simulator destination (credentials from the environment):
TEST_EMAIL="$TEST_EMAIL" TEST_PASSWORD="$TEST_PASSWORD" \
xcodebuild test \
  -scheme TechShop \
  -destination 'platform=iOS Simulator,name=iPhone 15' \
  -only-testing:TechShopUITests

# List simulators / schemes:
xcrun simctl list devices
xcodebuild -list -project TechShop.xcodeproj

# The result bundle (.xcresult) holds a screenshot at each step — open it in Xcode
# or find it under DerivedData to debug a failure (Section 13).

# In Xcode: add a "UI Testing Bundle" target named TechShopUITests, drop in the files
# from xcuitest/TechShopUITests/, set its Target Application to TechShop, then Cmd-U.

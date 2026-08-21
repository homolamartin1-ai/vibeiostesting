#!/usr/bin/env bash
# Copy to a local, gitignored file, fill in, and `source` it before running any suite.
# Never hardcode these in a flow, a test, or a commit.
export TEST_EMAIL="demo@techshop.com"
export TEST_PASSWORD="password123"

# Optional overrides used by the Appium suite:
# export IOS_DEVICE="iPhone 16"
# export IOS_VERSION="17.5"
# export APPIUM_SERVER="http://127.0.0.1:4723"

#!/usr/bin/env bash
# Appium reference. Section 9. Two terminals: one runs the server, one runs the tests.

# Terminal 1 — start the Appium server (leave it running):
appium

# Terminal 2 — from the appium/ folder:
source ../snippets/env-setup.sh     # or your own env file
pytest -v                            # run the whole suite (testpaths=tests in pytest.ini)
pytest -v tests/test_login.py        # one file
pytest -v -k secure                  # one test by keyword

# Diagnostics:
appium driver doctor xcuitest        # verify the iOS toolchain
xcrun simctl list devices booted     # confirm a Simulator is booted

# The driver launches the app by bundle id com.techshop.ios (set in conftest.py),
# so install the SwiftUI OR the React Native build first — the tests run against either.

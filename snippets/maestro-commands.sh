#!/usr/bin/env bash
# Maestro CLI reference. Section 8. Boot a Simulator with a TechShop build installed first.

# Run one flow (pass credentials as env params):
maestro test maestro/flows/login-happy.yaml -e EMAIL="$TEST_EMAIL" -e PASSWORD="$TEST_PASSWORD"

# Run the whole flows folder:
maestro test maestro/flows/ -e EMAIL="$TEST_EMAIL" -e PASSWORD="$TEST_PASSWORD"

# Interactive inspector — point at the running app, see the element tree, try steps:
maestro studio

# List connected devices/Simulators Maestro can see:
maestro test --help          # all options
xcrun simctl list devices booted   # confirm a Simulator is booted

# Tip: a flow's `appId:` must match the installed bundle id — com.techshop.ios for both builds.

# S10 — The XCUITest Suite

Companion to Section 10. Builds into `xcuitest/`. Prompts:
[`prompts/section-10-xcuitest.md`](../prompts/section-10-xcuitest.md). CLI:
[`snippets/xcuitest-commands.sh`](../snippets/xcuitest-commands.sh).

## The model
Apple's native framework, in Swift, inside Xcode. No server, no external runner — the test
runs alongside the app, driven by Xcode. You get `XCUIApplication` and reach in:
`app.textFields`, `app.buttons`, `app.secureTextFields`. Fastest of the three; iOS-only.

## Setup (one-time for the target)
1. `xcodegen generate` in `techshop/swiftui-broken` to make `TechShop.xcodeproj`.
2. Xcode → **File → New → Target → UI Testing Bundle**, named `TechShopUITests`.
3. Add the Swift files, set the target's **Target Application** to `TechShop`.

### Or wire it with XcodeGen (recommended — reproducible, and what CI uses)
Instead of clicking through Xcode, add a UI-test target to the app's `project.yml`
(`techshop/swiftui-fixed/project.yml`) pointing at the Swift files you build in `xcuitest/`.
This is the same target Section 14's `xcuitest.yml` regenerates on the runner, so wiring it
here means CI just works:
```yaml
  TechShopUITests:
    type: bundle.ui-testing
    platform: iOS
    sources:
      - ../../xcuitest/TechShopUITests
    dependencies:
      - target: TechShop
    settings:
      base:
        PRODUCT_BUNDLE_IDENTIFIER: com.techshop.TechShopUITests
        GENERATE_INFOPLIST_FILE: YES
        TEST_TARGET_NAME: TechShop
```
Then `xcodegen generate` and `xcodebuild test`. Add this target **after** you've created
`xcuitest/TechShopUITests/` — the `sources` path must exist or `xcodegen generate` fails.

> **"unsupported Xcode project version 77"** on a CI runner (or an older Xcode) means your
> local XcodeGen emitted a newer `.pbxproj` format than the runner's Xcode reads. Fix by
> matching versions (pin the same Xcode on the runner), or pin an older project format in
> `options:` (e.g. `projectVersion: 56`) so the generated project stays broadly compatible.

## What you build
```
xcuitest/TechShopUITests/
├── TechShopUITestCase.swift   # base: launch by bundle id, creds from ProcessInfo,
│                              #       framework-agnostic el(id), login(), addItemAndOpenCart()
├── LoginUITests.swift         # BUG-001 (secureTextFields), 002, 003, 016
├── GeneralUITests.swift       # BUG-014, 015
├── CartUITests.swift          # BUG-004, 005, 006
└── CheckoutUITests.swift      # BUG-011; 012, 013 (fixed build)
```

## Run
```bash
xcodebuild test -scheme TechShop -destination 'platform=iOS Simulator,name=iPhone 16'
```
(or **Cmd-U** in Xcode). Credentials from `TEST_EMAIL` / `TEST_PASSWORD`.

## Key points
- Locate by identifier via `descendants(matching:.any)[id]` — type-agnostic, so it survives
  SwiftUI vs React Native.
- **The clean win:** `app.secureTextFields["login-password"]` exists → masked; catches BUG-001.
- `waitForExistence` for waits. The recorder is handy but loves fragile locators — the skill's
  standards win. Failures produce a `.xcresult` bundle with per-step screenshots (Section 13).
- Native-only reality: runs the RN app on iOS, but never on Android. That's the trade-off.

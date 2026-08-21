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
xcodebuild test -scheme TechShop -destination 'platform=iOS Simulator,name=iPhone 15'
```
(or **Cmd-U** in Xcode). Credentials from `TEST_EMAIL` / `TEST_PASSWORD`.

## Key points
- Locate by identifier via `descendants(matching:.any)[id]` — type-agnostic, so it survives
  SwiftUI vs React Native.
- **The clean win:** `app.secureTextFields["login-password"]` exists → masked; catches BUG-001.
- `waitForExistence` for waits. The recorder is handy but loves fragile locators — the skill's
  standards win. Failures produce a `.xcresult` bundle with per-step screenshots (Section 13).
- Native-only reality: runs the RN app on iOS, but never on Android. That's the trade-off.

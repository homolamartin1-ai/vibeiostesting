# Section 10 — Writing the Test Suite in XCUITest

> 📖 **Guide:** [XCUITest suite](../docs/s10-xcuitest.md) · builds into `xcuitest/`

You build the native XCUITest suite (Swift) yourself, using the same test matrix and the
**test-authoring skill**. XCUITest has the deepest access to the accessibility tree and is
the fastest to execute — the trade-off is that it is iOS-only.

## Course reference
| Prompt | Used in clip |
|--------|-------------|
| Prompt 1 — Base test case + login test | **10, Clip 2** |
| Prompt 2 — Cart tests | **10, Clip 3** |
| Prompt 3 — Checkout tests | **10, Clip 3** |
| Prompt 4 — The React Native reality | **10, Clip 4** |

> Setup: add a **UI Testing Bundle** target named `TechShopUITests` to the TechShop app in
> Xcode (or use `xcuitest/project.yml` with XcodeGen), and set its Target Application to
> TechShop. See [../docs/s10-xcuitest.md](../docs/s10-xcuitest.md).

---

## Prompt 1: Base test case + login test
*Used in: Section 10, Clip 2*

```
First make sure the BROKEN build is installed on the Simulator — com.techshop.ios from
techshop/reactnative-broken or techshop/swiftui-broken (the version with the planted bugs),
not the fixed build.

Then, following skills/test-authoring.md, create the XCUITest base and login tests under
xcuitest/TechShopUITests/:

- TechShopUITestCase.swift — base XCTestCase that launches
  XCUIApplication(bundleIdentifier: "com.techshop.ios"), reads TEST_EMAIL/TEST_PASSWORD
  from ProcessInfo, and provides framework-agnostic helpers: el(id) via
  descendants(matching:.any), hasText, a passwordField() that returns the secure OR plain
  field, login(), and addItemAndOpenCart(). Locate the login button by the label "Log In".
- LoginUITests.swift — valid login reaches the catalog; BUG-002 empty rejected;
  BUG-003 wrong rejected; BUG-001 assert app.secureTextFields["login-password"] exists;
  BUG-016 assert app.buttons["login-submit"] exists.
```

**Expected:** run with `xcodebuild test -scheme TechShop -destination 'platform=iOS Simulator,name=iPhone 16'` (with TEST_EMAIL/TEST_PASSWORD exported).

---

## Prompt 2: Cart tests
*Used in: Section 10, Clip 3*

```
Add CartUITests.swift and GeneralUITests.swift using the base helpers:
- BUG-005 quantity never below 1 (assert el("qty-p1").label == "1").
- BUG-006 total updates (label contains "60" then "120").
- BUG-004 SAVE10 -> total contains "54".
- BUG-015 no cartTab before auth; BUG-014 catalog title is not "Untitled".
```

---

## Prompt 3: Checkout tests
*Used in: Section 10, Clip 3*

```
Add CheckoutUITests.swift:
- testProceedOpensCheckout — BUG-011 (catches the blocker on broken).
- testEmptyCheckoutRejected — BUG-012 (fixed build).
- testConfirmationHasOrderReference — BUG-013 (fixed build): fill all fields with valid
  data (future expiry, 16-digit card, 3-digit CVV), submit, assert "Order Confirmed" and
  el("confirmation-order-ref").
Comment which run on the fixed build only and why.
```

---

## Prompt 4: The React Native reality
*Used in: Section 10, Clip 4*

```
Run the XCUITest suite against the SwiftUI build, then against the React Native build
(same bundle id). Report where the accessibility tree differs (element types/hierarchy)
and whether the framework-agnostic el(id) helper absorbed the difference. Explain why a
team on a React Native app might still prefer Maestro or Appium over XCUITest.
```

**Expected:** the suite runs on both, and you can now articulate — for Section 11 — when
native XCUITest is worth its iOS-only constraint and when it isn't.

# Section 8 — Writing the Test Suite in Maestro

> 📖 **Guide:** [Maestro flows](../docs/s08-maestro.md) · builds into `maestro/`

You build the Maestro flow suite yourself, flow by flow, using the **test-authoring skill**
(Section 5) and the test matrix (Section 7). Point the Simulator at the **broken** build so
the bug flows fail, then the **fixed** build for the regression pass in Section 13.

## Course reference
| Prompt | Used in clip |
|--------|-------------|
| Prompt 1 — Login flow + reusable subflow | **8, Clip 2** |
| Prompt 2 — Cart flows | **8, Clip 3** |
| Prompt 3 — Checkout flows | **8, Clip 3** |
| Prompt 4 — One flow, two apps | **8, Clip 4** |

---

## Prompt 1: Login flow + reusable subflow
*Used in: Section 8, Clip 2*

```
Following skills/test-authoring.md, build the Maestro login flows for TechShop iOS
(appId com.techshop.ios):

- maestro/subflows/login.yaml — a reusable valid login. Locate the button by the text
  "Log In" (no id in the broken build). Parameterise creds with ${EMAIL}/${PASSWORD}.
- maestro/flows/login-happy.yaml — launch fresh, run the login subflow, assert the
  catalog was reached (a product name, not the title).
- maestro/flows/login-empty.yaml — BUG-002: submit empty, assert we did NOT reach the
  catalog and are still on login.
- maestro/flows/login-wrong.yaml — BUG-003: wrong credentials, assert not reached.

Then tell me which planted login bug each flow targets.
```

**Expected:** three flows + one subflow. Run them: `maestro test maestro/flows/login-empty.yaml -e EMAIL=$TEST_EMAIL -e PASSWORD=$TEST_PASSWORD`.

---

## Prompt 2: Cart flows
*Used in: Section 8, Clip 3*

```
Following skills/test-authoring.md and reusing subflows/login.yaml, build the cart flows
under maestro/flows/:

- cart-quantity-min.yaml — BUG-005: add p1, open the Cart tab, decrement at qty 1,
  assert qty stays "1".
- cart-total-updates.yaml — BUG-006: p1 is 60; assert total shows 60, increment to qty 2,
  assert total shows 120.
- cart-discount.yaml — BUG-004: apply SAVE10 to a $60 cart, assert total shows 54.
- tabbar-before-auth.yaml — BUG-015: on launch (before login) assert the Cart tab is not
  visible.
- catalog-title.yaml — BUG-014: after login assert "Untitled" is NOT shown.

Use id: locators for stepper/total/discount, and assertVisible with a text regex for the
total.
```

**Expected:** five flows. On the broken build they fail (bugs caught); note that Maestro
cannot assert BUG-001 (secure entry) or BUG-008 (colour) — those wait for Appium/XCUITest.

---

## Prompt 3: Checkout flows
*Used in: Section 8, Clip 3*

```
Following skills/test-authoring.md, build the checkout flows under maestro/flows/:

- checkout-proceed.yaml — BUG-011: add p1, open Cart, tap Proceed to Checkout, assert the
  Checkout screen appears. This is the flow that CATCHES the blocker on the broken build.
- checkout-empty.yaml — BUG-012 (fixed build): reach checkout, submit empty, assert a
  validation error and that no order was placed.
- confirmation-orderref.yaml — BUG-013 (fixed build): complete a valid purchase, assert
  "Order Confirmed" and that the order reference element is present.

Mark the two that only run on the fixed build (BUG-011 blocks checkout on broken) and
explain why.
```

**Expected:** three flows; the blocker dependency is documented in the flows themselves.

---

## Prompt 4: One flow, two apps
*Used in: Section 8, Clip 4*

```
Without changing any flow, run maestro/flows/login-happy.yaml against the SwiftUI build,
then reinstall the React Native build (same bundle id) and run it again. Explain why the
identical flow works on both, and where in the accessibility tree the two apps differ.
```

**Expected:** the same YAML passes on both builds — the payoff of stable accessibility ids.
This is the bridge to the Android course, where the same flows carry across platforms.

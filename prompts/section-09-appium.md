# Section 9 — Writing the Test Suite in Appium

> 📖 **Guide:** [Appium suite](../docs/s09-appium.md) · builds into `appium/`

You build the Appium suite (Python + pytest, Page Object Model) yourself, using the same
test matrix and the **test-authoring skill**. Appium reads element attributes, so here you
finally catch **BUG-001** (password not masked) that Maestro could not.

## Course reference
| Prompt | Used in clip |
|--------|-------------|
| Prompt 1 — Driver setup + login page/test | **9, Clip 2** |
| Prompt 2 — Catch BUG-001 via attribute | **9, Clip 2** |
| Prompt 3 — Cart page + tests | **9, Clip 3** |
| Prompt 4 — Checkout page + tests | **9, Clip 3** |
| Prompt 5 — Same caps, two apps | **9, Clip 4** |

---

## Prompt 1: Driver setup + login page and test
*Used in: Section 9, Clip 2*

```
First make sure the BROKEN build is installed on the Simulator — com.techshop.ios from
techshop/reactnative-broken or techshop/swiftui-broken (the version with the planted bugs),
not the fixed build.

Then, following skills/test-authoring.md, scaffold an Appium suite under appium/ for TechShop
iOS (bundle id com.techshop.ios, XCUITest automation):

- conftest.py — a function-scoped driver fixture that launches the app fresh each test,
  reading TEST_EMAIL/TEST_PASSWORD from the environment. Add a pytest.ini and
  requirements.txt.
- pages/base_page.py — helpers: by_id (accessibility id), exists, text_visible
  (iOS predicate), type_into.
- pages/login_page.py + pages/catalog_page.py.
- tests/test_login.py — valid login reaches the catalog; BUG-002 empty rejected;
  BUG-003 wrong credentials rejected. Locate the login button by the label "Log In".

Keep shared flows (login, add-to-cart) in a flows.py helper, not copy-pasted.
```

**Expected:** a runnable skeleton. Start Appium (`appium`) and run `pytest -v`.

---

## Prompt 2: Catch BUG-001 with an attribute assertion
*Used in: Section 9, Clip 2*

```
Add tests to appium/tests/test_login.py:
- test_password_field_is_secure — BUG-001: assert the password field's element type is
  "XCUIElementTypeSecureTextField" (a plaintext field would be XCUIElementTypeTextField).
- test_login_button_has_stable_id — BUG-016: assert an element with accessibility id
  "login-submit" exists.
Explain why Maestro could not make the first assertion but Appium can.
```

**Expected:** the "framework can see what it can see" lesson, made concrete.

---

## Prompt 3: Cart page object + tests
*Used in: Section 9, Clip 3*

```
Following the skill, add pages/cart_page.py (quantity, increment/decrement, order total,
apply discount, proceed) and tests/test_cart.py:
- BUG-005 quantity never below 1; BUG-006 total updates on quantity change (60 -> 120);
  BUG-004 SAVE10 on $60 -> $54.
Add tests/test_general.py: BUG-015 no Cart tab before auth; BUG-014 title is not "Untitled".
Reuse the add-item-and-open-cart flow from flows.py.
```

---

## Prompt 4: Checkout page object + tests
*Used in: Section 9, Clip 3*

```
Add pages/checkout_page.py and tests/test_checkout.py:
- test_proceed_opens_checkout — BUG-011 (catches the blocker on broken).
- test_empty_checkout_rejected — BUG-012 (fixed build).
- test_confirmation_has_order_reference — BUG-013 (fixed build): fill valid data, submit,
  assert "Order Confirmed" and the confirmation-order-ref element.
Note in comments which tests only run on the fixed build and why.
```

---

## Prompt 5: Same capabilities, two apps
*Used in: Section 9, Clip 4*

```
Without changing the tests, point Appium at the SwiftUI build, run the suite, then install
the React Native build (same bundle id) and run again. Explain any element-type
differences you had to account for, and confirm the accessibility-id locators held.
```

**Expected:** the full suite green on both builds against the fixed app; the bug tests red
on broken. Compare run time and setup effort with Maestro — you'll use this in Section 11.

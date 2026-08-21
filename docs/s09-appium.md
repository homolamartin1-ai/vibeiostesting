# S09 — The Appium Suite

Companion to Section 9. Builds into `appium/`. Prompts:
[`prompts/section-09-appium.md`](../prompts/section-09-appium.md). CLI:
[`snippets/appium-commands.sh`](../snippets/appium-commands.sh).

## The model
Appium follows WebDriver: an Appium **server** takes your test's commands and translates them
into XCUITest actions on the Simulator. You configure it with **capabilities** (platform,
automation engine, device, bundle id) and drive it in Python with pytest.

## What you build (Page Object Model)
```
appium/
├── conftest.py           # driver fixture: fresh launch per test, creds from env
├── pytest.ini
├── pages/                # one class per screen: base, login, catalog, cart, checkout
├── flows.py              # shared login / add-to-cart (no copy-paste)
└── tests/                # test_login, test_general, test_cart, test_checkout
```

## Run (two terminals)
```bash
appium            # terminal 1
pytest -v         # terminal 2 (from appium/)
```

## Key points
- Locate with `AppiumBy.ACCESSIBILITY_ID`; use an iOS predicate for text.
- **The Appium win:** it reads attributes, so it catches **BUG-001** by asserting the
  password field's type is `XCUIElementTypeSecureTextField`, and **BUG-016** by asserting the
  `login-submit` id exists — cases Maestro could not do.
- **Waits, not sleeps:** wait for an element to exist before acting (mobile animates).
- **Isolation:** the fixture relaunches the app each test.
- Runs against both builds — location by id absorbs SwiftUI vs React Native type differences.
- Cross-platform: this suite carries to Android with different capabilities.

# S08 — The Maestro Suite

Companion to Section 8. Builds into `maestro/`. Prompts:
[`prompts/section-08-maestro.md`](../prompts/section-08-maestro.md). CLI:
[`snippets/maestro-commands.sh`](../snippets/maestro-commands.sh).

## The model
A test is a YAML **flow**: `appId:` then a list of steps (`launchApp`, `tapOn`, `inputText`,
`assertVisible`). No build step, no language. Flows call other flows (`runFlow`) — so login
lives once in a subflow.

## What you build
```
maestro/
├── subflows/login.yaml          # reusable valid login (button by text "Log In")
└── flows/
    ├── login-happy / login-empty / login-wrong     # BUG-002, 003
    ├── tabbar-before-auth / catalog-title           # BUG-015, 014
    ├── cart-quantity-min / cart-total-updates / cart-discount   # BUG-005, 006, 004
    ├── checkout-proceed                              # BUG-011 (catches the blocker)
    ├── checkout-empty / confirmation-orderref        # BUG-012, 013 (fixed build)
```

## Run
```bash
maestro test maestro/flows/ -e EMAIL="$TEST_EMAIL" -e PASSWORD="$TEST_PASSWORD"
```

## Key points
- Locate by `id:`; use text only for the login button (no id on the broken build).
- Assert the real outcome (a product name for "reached catalog", not the title — the title
  is BUG-014). For the total, assert a text regex like `.*120.*`.
- **Maestro can't** assert BUG-001 (secure entry) or BUG-008 (colour) — leave those honestly
  for Appium/XCUITest rather than faking a check.
- **One flow, two apps:** the same login flow passes on the SwiftUI and React Native builds
  unchanged — the payoff of stable identifiers, and the bridge to Android.

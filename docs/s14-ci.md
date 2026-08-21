# S14 — Shipping to CI

Companion to Section 14. Builds into `.github/workflows/`. Prompts:
[`prompts/section-14-ci.md`](../prompts/section-14-ci.md).

## The mobile CI model (one skeleton, three workflows)
Every workflow is a variation on:
1. **macOS runner** (mandatory — iOS needs Xcode/Simulator).
2. **Boot an iPhone Simulator** headless (`xcrun simctl`).
3. **Build & install** the app.
4. **Install the framework** and **run the suite**, reading `TEST_EMAIL` / `TEST_PASSWORD`
   from **repository secrets**.
5. **Upload artifacts** (recording / screenshots / `.xcresult`).

## The three workflows
- `maestro.yml` — install Maestro, `maestro test`, upload the report.
- `appium.yml` — start Appium, `pip install`, `pytest`, upload results.
- `xcuitest.yml` — `xcodebuild test` on a Simulator destination, upload the `.xcresult`.

## Secrets
Add `TEST_EMAIL` and `TEST_PASSWORD` as **repository secrets** (Settings → Secrets and
variables → Actions). They never appear in code — your skills enforced env-var credentials
from the first test, so this is trivial now.

## Debugging CI failures
Most early failures are infrastructure, not tests: Simulator didn't boot, app didn't install,
wrong destination, missing secret. Paste the run log to the agent and ask it to diagnose —
CI logs are long and noisy, and the agent parses them fast.

## Career note
Maestro and Appium workflows are cross-platform: point the same skeleton at an Android
emulator and they run on Android. You're learning the mobile CI pattern, not just iOS CI.

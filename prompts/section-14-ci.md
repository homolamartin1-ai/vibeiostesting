# Section 14 — Shipping to CI

> 📖 **Guide:** [s14 CI](../docs/s14-ci.md)

You build the CI pipelines yourself with the agent, so all three suites run on a macOS
runner with a booted Simulator on every push. Workflows land in `.github/workflows/`.

## Course reference
| Prompt | Used in clip |
|--------|-------------|
| Prompt 1 — How mobile CI works | **14, Clip 1** |
| Prompt 2 — Maestro workflow | **14, Clip 2** |
| Prompt 3 — Appium & XCUITest workflows | **14, Clip 3** |
| Prompt 4 — Debug a CI failure | **14, Clip 4** |

---

## Prompt 1: How mobile CI works
*Used in: Section 14, Clip 1*

```
Explain how CI runs iOS UI tests: why it needs a macOS runner, how the Simulator is booted
headless (xcrun simctl), where the app build comes from, and how test artifacts
(recordings, screenshots, .xcresult) are uploaded. Keep it to what I need to write the
workflows.
```

## Prompt 2: The Maestro workflow
*Used in: Section 14, Clip 2*

```
Write .github/workflows/maestro.yml: on push, on a macos runner — boot an iPhone Simulator,
build & install techshop/reactnative-fixed, install Maestro, run maestro test maestro/flows
with TEST_EMAIL/TEST_PASSWORD from repository secrets, and upload the Maestro report as an
artifact.
```

## Prompt 3: Appium and XCUITest workflows
*Used in: Section 14, Clip 3*

```
Write .github/workflows/appium.yml (start Appium, pip install, boot Simulator, install the
app, run pytest, upload results) and .github/workflows/xcuitest.yml (xcodebuild test on a
Simulator destination, upload the .xcresult bundle). Read secrets TEST_EMAIL/TEST_PASSWORD;
never hardcode credentials.
```

## Prompt 4: Debug a CI failure
*Used in: Section 14, Clip 4*

```
Here is a failing CI run log: [paste]. Diagnose it — Simulator not booted, app not
installed, wrong destination, missing secret, or a real test failure — and tell me the
exact fix.
```

**Expected:** three green workflows with artifacts on every push. Add `TEST_EMAIL` and
`TEST_PASSWORD` as repository secrets. Now it runs without you.

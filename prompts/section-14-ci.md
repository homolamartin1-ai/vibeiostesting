# Section 14 — Shipping to CI

> 📖 **Guide:** [s14 CI](../docs/s14-ci.md)

You build the CI pipelines yourself with the agent, so all three suites run on a macOS
runner with a booted Simulator on every push. Workflows land in `.github/workflows/`.

## Course reference
| Prompt | Used in clip |
|--------|-------------|
| Prompt 1 — How mobile CI works | **14, Clip 1** |
| Prompt 2 — Set up the repository secrets | **14, Clip 2** |
| Prompt 3 — Maestro workflow | **14, Clip 2** |
| Prompt 4 — Push the Maestro workflow | **14, Clip 2** |
| Prompt 5 — Appium & XCUITest workflows | **14, Clip 3** |
| Prompt 6 — Push the Appium & XCUITest workflows | **14, Clip 3** |
| Prompt 7 — Diagnose & fix a CI failure | **14, Clip 4** |

---

## Prompt 1: How mobile CI works
*Used in: Section 14, Clip 1*

```
Explain how CI runs iOS UI tests: why it needs a macOS runner, how the Simulator is booted
headless (xcrun simctl), where the app build comes from, and how test artifacts
(recordings, screenshots, .xcresult) are uploaded. Keep it to what I need to write the
workflows.
```

## Prompt 2: Set up the repository secrets first
*Used in: Section 14, Clip 2*

```
Before we write any workflow, set up the credentials the pipelines need so no run fails on
a missing secret. The tests read TEST_EMAIL and TEST_PASSWORD from the environment; in CI
those come from GitHub repository secrets.

Using the gh CLI, add TEST_EMAIL and TEST_PASSWORD as repository secrets on my repo, set to
the ACTUAL values from my local .env-local (source it first, then pass each value explicitly,
e.g. gh secret set TEST_EMAIL --body "$TEST_EMAIL" and gh secret set TEST_PASSWORD --body
"$TEST_PASSWORD"). Do not create them empty and do not print the values. Then confirm both
exist and are non-empty with gh secret list. If gh is not authenticated, tell me to run
gh auth login first.
```

**Expected:** `gh secret list` shows `TEST_EMAIL` and `TEST_PASSWORD`. Now every workflow
you write can read them and will not fail on a missing secret.

## Prompt 3: The Maestro workflow
*Used in: Section 14, Clip 2*

```
Write .github/workflows/maestro.yml: on push, on a macos runner — boot an iPhone Simulator,
build & install techshop/reactnative-fixed, install Maestro, run maestro test maestro/flows
with TEST_EMAIL/TEST_PASSWORD from the repository secrets we just set, and upload the
Maestro report as an artifact.
```

## Prompt 4: Push everything to main
*Used in: Section 14, Clip 2*

```
We have been building locally all course and never pushed. Now commit and push EVERYTHING to
main — the skills, all three test suites (maestro/, appium/, xcuitest/), and the new
.github/workflows/maestro.yml — not just the workflow file. First show me git status so I
see what will go up, make sure no secrets or .env-local are staged (they must stay
gitignored), then commit with a clear message and push. The push triggers the Maestro
workflow: confirm the run started (gh run list) and report the run URL so we can watch it.
```

## Prompt 5: Appium and XCUITest workflows
*Used in: Section 14, Clip 3*

```
Write .github/workflows/appium.yml (start Appium, pip install, boot Simulator, install the
app, run pytest, upload results) and .github/workflows/xcuitest.yml (xcodebuild test on a
Simulator destination, upload the .xcresult bundle). Read secrets TEST_EMAIL/TEST_PASSWORD;
never hardcode credentials.
```

## Prompt 6: Push the Appium & XCUITest workflows to main
*Used in: Section 14, Clip 3*

```
Commit .github/workflows/appium.yml and .github/workflows/xcuitest.yml to main and push
them, so both workflows trigger. Use a clear commit message. Then confirm both runs started
(gh run list) and report the run URLs.
```

## Prompt 7: Diagnose and fix a CI failure
*Used in: Section 14, Clip 4*

```
Here is a failing CI run log: [paste]. Diagnose the cause — Simulator not booted, app not
installed, wrong destination, missing secret, or a real test failure — then FIX it: edit the
workflow (or the test) directly, explain what you changed and why, and push so the next run
is green. Don't just describe the fix — apply it.
```

**Expected:** three green workflows with artifacts on every push — and the secrets are
already in place from Prompt 2, so nothing fails on a missing credential. Now it runs
without you.

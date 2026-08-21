# Section 5 — Skills for AI Agents: Building the Toolkit

> 📖 **Guide:** [How Skills Work](../docs/s05-how-skills-work.md)

The centerpiece. Each prompt creates one reusable skill file in `skills/`, then a
follow-up prompt proves it works. You keep these skills and reuse them for the rest of the
course — across all three frameworks.

## Course reference
| Prompt | Used in clip |
|--------|-------------|
| Prompt 1 — Build the test-case-design skill | **5, Clip 2** |
| Prompt 1b — Try it | **5, Clip 2** |
| Prompt 2 — Build the test-authoring skill | **5, Clip 3** |
| Prompt 2b — Try it | **5, Clip 3** |
| Prompt 3 — Build the bug-reporting skill | **5, Clip 4** |
| Prompt 4 — Build the flake-triage skill | **5, Clip 5** |

> A "skill" is a markdown file the agent reads before a task, so it applies your standards
> every time instead of improvising. Save these to `skills/`.

---

## Prompt 1: Build the Test-Case Design Skill
*Used in: Section 5, Clip 2*

```
Create a reusable skill file at skills/test-case-design.md.

Purpose: given a mobile feature and my exploration notes, produce a complete test
matrix. Write it as instructions YOU (the agent) follow whenever I ask you to design
test cases. It must require:

- THREE categories per feature: Positive, Negative, Edge (boundaries).
- A consistent per-case format: ID, behavioural title, category, preconditions,
  steps, expected result.
- Coverage tied to the real app: use exploration-notes.md, not generic guesses.
- For each case, note the LOCATOR it will need (accessibility id or visible text),
  and flag any control with NO stable id as a testability defect.
- Flag any known bug as a planned regression case with its BUG-id, and note cases
  that are blocked by another bug.

Keep it concise and instructional. This file is the standard, not an example.
```

## Prompt 1b: Try the Test-Case Design Skill
*Used in: Section 5, Clip 2*

```
Following skills/test-case-design.md exactly, and using exploration-notes.md, design
the test cases for the LOGIN feature only. Output the matrix so I can review it.
```

**Expected:** a positive/negative/edge matrix in the skill's format, with locators noted
and known login bugs flagged. If it drifts from the format, fix the skill, not the output.

---

## Prompt 2: Build the Test-Authoring Skill
*Used in: Section 5, Clip 3*

```
Create a reusable skill file at skills/test-authoring.md.

Purpose: turn test cases into clean MOBILE tests to a consistent standard, in whichever
framework I name (Maestro, Appium, or XCUITest). Write it as instructions you follow
whenever I ask you to write tests. It must require:

- LOCATORS: prefer stable accessibility identifiers (SwiftUI accessibilityIdentifier /
  React Native testID). Use visible text only when no id exists; if a key control has
  no id, recommend adding one. Never locate by position or index.
- ASSERTIONS: every test asserts the real outcome (value, state, visibility, element
  type), never just "it didn't crash".
- ISOLATION: each test launches the app fresh and runs in any order.
- SECRETS: credentials from TEST_EMAIL / TEST_PASSWORD env vars, never hardcoded.
- NO manual sleeps; use each framework's wait mechanism.
- REUSE: shared setup (login, add-to-cart) in a subflow / helper / base class.
- CROSS-BUILD: the same test must run against the SwiftUI and React Native builds
  (same bundle id) — so the login button is located by the text "Log In" (it has no
  id in the broken build).
- Per-framework notes for Maestro (YAML flows + subflows), Appium (pytest + Page
  Objects), and XCUITest (Swift base XCTestCase + helpers).
- A note that Maestro can't read hidden attributes (secure-entry, colour) — defer
  those cases to Appium/XCUITest rather than writing a weak assertion.

Keep it concise. This is the rulebook the suites are built on.
```

## Prompt 2b: Try the Test-Authoring Skill
*Used in: Section 5, Clip 3*

```
Following skills/test-authoring.md, write the Maestro login flow from the login test
cases we designed. Put it at maestro/flows/login-happy.yaml with a reusable
maestro/subflows/login.yaml. Then walk me through how it satisfies each rule.
```

**Expected:** clean id/text locators, a real assertion that the catalog was reached, a
reusable login subflow, creds via `${EMAIL}`/`${PASSWORD}`. Review it with the Section 5
checklist before trusting it. (This login flow is the one you read closely in Section 6.)

---

## Prompt 3: Build the Bug-Reporting Skill
*Used in: Section 5, Clip 4*

```
Create a reusable skill file at skills/bug-reporting.md.

Purpose: turn a failing mobile test + its artifact into a developer-ready bug report.
It must require this structure: specific behavioural Title; Environment (build
SwiftUI/RN, broken/fixed, iOS version, Simulator, which framework); numbered Steps to
reproduce; SEPARATE Expected and Actual fields; Severity with a one-line reason;
Evidence (Maestro recording / Appium screenshot / Xcode .xcresult). Require noting the
element's accessibility id (or that it has none), whether the bug blocks other tests,
and whether it reproduces on one build but not the other.

End with a self-check: "Could a developer reproduce this from the steps alone on a
clean Simulator?" If not, it is not done. Keep it concise and project-agnostic.
```

**Note:** put this to work in Section 12. For now, build it and, if you have a failing
test, feed one failure through it.

---

## Prompt 4: Build the Flake-Triage Skill
*Used in: Section 5, Clip 5*

```
Create a reusable skill file at skills/flake-triage.md.

Purpose: decide whether a failing mobile test is a REAL BUG or a FLAKY TEST. It must
require working through: (1) Consistency — fails every run or sometimes? re-run it;
(2) Cause — app behaving wrong, or the test tripping over mobile noise (animation not
settled, keyboard covering the field, tap before render, fragile locator)?
(3) Evidence — was the app genuinely broken in the artifact, or did the test look too
early? (4) Classification — REAL BUG or FLAKY TEST; (5) Recommendation — real bug →
bug-reporting skill; flaky → the specific fix (wait-for-existence, dismiss keyboard,
stable id, relaunch isolation), don't file a bug.

List the common mobile flake sources. Require asking to re-run when consistency is
unclear. Keep it concise.
```

**Expected:** four skill files now live in `skills/`. They are the toolkit for Sections
7–15 — and the thing you carry to your next project.

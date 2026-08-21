# S12 — Writing Bug Reports

Companion to Section 12. Uses the bug-reporting and flake-triage skills. Prompts:
[`prompts/section-12-bugs.md`](../prompts/section-12-bugs.md).

## The flow
1. Run all three suites against the **broken** build; collect every failure with its
   framework, test, BUG-id, and artifact.
2. **Triage** each with the flake-triage skill: REAL BUG or FLAKY TEST? Re-run the uncertain
   ones. File nothing for flaky ones — name the fix instead.
3. **Report** the real ones with the bug-reporting skill.
4. **Review** each before filing.

## Report structure
- **Title** — specific, behavioural ("password shown in plaintext", not "login broken").
- **Environment** — build (SwiftUI/RN, broken/fixed), iOS version, Simulator, framework.
- **Steps** — numbered, reproducible cold.
- **Expected** / **Actual** — separate fields.
- **Severity** — Critical/High/Medium/Low + a one-line reason.
- **Evidence** — Maestro recording / Appium screenshot / `.xcresult`.

## Mobile richness
- Note whether the bug reproduces on **both** stacks or one — that points at the layer.
- Cross-confirmation: a bug failing in all three suites is strong evidence it's real; one that
  fails only in Appium/XCUITest and not Maestro is often the attribute-only BUG-001.

## The self-check that guards your reputation
"Could a developer reproduce this from the steps alone, on a clean Simulator?" If not, it's
not done. Reports live in a `bug-reports/` folder, ranked by severity.

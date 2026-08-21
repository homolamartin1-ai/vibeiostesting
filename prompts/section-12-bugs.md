# Section 12 — Finding & Reporting Bugs

> 📖 **Guide:** [s12 bug reports](../docs/s12-bug-reports.md) · uses **Skills 3 & 4**

You run the suites, triage each failure (real bug vs flaky), and turn the real ones into
developer-ready reports.

## Course reference
| Prompt | Used in clip |
|--------|-------------|
| Prompt 1 — Run and collect failures | **12, Clip 1** |
| Prompt 2 — Triage each failure | **12, Clip 2** |
| Prompt 3 — Write the reports | **12, Clip 3** |
| Prompt 4 — Review before filing | **12, Clip 4** |

---

## Prompt 1: Run the suites and collect failures
*Used in: Section 12, Clip 1*

```
Run the Maestro, Appium, and XCUITest suites against the broken build. List every
failure with the framework, the test, the BUG-id it targets, and the artifact
(recording / screenshot / .xcresult) for each.
```

## Prompt 2: Triage each failure
*Used in: Section 12, Clip 2*

```
Following skills/flake-triage.md, classify each failure as REAL BUG or FLAKY TEST. For any
you are unsure about, re-run it a few times first. For flaky ones, name the specific fix;
do not file a bug for those.
```

## Prompt 3: Turn real bugs into reports
*Used in: Section 12, Clip 3*

```
Following skills/bug-reporting.md, write a report for each confirmed real bug. Include the
build, framework, numbered steps, separate expected/actual, severity with a reason, and
the artifact. Note which bugs reproduce on both SwiftUI and React Native. Save them under
bug-reports/.
```

## Prompt 4: Review before filing
*Used in: Section 12, Clip 4*

```
Review each report against its own self-check: could a developer reproduce it from the
steps alone on a clean Simulator? Fix any report that fails the check, then give me the
final list ranked by severity.
```

**Expected:** a `bug-reports/` folder of reports a developer would act on — not "cannot
reproduce". A failing test is only half the job.

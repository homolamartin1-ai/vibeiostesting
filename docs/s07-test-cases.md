# S07 — From Exploration to Test Cases

Companion to Section 7. Uses the test-case-design skill. Prompts:
[`prompts/section-07-testcases.md`](../prompts/section-07-testcases.md).

## Goal
Turn `exploration-notes.md` into one **test matrix** (`test-cases.md`) that drives all three
frameworks — so the Section 11 comparison is apples-to-apples.

## The matrix columns
`ID · behavioural title · category · preconditions · steps · expected result · locator`

## Three categories per feature (non-negotiable)
- **Positive** — works with valid input.
- **Negative** — invalid input rejected: empty fields, wrong credentials, past expiry,
  non-numeric CVV, order below the minimum.
- **Edge** — boundaries: quantity 1 → 0, max length, keyboard covering a field.

If a feature is all happy-path, you missed the point — push the agent to add the negatives
and edges. That's where the bugs are.

## Two mobile-specific tags
- **Framework owner** — mark cases only Appium/XCUITest can assert (secure-entry, element
  type). Maestro can't read those.
- **Blocked-by** — mark checkout cases blocked by the dead Proceed button (BUG-011); they're
  verified on the fixed build.

## Known bugs → regressions
For every suspicious behaviour from Section 4, add a case asserting the **correct** behaviour,
tagged with its BUG-id — so it fails on broken and passes on fixed.

Output: `test-cases.md`, the single source Sections 8–10 build from.

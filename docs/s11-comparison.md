# S11 — Choosing a Framework

Companion to Section 11. Prompts:
[`prompts/section-11-compare.md`](../prompts/section-11-compare.md). Full table:
[`snippets/framework-cheatsheet.md`](../snippets/framework-cheatsheet.md).

## The payoff
You have the same suite in three frameworks. This section turns that into a decision you can
defend. Read the same login test three ways, measure them, and learn to choose.

## What to measure (put it in `test-cases.md`)
- **Setup effort** — Maestro lightest, Appium heaviest, XCUITest medium.
- **Run speed** — XCUITest fastest.
- **Bug coverage** — all three catch the behavioural bugs; Appium & XCUITest also catch
  BUG-001; none catch BUG-008 (colour → visual testing).

## How to choose (four questions)
1. App stack — native iOS-only → XCUITest; RN/Flutter or both stores → Maestro/Appium.
2. Who writes tests — non-coders → Maestro; coders → Appium/XCUITest.
3. Platforms — iOS + Android → Maestro/Appium; iOS-only, max speed → XCUITest.
4. Job market — broadest → Appium; Apple specialist → XCUITest; modern/startup → Maestro.

## The durable principle
Frameworks are fashion; the reasoning is permanent — every choice trades **reach vs depth**
and **simplicity vs power** against what your app and team make cheap. That judgment is the
most valuable thing this course gives you, and it applies to tools not even on the page.

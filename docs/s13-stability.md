# S13 — Stability & Debugging

Companion to Section 13. Prompts:
[`prompts/section-13-stability.md`](../prompts/section-13-stability.md).

## Kill flakiness (mobile's usual suspects)
- **Sleeps** → wait for the element to exist.
- **Taps during animations/transitions** → wait for the destination first.
- **Text/position locators where an id exists** → use the id.
- **State leaking between tests** → relaunch the app fresh each test.
- **Keyboard covering a field** → real app bug (should scroll) vs. test needs to dismiss/scroll.
  Triage decides which.

## The debuggers (all show you the accessibility tree)
- **Maestro Studio** — live element tree, try steps interactively.
- **Appium Inspector** — connect to a live session, see every element and attribute.
- **Xcode `.xcresult`** — a screenshot at each step; scrub it like a film strip.

## Regression against the fixed build
Install `swiftui-fixed` / `reactnative-fixed` and run all three suites. Everything should go
green — **including** the checkout tests that BUG-011 blocked on the broken build.

## Definition of done (both ends)
- Red on the broken build, for the right reasons.
- Green on the fixed build.

If a test is still red on fixed, decide: leftover **test** bug (fix the test) or a real
remaining **defect** (report it). Iterate to the two-sided state. A suite that only ever
passes proves nothing.

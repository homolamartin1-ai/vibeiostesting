# Section 11 — Three Frameworks Compared

> 📖 **Guide:** [s11 comparison](../docs/s11-comparison.md) · cheat sheet in [../snippets/framework-cheatsheet.md](../snippets/framework-cheatsheet.md)

The payoff. You now have the same login/cart/checkout suite in Maestro, Appium, and
XCUITest. Put them side by side and learn to choose.

## Course reference
| Prompt | Used in clip |
|--------|-------------|
| Prompt 1 — Same test, three ways | **11, Clip 1** |
| Prompt 2 — Measure and compare | **11, Clip 2** |
| Prompt 3 — Native vs cross-platform fit | **11, Clip 3** |
| Prompt 4 — Decision guide | **11, Clip 4** |

---

## Prompt 1: The same login test, three ways
*Used in: Section 11, Clip 1*

```
Show my login test in Maestro, Appium, and XCUITest side by side. Annotate each with how
it locates the email field, how it taps login, and how it asserts success. Point out what
each framework makes easy and what it makes verbose.
```

## Prompt 2: Measure and compare
*Used in: Section 11, Clip 2*

```
Run the full suite in each framework against the fixed build and record: total run time,
lines of setup/config, and which planted bugs each suite could and could not catch
(remember BUG-001 and BUG-008). Put it in a comparison table in test-cases.md.
```

## Prompt 3: Native vs cross-platform fit
*Used in: Section 11, Clip 3*

```
Given we ran every suite against both the SwiftUI and React Native builds, summarise which
framework fits which app and team, and why. Include the fact that Maestro and Appium are
cross-platform (they carry to Android) while XCUITest is iOS-only.
```

## Prompt 4: A decision guide
*Used in: Section 11, Clip 4*

```
Write a short decision guide: given a team's stack (native/RN/Flutter), skills (coders vs
not), CI budget, and job market, which of Maestro / Appium / XCUITest should they pick?
Save it as snippets/framework-cheatsheet.md.
```

**Expected:** you can read any of the three suites and justify a framework choice in an
interview — the most portable skill in this course.

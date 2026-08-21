# Maestro vs Appium vs XCUITest — Cheat Sheet & Decision Guide

The one-page reference for Section 11. Same suite, three frameworks — here is how they
compare and how to choose.

## At a glance

| | **Maestro** | **Appium** | **XCUITest** |
|--|-------------|------------|--------------|
| Language | YAML | Python / JS (WebDriver) | Swift |
| Style | Declarative flows | Imperative, page objects | Native, in-Xcode |
| Setup effort | Lightest (one install) | Heaviest (server + driver + caps) | Medium (ships in Xcode) |
| Run speed | Medium | Medium | **Fastest** |
| Build step | None | None | Xcode build |
| Cross-platform | ✅ iOS + Android | ✅ iOS + Android | ❌ iOS only |
| Reads attributes (secure-entry, type) | ❌ | ✅ | ✅ |
| Reads colour | ❌ | ❌ | ❌ (use visual testing) |
| Best for | Fast authoring, non-coders | Widest job market, big device matrices | All-Apple teams, fastest native tests |
| Job-posting frequency | Rising | Highest | Common (iOS roles) |

## What each catches in TechShop

- **All three** catch the behavioural bugs: auth validation, cart math, quantity floor,
  stale total, dead checkout button, missing order reference, wrong title, tab-bar gating.
- **Appium & XCUITest** also catch **BUG-001** (password not masked) via the field type.
  **Maestro cannot** — it can't read that attribute.
- **None** catch **BUG-008** (badge colour). That needs visual/snapshot testing — a
  different tool. Knowing this boundary is the point.

## How to choose

Ask four questions:

1. **What is the app's stack?**
   Native SwiftUI/UIKit and iOS-only → XCUITest is a great fit.
   React Native / Flutter, or you ship on both stores → a cross-platform tool (Maestro/Appium).

2. **Who writes the tests?**
   Non-coders / manual QA moving into automation → Maestro (readable YAML).
   A team comfortable in code → Appium or XCUITest.

3. **Which platforms must you cover?**
   iOS + Android from one suite → Maestro or Appium.
   iOS only, want maximum speed/depth → XCUITest.

4. **What is the job market you're aiming at?**
   Broadest employability → Appium (most-requested).
   Apple specialist track → XCUITest + Swift.
   Modern/startup momentum → Maestro.

## The durable principle

Frameworks are fashion; the reasoning is permanent. Every choice trades **reach vs depth**
and **simplicity vs power**, weighed against what your app and team make cheap or expensive.
Learn to run that trade and you can pick the right tool for any mobile project — even ones
that use a framework not on this page.

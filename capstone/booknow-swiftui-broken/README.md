# BookNow (SwiftUI - Broken)

Capstone project (Broken Build) for Section 15 of the iOS Testing course.

## Intentional Defects
- **BUG-001/002/003 (Login):** Bypasses validation, accepts invalid credentials.
- **BUG-004 (Pricing):** Discount calculation error (`/ 1000` instead of `/ 100`).
- **BUG-008 (Rooms):** "Available" badge renders in red.
- **BUG-009/010 (Dates/Guests):** Accepts checkout before checkin, accepts non-positive guests.
- **BUG-011 (Booking Total):** Total nights frozen at 1 regardless of date picker selection.
- **BUG-012/013/014 (Form Validation):** Unconditional form submission with empty/malformed inputs.
- **BUG-015/016 (Confirmation):** Missing booking details summary and reference number.

## How to run on Simulator

```bash
# Generate the Xcode project
xcodegen generate

# Open in Xcode or build and run
open BookNow.xcodeproj
```

## 📱 Running on iOS 26 / 27 (Xcode 26+)

iOS 26 began **enforcing** the UIScene lifecycle. An app that does not declare a scene
manifest in its `Info.plist` now **crashes at launch** on iOS 26/27 simulators with
`EXC_BREAKPOINT (SIGTRAP)` in `…UIApplicationEvaluateRuntimeIssueForNoSceneLifecycleAdoption…`.
This is an OS/SDK requirement — **not** one of the planted bugs.

This project already ships an explicit `BookNow/Info.plist` declaring
`UIApplicationSceneManifest` → `UIApplicationSupportsMultipleScenes`, so it launches
correctly on **iOS 17 through 27**. Just run `xcodegen generate` and Run (⌘R).

*If you hit this crash in your own project:* add a scene manifest to your `Info.plist`
(or, as a quick workaround, run on an **iOS 18.x** simulator, which does not enforce it yet).

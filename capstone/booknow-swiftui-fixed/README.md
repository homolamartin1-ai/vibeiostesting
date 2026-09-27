# BookNow (SwiftUI - Fixed)

Capstone project for Section 15 of the iOS Testing course.

## How to run on Simulator

### 1. From Terminal:
```bash
# Generate the Xcode project
xcodegen generate

# Open in Xcode or build and run
open BookNow.xcodeproj
```

### 2. Quick Command Line Build & Run:
```bash
# Build
xcodebuild -project BookNow.xcodeproj -scheme BookNow -destination "platform=iOS Simulator,name=iPhone 17" -derivedDataPath /tmp/BookNowDerivedData build

# Install and Launch
xcrun simctl install booted /tmp/BookNowDerivedData/Build/Products/Debug-iphonesimulator/BookNow.app
xcrun simctl launch booted com.booknow.ios
```

## Demo Credentials
- **Email:** `guest@booknow.com`
- **Password:** `stay2026`

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

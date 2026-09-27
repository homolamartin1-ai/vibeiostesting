# TechShop iOS — SwiftUI (Fixed)

The **clean** native SwiftUI build of TechShop. All 17 planted bugs are corrected. Used in
Section 13 for the regression / verification pass — your suite should go green here.

## Generate the Xcode project & run

```bash
brew install xcodegen        # one time
xcodegen generate
open TechShop.xcodeproj       # pick an iPhone Simulator, press Run (⌘R)
```

**Credentials:** demo@techshop.com / password123

Every fix is marked with a `FIXED (BUG-0xx)` comment. Diff against `../swiftui-broken`.

## 📱 Running on iOS 26 / 27 (Xcode 26+)

iOS 26 began **enforcing** the UIScene lifecycle. An app that does not declare a scene
manifest in its `Info.plist` now **crashes at launch** on iOS 26/27 simulators with
`EXC_BREAKPOINT (SIGTRAP)` in `…UIApplicationEvaluateRuntimeIssueForNoSceneLifecycleAdoption…`.
This is an OS/SDK requirement — **not** one of the planted bugs.

This project already ships an explicit `TechShop/Info.plist` declaring
`UIApplicationSceneManifest` → `UIApplicationSupportsMultipleScenes`, so it launches
correctly on **iOS 17 through 27**. Just run `xcodegen generate` and Run (⌘R).

*If you hit this crash in your own project:* add a scene manifest to your `Info.plist`
(or, as a quick workaround, run on an **iOS 18.x** simulator, which does not enforce it yet).

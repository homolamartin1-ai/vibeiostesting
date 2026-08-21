# Setup 6 — XCUITest (Already in Xcode)
**Section 3 · Clip 6** · ~3 min · Nothing to install now

XCUITest ships **inside Xcode** — there is nothing to install. This guide is a placeholder
so you know the third framework is already on your machine.

When you build the XCUITest suite in **Section 10**, you will:
1. Generate the TechShop app project (`xcodegen generate` in `techshop/swiftui-broken`).
2. In Xcode: **File → New → Target → UI Testing Bundle**, named `TechShopUITests`.
3. Drop in the Swift files you write, and set the target's **Target Application** to `TechShop`.
4. Run with **Cmd-U**, or `xcodebuild test` (see
   [`snippets/xcuitest-commands.sh`](../snippets/xcuitest-commands.sh)).

The tests attach to the app by bundle id `com.techshop.ios`, so the same suite runs against
the SwiftUI and the React Native build.

That is it for setup — nothing to do here until Section 10.

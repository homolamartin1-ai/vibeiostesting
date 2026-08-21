# Section 3 — Setup

> 📖 **Guides:** [setup-01…07](../docs/README.md) · CLI in [../snippets/](../snippets/)

You drive setup through the agent where you can. Most of this is one-time.

## Course reference
| Prompt | Used in clip |
|--------|-------------|
| Prompt 1 — Verify the toolchain | **3, Clip 2–6** |
| Prompt 2 — Run both TechShop apps | **3, Clip 8** |
| Prompt 3 — Connect the mobile MCP | **3, Clip 7** |
| Prompt 4 — First vibe check | **3, Clip 8** |

---

## Prompt 1: Verify the toolchain
*Used in: Section 3*

```
Check my machine is ready for iOS mobile testing and tell me exactly what's missing:
- Xcode + command line tools (xcodebuild -version, xcrun simctl list devices)
- Node (node -v) and Homebrew
- Maestro (maestro -v), Appium (appium -v) + the xcuitest driver
  (appium driver list), and Python + pip
For anything missing, give me the exact install command. Do not install without asking.
```

## Prompt 2: Run both TechShop apps on the Simulator
*Used in: Section 3, Clip 8*

```
Boot an iPhone 15 Simulator. Then:
1. Build and run techshop/reactnative-broken with Expo (npx expo start --ios).
2. Separately, generate the Xcode project for techshop/swiftui-broken
   (xcodegen generate) and run it on the same Simulator.
Confirm both install as bundle id com.techshop.ios and show the login screen.
```

## Prompt 3: Connect the mobile MCP
*Used in: Section 3, Clip 7*

```
Set up the mobile MCP server in Antigravity so you can drive the iOS Simulator:
1. Find (or create) Antigravity's MCP config file and show me the path.
2. Add the mobile MCP server entry WITHOUT touching my other servers.
3. Tell me if I need to reload/restart Antigravity, then verify by taking a screenshot
   of the booted Simulator and describing what you see.
```

**The one manual beat:** Antigravity usually needs a reload to load a new MCP server. The
agent will tell you when.

## Prompt 4: First vibe check
*Used in: Section 3, Clip 8*

```
Using the mobile MCP, open the running TechShop app on the Simulator, describe the login
screen, and read back the accessibility identifiers you can see on it.
```

**Expected:** the agent drives the Simulator and reports what it sees — no test written
yet. That is the whole idea: exploration before a single test exists.

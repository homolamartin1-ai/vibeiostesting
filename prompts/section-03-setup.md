# Section 3 — Setup

> 📖 **Guides:** [setup-01…07](../docs/README.md) · CLI in [../snippets/](../snippets/)

You drive setup through the agent where you can. Most of this is one-time.

## Course reference
| Prompt | Used in clip |
|--------|-------------|
| Prompt 1 — Verify the toolchain | **3, Clip 7** (first — confirm everything installed) |
| Prompt 3 — Connect the mobile MCP | **3, Clip 7** (then set up the MCP) |
| Prompt 2 — Run both TechShop apps | **3, Clip 8** |
| Prompt 4 — First vibe check | **3, Clip 8** |

---

## Prompt 1: Verify the toolchain
*Used in: Section 3, Clip 7 — run this first, before connecting the MCP, to confirm everything installed*

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
First, run `xcrun simctl list devices available` and pick ONE installed iPhone Simulator
from the list (e.g. the newest iPhone shown). Tell me which one you chose, and use that
same Simulator for everything from here on — do not assume a specific model like "iPhone 16".

Then, on that Simulator:
1. Boot it.
2. Build and run techshop/reactnative-broken with Expo (npx expo start --ios).
3. Separately, generate the Xcode project for techshop/swiftui-broken
   (xcodegen generate) and run it on the same Simulator.
Confirm both install as bundle id com.techshop.ios and show the login screen.
```

> **Why:** the available iPhone models change with each Xcode version (a hardcoded
> "iPhone 16" may not exist). Letting the agent pick from the installed list — and reusing
> that one device throughout the course — keeps every later command working on your machine.

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

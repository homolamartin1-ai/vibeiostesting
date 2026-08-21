# Setup 1 — Install Xcode & the Simulator
**Section 3 · Clip 1** · ~15 min (mostly download) · One-time

You need a **Mac**. iOS Simulators only run on macOS — this is true for all three
frameworks, so there is no way around it.

## 1. Install Xcode
Install **Xcode** from the Mac App Store. It is large (several GB) — start it now.

Then open Xcode once so it can install its extra components, and accept the license.

## 2. Command line tools + license (terminal)
```bash
xcode-select --install          # if not already installed
sudo xcodebuild -license accept
xcodebuild -version             # should print a version, e.g. Xcode 15.x
```

## 3. Confirm the Simulator works
```bash
xcrun simctl list devices       # lists available iPhone Simulators
xcrun simctl boot "iPhone 15"   # boot one (name must match your list)
open -a Simulator               # open the Simulator window
```
✅ **Working:** an iPhone Simulator appears on screen.

## Troubleshooting
| Symptom | Fix |
|---|---|
| `xcodebuild` requires Xcode | You have only the CLI tools. Install full Xcode from the App Store. |
| "iPhone 15" not found | Run `xcrun simctl list devices` and use a name from your list. |
| License errors | Re-run `sudo xcodebuild -license accept`. |
| Simulator won't boot | `xcrun simctl shutdown all` then boot again; or reboot the Mac. |

You never touch most of this again. From here, the Simulator just works.

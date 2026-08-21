# Setup 1 — Xcode & the Simulator
**Section 3 · Clip 1** · One-time

You need a **Mac**. iOS Simulators only run on macOS — this is true for all three
frameworks, so there is no way around it.

---

## Step 1 — Check if you already have Xcode (do this FIRST)

Don't install anything yet. Many Macs already have Xcode. Open **Terminal** and run:

```bash
xcodebuild -version
```

- **If it prints a version** (e.g. `Xcode 16.2`) → Xcode is already installed. Check the
  number against **"Which version you need"** below. If it's new enough, **skip the install
  entirely** and jump to **Step 3 — Confirm the Simulator works**.
- **If it says** `xcode-select: error: tool 'xcodebuild' requires Xcode…` or
  `command not found` → you have only the *command line tools*, not the full Xcode app. You
  need full Xcode — go to Step 2.

### Is Xcode installed at all? (the reliable, path-independent check)
A failing `xcodebuild -version` does **not** always mean Xcode is missing — Xcode can be
installed while your Mac is still pointed at the Command Line Tools (see Troubleshooting).
To check whether the Xcode app exists **anywhere** on your Mac, regardless of where it
lives, ask Spotlight for it by its identity:

```bash
mdfind "kMDItemCFBundleIdentifier == 'com.apple.dt.Xcode'"
```

- **Prints a path** (e.g. `/Applications/Xcode.app`) → Xcode **is** installed. If
  `xcodebuild -version` still errors, you only need to point your Mac at it — see the
  Troubleshooting row for `xcode-select -s`.
- **Prints nothing** → Xcode is not installed → go to Step 2.

> Note: `xcode-select -p` shows the *active* developer directory, **not** whether Xcode is
> installed — it can read `/Library/Developer/CommandLineTools` even when Xcode is present.
> Use the `mdfind` command above to know for sure.

### Which version you need
- **Xcode 15 or newer** is required (the course targets **iOS 17+**).
- **Xcode 16 or the latest** is recommended.
- If `xcodebuild -version` shows **older than 15**, update Xcode from the App Store before
  continuing.

---

## Step 2 — Install Xcode (only if Step 1 said you don't have it, or it's too old)

1. Open the **Mac App Store**, search **Xcode**, click **Get / Install**. It is large
   (several GB) — start it now and let it download.
2. When it finishes, **open Xcode once** so it can install its extra components.
3. Accept the license when prompted.

---

## Step 3 — Command line tools + license (Terminal)

```bash
xcode-select --install          # if not already installed (safe to run — it just says so)
sudo xcodebuild -license accept
xcodebuild -version             # confirm: Xcode 15.x or newer
```

---

## Step 4 — Confirm the Simulator works

```bash
xcrun simctl list devices       # lists the iPhone Simulators you have
xcrun simctl boot "iPhone 15"   # boot one (use a name from the list above)
open -a Simulator               # open the Simulator window
```
✅ **Working:** an iPhone Simulator appears on screen.

---

## Troubleshooting
| Symptom | Fix |
|---|---|
| `xcodebuild` requires Xcode | You have only the CLI tools. Install full Xcode from the App Store (Step 2). |
| Installed Xcode but still get `…requires Xcode, but active developer directory '/Library/Developer/CommandLineTools' is a command line tools instance` | Xcode is installed but your Mac still points at the CLI tools. Point it at Xcode: `sudo xcode-select -s /Applications/Xcode.app/Contents/Developer` then `sudo xcodebuild -license accept` and re-run `xcodebuild -version`. |
| Xcode version is older than 15 | Update Xcode from the App Store. |
| "iPhone 15" not found | Run `xcrun simctl list devices` and use a name from your list. |
| License errors | Re-run `sudo xcodebuild -license accept`. |
| Simulator won't boot | `xcrun simctl shutdown all` then boot again; or reboot the Mac. |

You never touch most of this again. From here, the Simulator just works.

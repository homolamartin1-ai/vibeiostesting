# Setup 1 — Install Xcode & the Simulator
**Section 3 · Clip 1** · One-time

You need a **Mac**. iOS Simulators only run on macOS — this is true for all three
frameworks, so there is no way around it.

Do the steps in order. Each one tells you where to go next.

---

## Step 1 — Is Xcode already installed? Check FIRST

Don't install anything yet. Open **Terminal** and run:

```bash
mdfind "kMDItemCFBundleIdentifier == 'com.apple.dt.Xcode'"
```

- **It prints a path** (e.g. `/Applications/Xcode.app`) → Xcode is already installed.
  **Skip Step 2** and go to **Step 3**.
- **It prints nothing** → Xcode is not installed. Go to **Step 2**.

> Why this command? It asks Spotlight for the Xcode app by its identity, so it finds Xcode
> **wherever** it lives. Don't use `xcode-select -p` for this — that shows the *active*
> developer directory, not whether Xcode is installed (it can read
> `/Library/Developer/CommandLineTools` even when Xcode is present).

---

## Step 2 — Install Xcode (only if Step 1 printed nothing)

1. Open the **Mac App Store**, search **Xcode**, click **Get / Install**. It's several GB —
   start it now and let it download.
2. When it finishes, **open Xcode once** so it can install its extra components.
3. Accept the license if it prompts you.

---

## Step 3 — Confirm it's installed, then check the version

1. Check again that it's really there:
   ```bash
   mdfind "kMDItemCFBundleIdentifier == 'com.apple.dt.Xcode'"
   ```
   You should now see a path like `/Applications/Xcode.app`.

2. Check the version:
   ```bash
   xcodebuild -version
   ```
   - **Prints a version** (e.g. `Xcode 26.x`, or `Xcode 16.x` / `17.x`) → you're set. Go to **Step 5**.
   - **Prints something older than Xcode 15** → update Xcode from the App Store first (see below).
   - **Errors** with `…requires Xcode, but active developer directory
     '/Library/Developer/CommandLineTools' is a command line tools instance` → Xcode is
     installed but your Mac is still pointed at the Command Line Tools. **Repair it in
     Step 4.**

### Which version you need
- The course only needs **iOS 17+**, supported by **Xcode 15 and newer** — so any current
  Xcode is fine.
- Recent Xcode uses **year-based version numbers** (e.g. **Xcode 26**). A bigger number just
  means newer — Xcode 16, 17, and 26 all work. Update from the App Store only if yours
  somehow predates Xcode 15.

---

## Step 4 — Repair: point your Mac at Xcode (only if Step 3 errored)

Run these in Terminal (the `sudo` ones ask for your Mac password — type it and press Enter;
it won't show as you type):

```bash
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer
sudo xcodebuild -license accept
xcodebuild -version
```

**✅ Now** `xcodebuild -version` should print the version instead of the error.

If Xcode still needs to finish setting up, also run:
```bash
xcodebuild -runFirstLaunch
```

---

## Step 5 — Install a Simulator runtime, then boot it

Recent Xcode does **not** include the iOS Simulator by default — you download it once. If
`xcrun simctl list runtimes` shows an empty `== Runtimes ==`, you need this step.

1. Download the iOS Simulator runtime (several GB — let it finish):
   ```bash
   xcodebuild -downloadPlatform iOS
   ```
   *(GUI alternative: Xcode → Settings (⌘,) → **Platforms** tab → click **Get** next to iOS.)*

2. See the devices you now have:
   ```bash
   xcrun simctl list devices available
   ```
   You'll see iPhones under an iOS version. **Device names depend on your Xcode version** —
   newer Xcode lists **iPhone 16 / iPhone 17**, not iPhone 15. Pick any one from *your* list.

3. Boot a device that's actually in your list, then open the Simulator:
   ```bash
   xcrun simctl boot "iPhone 16"   # use a name from YOUR list above
   open -a Simulator
   ```
✅ **Working:** an iPhone Simulator appears on screen. Setup 1 is done.

> Throughout the course, wherever a command says `iPhone 15`, use whatever iPhone your
> `simctl list devices available` shows instead — the exact model doesn't matter.

---

## Troubleshooting
| Symptom | Fix |
|---|---|
| `xcodebuild -version` errors with `…active developer directory '/Library/Developer/CommandLineTools'…` | Xcode is installed but your Mac points at the CLI tools. Do **Step 4**. |
| Xcode version is older than 15 | Update Xcode from the App Store (any current Xcode — 16, 17, or year-based like 26 — works). |
| `mdfind` prints nothing but you think Xcode is installed | It may still be downloading, or Spotlight is indexing. Wait, then re-run. Or check the App Store for the install progress. |
| `== Devices ==` is empty / `== Runtimes ==` is empty | No Simulator runtime installed. Run `xcodebuild -downloadPlatform iOS` (Step 5). |
| `Invalid device or device pair: iPhone 15` | That model doesn't exist in your Xcode. Run `xcrun simctl list devices available` and boot a name from the list (e.g. `iPhone 16`). |
| Simulator won't boot | `xcrun simctl shutdown all` then boot again; or reboot the Mac. |

You never touch most of this again. From here, the Simulator just works.

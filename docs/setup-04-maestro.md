# Setup 4 — Install Maestro
**Section 3 · Clip 4** · ~5 min · One-time

Maestro is the friendliest framework and the fastest win.

## Step 1 — Do you already have Maestro? Check first
```bash
maestro -v
```
- **Prints a version** → you already have Maestro. **Skip Step 2** and go to "Verify it
  sees the Simulator".
- **`command not found: maestro`** → install it (Step 2).

## Step 2 — Install Maestro
The installer runs through **curl**, which is built into macOS. Confirm curl is there, then
install:
```bash
curl --version                      # macOS includes curl — this should print a version
curl -fsSL "https://get.maestro.mobile.dev" | bash
```
Restart your terminal (or `source` your shell profile) so `maestro` is on your PATH, then
confirm:
```bash
maestro -v                          # prints the version
```

## Verify it sees the Simulator
Boot a Simulator with a TechShop build installed (see [setup-04 run notes](../snippets/run-techshop.sh)), then:
```bash
xcrun simctl list devices booted    # confirm a Simulator is booted
maestro studio                      # opens the interactive inspector
```
Maestro Studio should show the app's elements. We use Studio for debugging in Section 13.

## Troubleshooting
| Symptom | Fix |
|---|---|
| `maestro: command not found` | Restart the terminal; ensure `~/.maestro/bin` is on PATH. |
| `curl: command not found` | Very rare on macOS. Install with `brew install curl`, or reinstall the Command Line Tools (`xcode-select --install`). |
| Studio shows no device | Boot a Simulator first (`xcrun simctl boot "iPhone 16"`). |
| Flow can't find an element | The `appId:` must be `com.techshop.ios`; check the element's id in Studio. |

CLI reference: [`snippets/maestro-commands.sh`](../snippets/maestro-commands.sh).

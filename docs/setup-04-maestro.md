# Setup 4 — Install Maestro
**Section 3 · Clip 4** · ~5 min · One-time

Maestro is the friendliest framework and the fastest win.

## Step 1 — Do you already have Maestro? Check first
```bash
maestro -v
```
- **Prints a version** → you already have Maestro. **Skip to Step 4** and confirm Java.
- **`command not found: maestro`** → install it (Step 2).

## Step 2 — Install Maestro
The installer runs through **curl**, which is built into macOS. Confirm curl is there, then
install:
```bash
curl --version                      # macOS includes curl — this should print a version
curl -fsSL "https://get.maestro.mobile.dev" | bash
```
Make `maestro` available on your PATH — **open a new terminal**, or run this in the current
one:
```bash
export PATH="$PATH":"$HOME/.maestro/bin"
```

## Step 3 — Maestro needs Java (install it if missing)
Maestro runs on the **Java runtime**, so you need a JDK. Check:
```bash
java -version
```
- **Prints a version** → good, go to Step 4.
- **`Unable to locate a Java Runtime`** → install a JDK with Homebrew (Temurin registers
  cleanly with macOS):
  ```bash
  brew install --cask temurin       # may ask for your Mac password
  ```
  Then re-run `java -version` to confirm.

## Step 4 — Confirm Maestro works
```bash
maestro -v                          # now prints the version
```

## Verify it sees the Simulator
Boot a Simulator with a TechShop build installed (see [run notes](../snippets/run-techshop.sh)),
then:
```bash
xcrun simctl list devices booted    # confirm a Simulator is booted
maestro studio                      # opens the interactive inspector
```
Maestro Studio should show the app's elements. We use Studio for debugging in Section 13.

## Troubleshooting
| Symptom | Fix |
|---|---|
| `Unable to locate a Java Runtime` | Maestro needs Java. Install a JDK: `brew install --cask temurin`, then re-run. |
| `maestro: command not found` (after install) | Open a new terminal, or run `export PATH="$PATH":"$HOME/.maestro/bin"`. Ensure `~/.maestro/bin` is on your PATH. |
| `curl: command not found` | Very rare on macOS. Install with `brew install curl`, or reinstall the Command Line Tools (`xcode-select --install`). |
| Studio shows no device | Boot a Simulator first (`xcrun simctl boot "iPhone 16"`). |
| Flow can't find an element | The `appId:` must be `com.techshop.ios`; check the element's id in Studio. |

CLI reference: [`snippets/maestro-commands.sh`](../snippets/maestro-commands.sh).

# Setup 4 — Install Maestro
**Section 3 · Clip 4** · ~5 min · One-time

Maestro is the friendliest framework and the fastest win. One install.

```bash
curl -fsSL "https://get.maestro.mobile.dev" | bash
```

Restart your terminal (or `source` your shell profile) so `maestro` is on your PATH, then:
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
| Studio shows no device | Boot a Simulator first (`xcrun simctl boot "iPhone 15"`). |
| Flow can't find an element | The `appId:` must be `com.techshop.ios`; check the element's id in Studio. |

CLI reference: [`snippets/maestro-commands.sh`](../snippets/maestro-commands.sh).

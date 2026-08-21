# Snippets — ready-to-use configs & CLI reference

Copy-paste material you cannot pause a video to type. Each maps to a lecture.

| File | Used in | What it is |
|------|---------|-----------|
| `setup-commands.sh` | Section 3 | Every install command, in order |
| `mobile-mcp-config.json` | Section 3.7 | The mobile MCP entry for Antigravity |
| `run-techshop.sh` | Section 3.8 | Boot the Simulator and run either build |
| `maestro-commands.sh` | Section 8 | Maestro CLI reference |
| `appium-commands.sh` | Section 9 | Appium server + pytest reference |
| `pytest.ini` | Section 9 | Drop into your Appium folder |
| `xcuitest-commands.sh` | Section 10 | xcodebuild test reference |
| `framework-cheatsheet.md` | Section 11 | Maestro vs Appium vs XCUITest — the decision guide |
| `env-setup.sh` | Sections 3, 8–14 | Export TEST_EMAIL / TEST_PASSWORD |

> Credentials always come from the environment. Copy `env-setup.sh`, fill it in, and
> `source` it — never hardcode credentials in a flow, test, or commit.

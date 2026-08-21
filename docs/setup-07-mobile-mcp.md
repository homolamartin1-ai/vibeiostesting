# Setup 7 — Connect the Mobile MCP
**Section 3 · Clip 7** · ~10 min · One-time · *The step most likely to need troubleshooting.*

This is what lets the AI agent **drive the iOS Simulator** — tap, type, read the screen,
report what it sees. It is the mobile equivalent of Playwright MCP for the web.

## What MCP is (one paragraph)
**MCP** (Model Context Protocol) is a standard way to give an agent extra tools. The
**mobile MCP server** is one of those tools: once connected, the agent can operate your
booted Simulator live, without writing a test first. Antigravity is the *client*; the
mobile MCP is the *tool provider*. Connect them once.

## The easy way: let the agent do it
Use **Prompt 3** in [`prompts/section-03-setup.md`](../prompts/section-03-setup.md). It tells
the agent to find Antigravity's MCP config, add the `mobile` server without touching your
other servers, tell you whether to reload, and verify by screenshotting the Simulator.

> **The one manual beat:** after the config is written, Antigravity needs a **reload/restart**
> to load a new MCP server. The agent will tell you when.

## The manual way (fallback)
Add this to Antigravity's MCP config (alongside any existing servers — don't replace the
whole block). See [`snippets/mobile-mcp-config.json`](../snippets/mobile-mcp-config.json):
```json
{
  "mcpServers": {
    "mobile": { "command": "npx", "args": ["-y", "@mobilenext/mobile-mcp@latest"] }
  }
}
```
Then fully quit and reopen Antigravity.

## Verify
Boot a Simulator with TechShop installed, then in the agent chat:
```
Using the mobile MCP, take a screenshot of the Simulator and describe the screen.
```
✅ **Working:** the agent describes the TechShop login screen and can read its identifiers.

## Troubleshooting
| Symptom | Cause | Fix |
|---|---|---|
| Agent says it has no mobile tools | Server not loaded | Restart Antigravity **fully**; confirm the config saved. |
| Config "invalid JSON" | Comma/bracket error | Paste the file into the chat and ask the agent to fix it. |
| Agent sees no device | No Simulator booted | `xcrun simctl boot "iPhone 16"` and `open -a Simulator`. |
| `npx` not found | Node not on PATH | See [setup-02](setup-02-node-antigravity.md). |
| Works, then stops after restart | Config written to the wrong file | Ask the agent to print the exact config path it used. |

Once it works, you never touch it again. From Section 4 on, the agent simply *has* a device.

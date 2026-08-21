# Setup 2 — Install Node & Antigravity
**Section 3 · Clip 2** · ~5 min · One-time

## Node
Node powers the React Native build and the Appium tests.

```bash
# Homebrew first (if you don't have it):
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
brew install node
node -v && npm -v      # verify
```

Node LTS (18+) is fine.

## Antigravity
Antigravity is the agentic IDE where the AI agent lives and where the mobile MCP connects.

1. Download and install **Antigravity** from its site.
2. Open it and sign in.
3. Confirm the agent chat opens.

That is all for now — we connect the mobile MCP in
[setup-07-mobile-mcp.md](setup-07-mobile-mcp.md).

> The workflow is tool-agnostic: Cursor, Windsurf, or VS Code + Copilot work too. We show
> Antigravity on screen; the skill transfers.

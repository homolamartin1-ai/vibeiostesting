# Setup 2 — Install Node & Antigravity IDE
**Section 3 · Clip 2** · ~5 min · One-time

## Node
Node powers the React Native build and the Appium tests.

### Step 1 — Do you already have Homebrew? Check first
Homebrew is the package manager we use to install Node. Check whether it's already there:

```bash
brew --version
```

- **Prints a version** (e.g. `Homebrew 4.x`) → you already have it. **Skip the Homebrew
  install** and go straight to Step 2.
- **`command not found: brew`** → install Homebrew:
  ```bash
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  ```
  When it finishes, follow any **"Next steps"** it prints to add `brew` to your PATH, then
  re-run `brew --version` to confirm.

### Step 2 — Do you already have Node? Check first
```bash
node -v
```
- **Prints a version** (e.g. `v20.x`) → you already have Node. **Skip the install** —
  you're done with Node.
- **`command not found: node`** → install it with Homebrew:
  ```bash
  brew install node
  node -v && npm -v      # verify
  ```

Node LTS (18+) is fine.

## Antigravity IDE
Antigravity IDE is the agentic IDE where the AI agent lives and where the mobile MCP
connects.

1. Download and install **Antigravity IDE** from its site.
2. Open it and sign in.
3. Confirm the agent chat opens.

That is all for now — we connect the mobile MCP in
[setup-07-mobile-mcp.md](setup-07-mobile-mcp.md).

> The workflow is tool-agnostic: Cursor, Windsurf, or VS Code + Copilot work too. We show
> Antigravity IDE on screen; the skill transfers.

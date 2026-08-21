# Setup 3 — Fork & Clone the Course Repo
**Section 3 · Clip 3** · ~2 min · One-time

**Fork** the repo (top-right **Fork** button) so you have your own copy to commit to and
push from — you need that for CI in Section 14. Then clone your fork:

```bash
git clone git@github.com:<your-username>/vibeiostesting.git
cd vibeiostesting
```

## What's inside
- `techshop/` — the app under test, in four builds (SwiftUI + React Native, broken + fixed)
- `techshop/requirements.md` — the spec (your Section 4 coverage check)
- `prompts/` — the agent prompts you use every section
- `docs/` — these guides
- `snippets/` — copy-paste configs and CLI reference
- `skills/`, `maestro/`, `appium/`, `xcuitest/`, `.github/workflows/` — **empty**; you build
  them yourself during the course

## Credentials
Copy the env template, fill it in, and source it — never hardcode credentials:
```bash
cp snippets/env-setup.sh .env-local   # then edit .env-local
source .env-local
```
`.env` files are gitignored. Test credentials: `demo@techshop.com` / `password123`.

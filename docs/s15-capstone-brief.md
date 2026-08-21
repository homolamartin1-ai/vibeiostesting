# S15 — Capstone Brief: BookNow iOS

Companion to Section 15. App in [`capstone/`](../capstone/). Prompts:
[`prompts/section-15-capstone.md`](../prompts/section-15-capstone.md).

## The app
**BookNow** — a hotel booking app you have not seen: login → search results → booking form →
confirmation. Shipped in SwiftUI and React Native, broken + fixed. **The bug count is not
disclosed.** Finding them is the job.

## Your checklist (the full workflow, on your own)
1. **Explore** with the mobile MCP → `exploration-notes.md`.
2. **Design** the matrix with your test-case-design skill.
3. **Build** the suite — one framework for a focused run, all three for the full challenge.
4. **Run** against the broken build.
5. **Triage** failures with your flake-triage skill.
6. **Report** the real bugs with your bug-reporting skill.
7. **Verify** against the fixed build (regression pass).
8. **Ship** to CI.

## Self-check (process, not bug count)
- Notes name every screen's elements and flag any without an id.
- Matrix has positive, negative, and edge per feature.
- Suite fails on broken for real reasons, goes green on fixed.
- Each report is reproducible cold from the steps alone.

Only **after** you finish, compare your findings to `capstone/BUGS.md`. The learning is in
the finding, not the checking. This is the job description — go do it.

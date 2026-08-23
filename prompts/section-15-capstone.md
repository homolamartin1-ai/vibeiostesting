# Section 15 — Capstone Project: BookNow iOS

> 📖 **Guide:** [s15 capstone brief](../docs/s15-capstone-brief.md) · app in [../capstone/](../capstone/)

Your independent project. A new app you have not seen — **BookNow**, a hotel booking app
(login → search results → booking form → confirmation) — shipped in SwiftUI and React
Native, broken + fixed. The **bug count is not disclosed**.

**No prompts are provided for this section — on purpose.** You have written every prompt you
need across Sections 4–14, and you have four skills that carry your standards. The capstone is
where you drive the whole workflow yourself, in your own words, making the judgment calls. If
you find yourself wanting a prompt, look back at the section that covered that step.

## Your task checklist
1. **Explore** BookNow with the mobile MCP; write `exploration-notes.md`.
2. **Design** the test matrix with the test-case-design skill.
3. **Build** the suite in at least one framework (all three for the full challenge) with
   the test-authoring skill.
4. **Run** it against the broken build; **triage** failures with the flake-triage skill.
5. **Report** the real bugs with the bug-reporting skill.
6. **Verify** against the fixed build (regression pass).
7. **Ship** it to CI.

## How to know you did it right (self-check)
- Your exploration notes name every screen's elements and flag any control with no id.
- Your matrix has positive, negative, and edge cases per feature.
- Your suite catches the planted bugs and goes green on the fixed build.
- Your bug reports would let a developer reproduce each issue on a clean Simulator.
- Compare your bug list to `capstone/BUGS.md` **only after** you finish.

**Expected:** you did the whole cycle on an unseen app, independently. That is the job.

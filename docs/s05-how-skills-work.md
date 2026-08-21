# S05 — How Skills Work

Companion to Section 5 (the centerpiece). Prompts:
[`prompts/section-05-skills.md`](../prompts/section-05-skills.md).

## What a skill is
A markdown file the agent reads **before** a task, so it applies your standards every time
instead of improvising per prompt. Same conventions, same quality — regardless of how you
phrased the request that day.

## Why it matters more on this course
You write tests in **three frameworks**. Without a skill, the agent makes three different
sets of choices about what "good" means. With the authoring skill, your standards hold
across Maestro, Appium, and XCUITest — one rulebook, three dialects.

## The four skills you build (into `skills/`)
1. **test-case-design.md** — feature + notes → a three-category test matrix.
2. **test-authoring.md** — test cases → clean tests, with universal rules plus a short
   per-framework section. Includes the honesty rule: if a framework can't assert something
   (Maestro can't read secure-entry or colour), say so and defer the case.
3. **bug-reporting.md** — a failure + artifact → a developer-ready report.
4. **flake-triage.md** — a failure → REAL BUG or FLAKY TEST, with the fix.

## They are living documents
Your first drafts will have gaps. You fix them when the agent hits a wall on a real test —
and we do exactly that on camera in Section 8. Fix the *skill*, not just the output, and you
fix every test it writes after. Save these; carry them to your next job.

# S04 — Exploring TechShop with the Agent

Companion to Section 4. Prompts: [`prompts/section-04-exploration.md`](../prompts/section-04-exploration.md).

## The idea
Explore **before** you test. The agent drives the Simulator via the mobile MCP; you watch,
judge, and capture. Several "odd" behaviours you record here are the planted bugs — but you
don't call them bugs yet, you just note the mismatch with the spec.

## What to produce
A file `exploration-notes.md` with a section per screen containing:
- every interactive element and its **accessibility identifier** (flag any with none)
- the flows you tried and what actually happened
- anything that contradicts [`techshop/requirements.md`](../techshop/requirements.md)

## Flows to explore
- **Login:** valid, empty submit, wrong password.
- **Catalog:** the out-of-stock item, long product names.
- **Cart:** add item, change quantity (try below 1), apply a discount code, check the total.
- **Checkout:** tap Proceed (does anything happen?), try an empty submit.

## Why identifiers matter here
The identifiers you record are what your tests will locate against in Sections 8–10. If the
agent reports a control with **no** identifier, that is a testability finding — you cannot
write a stable test for it until it has one.

## Output → next step
`exploration-notes.md` plus a coverage list (requirements exercised vs. not) is the input to
the test-case-design skill in Section 7.

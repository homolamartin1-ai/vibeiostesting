# S06 — The iOS Accessibility Tree

Companion to Section 6. Prompts:
[`prompts/section-06-accessibility.md`](../prompts/section-06-accessibility.md).

## The one concept everything stands on
When iOS draws a screen it also builds an invisible tree describing every element — type,
label, and **accessibility identifier**. Originally built for VoiceOver; it is also exactly
what every test framework and the mobile MCP read to locate elements. Understand it once and
all three frameworks stop being mysterious.

## Locating elements — best to worst
1. **Accessibility identifier** — invisible, developer-set, stable. Always prefer it.
   SwiftUI `accessibilityIdentifier("login-email")` / React Native `testID="login-email"`.
2. **Visible text / label** — acceptable when there's no id, but fragile (breaks on
   translation or copy changes). We use it deliberately for the broken build's "Log In"
   button, which has no id.
3. **Position / index** — never. Breaks the instant anything moves.

## The testability lesson
One TechShop control has no id (BUG-016). You cannot write a stable test for it — the fix
isn't a cleverer locator, it's adding an identifier to the app. Testability is a feature.

## SwiftUI vs React Native
The same screen can present slightly different element **types** and hierarchy across the two
stacks. Because we anchor to identifiers (which both stacks share), the same locator finds
both — the concrete proof that good locators make one test run on two very different apps.

## The habit
For every locator the agent writes, ask: would this break if the UI changed? And for every
assertion: could this pass if the feature were broken? If yes, it's a false green — fix it.

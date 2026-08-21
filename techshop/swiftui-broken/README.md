# TechShop iOS — SwiftUI (Broken)

The **broken** native SwiftUI build of TechShop, with the same 15 core + 2 mobile-specific
bugs planted as the React Native build.

## Generate the Xcode project & run

```bash
brew install xcodegen        # one time
xcodegen generate            # creates TechShop.xcodeproj from project.yml
open TechShop.xcodeproj       # then pick an iPhone Simulator and press Run (⌘R)
```

> If you prefer not to use XcodeGen: create a new Xcode iOS App project named `TechShop`
> (SwiftUI lifecycle), then drag every file from the `TechShop/` folder into it.

**Credentials:** demo@techshop.com / password123

> As in the React Native build, **BUG-011** makes "Proceed to Checkout" a no-op, so the
> checkout screen is unreachable via the button in this broken build. Checkout bugs are
> verified against `../swiftui-fixed`.

## Where each bug lives

| Bug | File |
|-----|------|
| BUG-001 password not secure | `TechShop/LoginView.swift` |
| BUG-002 / 003 login accepts anything | `TechShop/Store.swift` |
| BUG-004 discount /1000 | `TechShop/Store.swift` |
| BUG-005 quantity below 1 | `TechShop/Store.swift` |
| BUG-006 total not updating | `TechShop/CartView.swift` |
| BUG-007 long name overflow | `TechShop/CatalogView.swift` |
| BUG-008 green out-of-stock badge | `TechShop/CatalogView.swift` |
| BUG-009 past expiry accepted | `TechShop/CheckoutView.swift` |
| BUG-010 CVV non-numeric keyboard | `TechShop/CheckoutView.swift` |
| BUG-011 proceed no-op (blocker) | `TechShop/CartView.swift` |
| BUG-012 empty checkout submit | `TechShop/CheckoutView.swift` |
| BUG-013 no order reference | `TechShop/ConfirmationView.swift` |
| BUG-014 title "Untitled" | `TechShop/CatalogView.swift` |
| BUG-015 tab bar before auth | `TechShop/RootView.swift` |
| BUG-016 login button no identifier | `TechShop/LoginView.swift` |
| BUG-017 keyboard covers CVV | `TechShop/CheckoutView.swift` |

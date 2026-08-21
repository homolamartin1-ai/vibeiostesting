# TechShop iOS — SwiftUI (Fixed)

The **clean** native SwiftUI build of TechShop. All 17 planted bugs are corrected. Used in
Section 13 for the regression / verification pass — your suite should go green here.

## Generate the Xcode project & run

```bash
brew install xcodegen        # one time
xcodegen generate
open TechShop.xcodeproj       # pick an iPhone Simulator, press Run (⌘R)
```

**Credentials:** demo@techshop.com / password123

Every fix is marked with a `FIXED (BUG-0xx)` comment. Diff against `../swiftui-broken`.

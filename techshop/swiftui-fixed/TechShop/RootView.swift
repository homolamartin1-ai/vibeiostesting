import SwiftUI

struct RootView: View {
    @EnvironmentObject var store: Store

    var body: some View {
        // FIXED (BUG-015): the tab bar exists only after authentication.
        // Before login, the login screen is shown alone — no tabs.
        if store.isAuthenticated {
            MainTabs()
        } else {
            LoginView()
        }
    }
}

struct MainTabs: View {
    var body: some View {
        // Tabs carry stable identifiers (parity with the RN build's tab-products /
        // tab-cart testIDs) so the same locator finds the bottom-nav tabs on both stacks.
        TabView {
            CatalogView()
                .tabItem { Label("Products", systemImage: "bag") }
                .accessibilityIdentifier("tab-products")
            CartView()
                .tabItem { Label("Cart", systemImage: "cart") }
                .accessibilityIdentifier("tab-cart")
        }
    }
}

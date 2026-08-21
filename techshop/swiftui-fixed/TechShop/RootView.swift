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
        TabView {
            CatalogView()
                .tabItem { Label("Products", systemImage: "bag") }
            CartView()
                .tabItem { Label("Cart", systemImage: "cart") }
        }
    }
}

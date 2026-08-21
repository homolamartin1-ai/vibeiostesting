import SwiftUI

struct RootView: View {
    @EnvironmentObject var store: Store
    @State private var selection = 0

    var body: some View {
        // ─────────────────────────────────────────────────────────────
        // BUG-015: the TabView (with Products and Cart tabs) is shown
        // from launch, before the user authenticates. The tab bar is
        // visible and Products/Cart are tappable before sign-in.
        // The requirement: show the login screen alone until sign-in.
        // The fix: `if store.isAuthenticated { MainTabs() } else { LoginView() }`
        // ─────────────────────────────────────────────────────────────
        TabView(selection: $selection) {
            LoginView()
                .tabItem { Label("Sign In", systemImage: "person") }
                .tag(0)
            CatalogView()
                .tabItem { Label("Products", systemImage: "bag") }
                .tag(1)
            CartView()
                .tabItem { Label("Cart", systemImage: "cart") }
                .tag(2)
        }
        .onChange(of: store.isAuthenticated) { authed in
            if authed { selection = 1 }
        }
    }
}

import SwiftUI

struct RootView: View {
    @EnvironmentObject var store: Store
    
    var body: some View {
        Group {
            if store.isLoggedIn {
                RoomsView()
            } else {
                LoginView()
            }
        }
    }
}

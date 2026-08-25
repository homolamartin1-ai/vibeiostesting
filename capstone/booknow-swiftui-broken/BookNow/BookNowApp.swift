import SwiftUI

@main
struct BookNowApp: App {
    @StateObject private var store = Store()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
        }
    }
}

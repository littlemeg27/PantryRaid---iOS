import SwiftUI

@main
struct OnHandApp: App {
    @StateObject private var store = InventoryStore()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(store)
        }
    }
}

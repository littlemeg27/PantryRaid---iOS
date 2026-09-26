import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            KitchenView()
                .tabItem { Label("Kitchen", systemImage: "refrigerator") }
            InventoryView()
                .tabItem { Label("On hand", systemImage: "list.bullet") }
            RecipesView()
                .tabItem { Label("Recipes", systemImage: "fork.knife") }
            ShopView()
                .tabItem { Label("Shop", systemImage: "cart") }
        }
        .tint(OnHandTheme.sage)
    }
}

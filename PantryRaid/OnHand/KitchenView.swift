import SwiftUI

struct KitchenView: View {
    @EnvironmentObject private var store: InventoryStore
    @State private var showAdd = false

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(alignment: .leading, spacing: 16) {
                    Text("WHAT YOU ALREADY HAVE")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(OnHandTheme.terracotta)
                    Text("\(store.items.count) items across the fridge, freezer, pantry, and spices.")
                        .font(.largeTitle.bold())
                    Text("OnHand looks at what is in the kitchen right now, then suggests recipes you can make without another store run. Shopping stays on a list until checkout moves food into the kitchen.")
                        .foregroundStyle(OnHandTheme.muted)
                    if store.expiringCount > 0 {
                        Text("\(store.expiringCount) item\(store.expiringCount == 1 ? "" : "s") expired or due in 3 days.")
                            .fontWeight(.bold)
                            .foregroundStyle(OnHandTheme.terracotta)
                    }
                    if !store.shopping.isEmpty {
                        Text("\(store.shopping.count) item\(store.shopping.count == 1 ? "" : "s") waiting on the shopping list.")
                            .fontWeight(.semibold)
                            .foregroundStyle(OnHandTheme.sage)
                    }

                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 10) {
                        ForEach([StorageLocation.refrigerator, .freezer, .pantry, .spices]) { location in
                            VStack(alignment: .leading) {
                                Text("\(store.items(in: location).count)")
                                    .font(.title.bold())
                                    .foregroundStyle(OnHandTheme.sage)
                                Text(location.label)
                                    .foregroundStyle(OnHandTheme.muted)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(OnHandTheme.surface, in: RoundedRectangle(cornerRadius: 16))
                        }
                    }

                    NavigationLink("What can I make?") {
                        RecipesView()
                    }
                    .buttonStyle(.borderedProminent)
                    .tint(OnHandTheme.sage)

                    Button("Add something on hand") { showAdd = true }
                        .buttonStyle(.bordered)
                }
                .padding()
            }
            .background(OnHandTheme.cream)
            .navigationTitle("Kitchen")
            .sheet(isPresented: $showAdd) {
                AddItemView(initialLocation: .pantry)
            }
        }
    }
}

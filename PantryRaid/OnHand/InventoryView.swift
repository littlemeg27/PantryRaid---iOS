import SwiftUI

struct InventoryView: View {
    @EnvironmentObject private var store: InventoryStore
    @State private var filter: StorageLocation?
    @State private var showAdd = false

    var visible: [InventoryItem] {
        guard let filter else { return store.items }
        return store.items(in: filter)
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("Refrigerator, freezer, pantry, spices — everything currently in the kitchen.")
                        .foregroundStyle(OnHandTheme.muted)
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack {
                            FilterChip(title: "All", selected: filter == nil) { filter = nil }
                            ForEach(StorageLocation.allCases) { location in
                                FilterChip(title: location.label, selected: filter == location) {
                                    filter = location
                                }
                            }
                        }
                    }
                }
                Section {
                    ForEach(visible) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name).font(.headline)
                                Text("\(item.quantity.formatted()) \(item.unit.rawValue) · \(item.location.label)")
                                    .font(.subheadline)
                                    .foregroundStyle(OnHandTheme.muted)
                                if let expiry = Expiry.label(item.expiresAt) {
                                    Text(expiry)
                                        .font(.caption.weight(.semibold))
                                        .foregroundStyle(Expiry.state(item.expiresAt) == .fresh ? OnHandTheme.sage : OnHandTheme.terracotta)
                                }
                            }
                            Spacer()
                            Button("−") { store.changeQuantity(id: item.id, quantity: item.quantity - 1) }
                            Button("+") { store.changeQuantity(id: item.id, quantity: item.quantity + 1) }
                        }
                        .swipeActions {
                            Button(role: .destructive) { store.remove(id: item.id) } label: {
                                Text("Remove")
                            }
                        }
                    }
                }
            }
            .navigationTitle("On hand")
            .toolbar {
                Button("Add") { showAdd = true }
            }
            .sheet(isPresented: $showAdd) {
                AddItemView(initialLocation: filter ?? .pantry)
            }
        }
    }
}

private struct FilterChip: View {
    let title: String
    let selected: Bool
    let action: () -> Void

    var body: some View {
        Button(title, action: action)
            .buttonStyle(.bordered)
            .tint(selected ? OnHandTheme.sage : OnHandTheme.muted)
    }
}

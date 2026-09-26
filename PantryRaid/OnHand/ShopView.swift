import SwiftUI

struct ShopView: View {
    @EnvironmentObject private var store: InventoryStore
    @State private var name = ""
    @State private var quantity = "1"
    @State private var destination: StorageLocation = .pantry
    @State private var expires = ""

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("Grocery list only. Nothing enters the kitchen until you check it out after you buy it.")
                        .foregroundStyle(OnHandTheme.muted)
                    TextField("Item", text: $name)
                    TextField("Quantity", text: $quantity)
                        .keyboardType(.decimalPad)
                    TextField("Expires after purchase (optional YYYY-MM-DD)", text: $expires)
                    Picker("Goes into", selection: $destination) {
                        ForEach(StorageLocation.allCases) { location in
                            Text(location.label).tag(location)
                        }
                    }
                    Button("Add to shopping list") {
                        guard let qty = Double(quantity) else { return }
                        store.addToShoppingList(
                            name: name,
                            quantity: qty,
                            unit: .each,
                            destination: destination,
                            expiresAt: Expiry.parseDay(expires)
                        )
                        name = ""
                        quantity = "1"
                        expires = ""
                    }
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }

                if !store.shopping.isEmpty {
                    Section("In the cart") {
                        ForEach(store.shopping) { item in
                            HStack {
                                Button {
                                    store.togglePurchased(id: item.id)
                                } label: {
                                    Image(systemName: item.purchased ? "checkmark.circle.fill" : "circle")
                                        .foregroundStyle(item.purchased ? OnHandTheme.sage : OnHandTheme.muted)
                                }
                                .buttonStyle(.plain)
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                    Text(detail(item))
                                        .font(.caption)
                                        .foregroundStyle(OnHandTheme.muted)
                                }
                            }
                            .swipeActions {
                                Button(role: .destructive) {
                                    store.removeShopping(id: item.id)
                                } label: {
                                    Text("Remove")
                                }
                            }
                        }
                        Button("Check out purchased items") {
                            store.checkoutPurchased()
                        }
                        .disabled(store.shopping.allSatisfy { !$0.purchased })
                    }
                }
            }
            .navigationTitle("Shop")
        }
    }

    private func detail(_ item: ShoppingItem) -> String {
        var line = "\(item.quantity.formatted()) \(item.unit.rawValue) → \(item.destination.label)"
        if let expiry = Expiry.label(item.expiresAt) {
            line += " · \(expiry)"
        }
        return line
    }
}

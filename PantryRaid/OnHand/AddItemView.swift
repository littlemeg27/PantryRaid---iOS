import SwiftUI

struct AddItemView: View {
    @EnvironmentObject private var store: InventoryStore
    @Environment(\.dismiss) private var dismiss

    var initialLocation: StorageLocation

    @State private var name = ""
    @State private var quantity = "1"
    @State private var unit: UnitKind = .each
    @State private var location: StorageLocation
    @State private var expires = ""

    init(initialLocation: StorageLocation) {
        self.initialLocation = initialLocation
        _location = State(initialValue: initialLocation)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("Log refrigerator, freezer, pantry, or spice items so the recipe tool knows what you can cook tonight.")
                        .foregroundStyle(OnHandTheme.muted)
                    TextField("Item name", text: $name)
                    TextField("Quantity", text: $quantity)
                        .keyboardType(.decimalPad)
                    TextField("Expires (optional YYYY-MM-DD)", text: $expires)
                    Picker("Unit", selection: $unit) {
                        ForEach(UnitKind.allCases) { option in
                            Text(option.rawValue).tag(option)
                        }
                    }
                    Picker("Location", selection: $location) {
                        ForEach(StorageLocation.allCases) { option in
                            Text(option.label).tag(option)
                        }
                    }
                }
            }
            .navigationTitle("Add to kitchen")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        guard let qty = Double(quantity) else { return }
                        store.addItem(
                            name: name,
                            quantity: qty,
                            unit: unit,
                            location: location,
                            expiresAt: Expiry.parseDay(expires)
                        )
                        dismiss()
                    }
                    .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
                }
            }
        }
    }
}

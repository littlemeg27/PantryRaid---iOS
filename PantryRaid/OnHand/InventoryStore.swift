import Foundation
import Combine

@MainActor
final class InventoryStore: ObservableObject {
    @Published private(set) var items: [InventoryItem]
    @Published private(set) var shopping: [ShoppingItem]
    @Published var aiSettings: AiSettings
    @Published var aiMatches: [RecipeMatch] = []
    @Published var aiBusy = false
    @Published var aiError: String?

    private let defaults = UserDefaults.standard
    private let itemsKey = "onhand.inventory.v2"
    private let shopKey = "onhand.shopping.v1"
    private let aiKey = "onhand.ai.v1"
    private var extraRecipes: [String: Recipe] = [:]

    init() {
        if let data = UserDefaults.standard.data(forKey: "onhand.inventory.v2"),
           let decoded = try? JSONDecoder().decode([InventoryItem].self, from: data) {
            items = decoded
        } else if let data = UserDefaults.standard.data(forKey: "onhand.inventory.v1"),
                  let decoded = try? JSONDecoder().decode([InventoryItem].self, from: data) {
            items = decoded
        } else {
            items = SeedData.inventory
        }

        if let data = UserDefaults.standard.data(forKey: "onhand.shopping.v1"),
           let decoded = try? JSONDecoder().decode([ShoppingItem].self, from: data) {
            shopping = decoded
        } else {
            shopping = []
        }

        if let data = UserDefaults.standard.data(forKey: "onhand.ai.v1"),
           let decoded = try? JSONDecoder().decode(AiSettings.self, from: data) {
            aiSettings = decoded
        } else {
            aiSettings = .default
        }
    }

    func addItem(name: String, quantity: Double, unit: UnitKind, location: StorageLocation, expiresAt: Date? = nil) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, quantity > 0 else { return }

        if let index = items.firstIndex(where: {
            $0.name.compare(trimmed, options: .caseInsensitive) == .orderedSame &&
            $0.location == location &&
            $0.unit == unit
        }) {
            items[index].quantity += quantity
            items[index].expiresAt = earlier(items[index].expiresAt, expiresAt)
        } else {
            items.insert(
                InventoryItem(
                    id: UUID().uuidString,
                    name: trimmed,
                    quantity: quantity,
                    unit: unit,
                    location: location,
                    addedAt: .now,
                    expiresAt: expiresAt
                ),
                at: 0
            )
        }
        persist()
    }

    func changeQuantity(id: String, quantity: Double) {
        items = items
            .map { item in
                var next = item
                if next.id == id { next.quantity = quantity }
                return next
            }
            .filter { $0.quantity > 0 }
        persist()
    }

    func remove(id: String) {
        items.removeAll { $0.id == id }
        persist()
    }

    func addToShoppingList(name: String, quantity: Double, unit: UnitKind, destination: StorageLocation, expiresAt: Date? = nil) {
        let trimmed = name.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty, quantity > 0 else { return }
        shopping.insert(
            ShoppingItem(
                id: UUID().uuidString,
                name: trimmed,
                quantity: quantity,
                unit: unit,
                destination: destination,
                expiresAt: expiresAt
            ),
            at: 0
        )
        persist()
    }

    func togglePurchased(id: String) {
        guard let index = shopping.firstIndex(where: { $0.id == id }) else { return }
        shopping[index].purchased.toggle()
        persist()
    }

    func removeShopping(id: String) {
        shopping.removeAll { $0.id == id }
        persist()
    }

    func checkoutPurchased() {
        let bought = shopping.filter(\.purchased)
        guard !bought.isEmpty else { return }
        bought.forEach { item in
            addItem(name: item.name, quantity: item.quantity, unit: item.unit, location: item.destination, expiresAt: item.expiresAt)
        }
        shopping.removeAll(\.purchased)
        persist()
    }

    func items(in location: StorageLocation) -> [InventoryItem] {
        items.filter { $0.location == location }
    }

    func localMatches(query: String = "") -> [RecipeMatch] {
        RecipeMatcher.suggest(items: items, query: query)
    }

    func recipe(id: String) -> Recipe? {
        extraRecipes[id] ?? RecipeMatcher.find(id)
    }

    func matchFor(id: String) -> RecipeMatch? {
        guard let recipe = recipe(id: id) else { return nil }
        return RecipeMatcher.match(recipe, items: items)
    }

    func searchWithAi(query: String) async {
        aiBusy = true
        aiError = nil
        defer { aiBusy = false }
        do {
            let matches = try await AiRecipeService.search(items: items, query: query, settings: aiSettings)
            matches.forEach { extraRecipes[$0.recipe.id] = $0.recipe }
            aiMatches = matches
        } catch {
            aiError = error.localizedDescription
        }
    }

    func saveAiSettings(_ settings: AiSettings) {
        aiSettings = settings
        persist()
    }

    var expiringCount: Int {
        items.filter {
            let state = Expiry.state($0.expiresAt)
            return state == .soon || state == .expired
        }.count
    }

    private func persist() {
        if let data = try? JSONEncoder().encode(items) {
            defaults.set(data, forKey: itemsKey)
        }
        if let data = try? JSONEncoder().encode(shopping) {
            defaults.set(data, forKey: shopKey)
        }
        if let data = try? JSONEncoder().encode(aiSettings) {
            defaults.set(data, forKey: aiKey)
        }
    }

    private func earlier(_ a: Date?, _ b: Date?) -> Date? {
        switch (a, b) {
        case let (first?, second?): return min(first, second)
        case let (first?, nil): return first
        case let (nil, second?): return second
        default: return nil
        }
    }
}

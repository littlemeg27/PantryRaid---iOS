import Foundation

enum StorageLocation: String, Codable, CaseIterable, Identifiable {
    case refrigerator, freezer, pantry, spices, other

    var id: String { rawValue }

    var label: String {
        switch self {
        case .refrigerator: return "Fridge"
        case .freezer: return "Freezer"
        case .pantry: return "Pantry"
        case .spices: return "Spices"
        case .other: return "Other"
        }
    }
}

enum UnitKind: String, Codable, CaseIterable, Identifiable {
    case each, cup, tbsp, tsp, oz, lb, g, kg, ml, l, bunch, can, bag, loaf, pinch
    var id: String { rawValue }
}

struct InventoryItem: Identifiable, Codable, Equatable {
    var id: String
    var name: String
    var quantity: Double
    var unit: UnitKind
    var location: StorageLocation
    var addedAt: Date
    var expiresAt: Date? = nil
}

struct ShoppingItem: Identifiable, Codable, Equatable {
    var id: String
    var name: String
    var quantity: Double
    var unit: UnitKind
    var destination: StorageLocation
    var purchased: Bool = false
    var expiresAt: Date? = nil
}

struct RecipeIngredient: Codable, Hashable {
    var name: String
    var isOptional: Bool

    enum CodingKeys: String, CodingKey {
        case name
        case isOptional = "optional"
    }

    init(name: String, isOptional: Bool) {
        self.name = name
        self.isOptional = isOptional
    }
}

struct Recipe: Identifiable, Codable, Hashable {
    var id: String
    var title: String
    var description: String
    var minutes: Int
    var servings: Int
    var tags: [String]
    var ingredients: [RecipeIngredient]
    var instructions: [String]
}

enum RecipeSource {
    case local
    case ai
}

struct RecipeMatch: Identifiable {
    var id: String { recipe.id }
    var recipe: Recipe
    var have: [String]
    var missing: [String]
    var optionalMissing: [String]
    var score: Double
    var source: RecipeSource = .local
}

struct AiSettings: Codable, Equatable {
    var apiKey: String
    var baseUrl: String
    var model: String

    static let `default` = AiSettings(
        apiKey: "",
        baseUrl: "https://api.x.ai/v1",
        model: "grok-3"
    )
}

enum ExpiryState {
    case none, fresh, soon, expired
}

import Foundation

enum RecipeMatcher {
    private static let aliases: [String: String] = [
        "chicken thigh": "chicken thighs",
        "chicken": "chicken thighs",
        "pea": "frozen peas",
        "peas": "frozen peas",
        "frozen pea": "frozen peas",
        "tomato": "canned tomatoes",
        "tomatoes": "canned tomatoes",
        "crushed tomatoes": "canned tomatoes",
        "diced tomatoes": "canned tomatoes",
        "bean": "black beans",
        "beans": "black beans",
        "black bean": "black beans",
        "cheddar cheese": "cheddar",
        "cheese": "cheddar",
        "egg": "eggs",
        "spaghetti": "pasta",
        "noodles": "pasta",
        "white rice": "rice",
        "kosher salt": "salt",
        "sea salt": "salt",
        "pepper": "black pepper",
        "extra virgin olive oil": "olive oil",
        "yellow onion": "onion",
        "onions": "onion",
        "garlic cloves": "garlic",
        "garlic clove": "garlic",
    ]

    static func normalize(_ raw: String) -> String {
        let cleaned = raw
            .lowercased()
            .replacingOccurrences(of: "[^a-z0-9\\s]", with: " ", options: .regularExpression)
            .replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
            .trimmingCharacters(in: .whitespaces)
        if let alias = aliases[cleaned] { return alias }
        let stripped = cleaned
            .replacingOccurrences(of: "\\b(fresh|frozen|canned|dried|ground|whole|chopped|minced)\\b", with: "", options: .regularExpression)
            .replacingOccurrences(of: "\\s+", with: " ", options: .regularExpression)
            .trimmingCharacters(in: .whitespaces)
        return aliases[stripped] ?? stripped
    }

    static func namesMatch(_ a: String, _ b: String) -> Bool {
        let left = normalize(a)
        let right = normalize(b)
        return left == right || left.contains(right) || right.contains(left)
    }

    static func match(_ recipe: Recipe, items: [InventoryItem]) -> RecipeMatch {
        var have: [String] = []
        var missing: [String] = []
        var optionalMissing: [String] = []

        for ingredient in recipe.ingredients {
            let owned = items.contains { $0.quantity > 0 && namesMatch($0.name, ingredient.name) }
            if owned {
                have.append(ingredient.name)
            } else if ingredient.isOptional {
                optionalMissing.append(ingredient.name)
            } else {
                missing.append(ingredient.name)
            }
        }

        let required = recipe.ingredients.filter { !$0.isOptional }
        let requiredHave = required.filter { ingredient in
            items.contains { $0.quantity > 0 && namesMatch($0.name, ingredient.name) }
        }.count
        let coverage = required.isEmpty ? 0.0 : Double(requiredHave) / Double(required.count)
        let score = min(1, max(0, coverage - Double(missing.count) * 0.18))

        return RecipeMatch(recipe: recipe, have: have, missing: missing, optionalMissing: optionalMissing, score: score)
    }

    static func suggest(items: [InventoryItem], query: String = "") -> [RecipeMatch] {
        let q = query.trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        return SeedData.recipes
            .map { match($0, items: items) }
            .filter { $0.score > 0.15 }
            .filter { match in
                guard !q.isEmpty else { return true }
                let haystack = "\(match.recipe.title) \(match.recipe.tags.joined(separator: " ")) \(match.recipe.description)".lowercased()
                return q.split(separator: " ").contains { haystack.contains($0) }
            }
            .sorted {
                if $0.missing.count != $1.missing.count { return $0.missing.count < $1.missing.count }
                return $0.score > $1.score
            }
    }

    static func find(_ id: String) -> Recipe? {
        SeedData.recipes.first { $0.id == id }
    }

    static func buildOnHandPrompt(items: [InventoryItem], query: String = "") -> String {
        let grouped = Dictionary(grouping: items, by: \.location)
            .map { location, list in
                "\(location.label): " + list.map { item in
                    let expiry = item.expiresAt.map { " expires \(Expiry.formatDay($0))" } ?? ""
                    return "\(item.name) (\(item.quantity) \(item.unit.rawValue)\(expiry))"
                }.joined(separator: ", ")
            }
            .joined(separator: "\n")
        let request = query.trimmingCharacters(in: .whitespacesAndNewlines)
        return """
        Suggest recipes that use what the user already has.
        Prefer zero extra grocery trips. If something is missing, keep it to 1–2 inexpensive staples.
        Favor ingredients that expire sooner.

        Ingredients on hand:
        \(grouped.isEmpty ? "(inventory is empty)" : grouped)

        User request: \(request.isEmpty ? "whatever is easiest with current on-hand items" : request)
        """
    }
}

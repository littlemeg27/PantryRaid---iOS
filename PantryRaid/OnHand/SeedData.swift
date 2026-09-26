import Foundation

enum SeedData {
    static let inventory: [InventoryItem] = [
        .init(id: "seed-eggs", name: "Eggs", quantity: 8, unit: .each, location: .refrigerator, addedAt: .now),
        .init(id: "seed-milk", name: "Milk", quantity: 1, unit: .l, location: .refrigerator, addedAt: .now, expiresAt: Calendar.current.date(byAdding: .day, value: 4, to: .now)),
        .init(id: "seed-butter", name: "Butter", quantity: 1, unit: .each, location: .refrigerator, addedAt: .now),
        .init(id: "seed-cheddar", name: "Cheddar", quantity: 8, unit: .oz, location: .refrigerator, addedAt: .now),
        .init(id: "seed-chicken", name: "Chicken thighs", quantity: 4, unit: .each, location: .freezer, addedAt: .now),
        .init(id: "seed-peas", name: "Frozen peas", quantity: 1, unit: .bag, location: .freezer, addedAt: .now),
        .init(id: "seed-rice", name: "Rice", quantity: 2, unit: .lb, location: .pantry, addedAt: .now),
        .init(id: "seed-pasta", name: "Pasta", quantity: 1, unit: .lb, location: .pantry, addedAt: .now),
        .init(id: "seed-tomatoes", name: "Canned tomatoes", quantity: 2, unit: .can, location: .pantry, addedAt: .now),
        .init(id: "seed-beans", name: "Black beans", quantity: 2, unit: .can, location: .pantry, addedAt: .now),
        .init(id: "seed-onion", name: "Onion", quantity: 3, unit: .each, location: .pantry, addedAt: .now),
        .init(id: "seed-garlic", name: "Garlic", quantity: 1, unit: .each, location: .pantry, addedAt: .now),
        .init(id: "seed-olive-oil", name: "Olive oil", quantity: 1, unit: .each, location: .pantry, addedAt: .now),
        .init(id: "seed-salt", name: "Salt", quantity: 1, unit: .each, location: .spices, addedAt: .now),
        .init(id: "seed-pepper", name: "Black pepper", quantity: 1, unit: .each, location: .spices, addedAt: .now),
        .init(id: "seed-paprika", name: "Paprika", quantity: 1, unit: .each, location: .spices, addedAt: .now),
        .init(id: "seed-cumin", name: "Cumin", quantity: 1, unit: .each, location: .spices, addedAt: .now),
    ]

    static let recipes: [Recipe] = [
        Recipe(
            id: "tomato-pasta",
            title: "Pantry Tomato Pasta",
            description: "A weeknight pasta that leans on canned tomatoes, garlic, and whatever cheese you have.",
            minutes: 25,
            servings: 3,
            tags: ["pasta", "vegetarian"],
            ingredients: [
                .init(name: "Pasta", isOptional: false),
                .init(name: "Canned tomatoes", isOptional: false),
                .init(name: "Garlic", isOptional: false),
                .init(name: "Olive oil", isOptional: false),
                .init(name: "Onion", isOptional: true),
                .init(name: "Cheddar", isOptional: true),
                .init(name: "Salt", isOptional: false),
                .init(name: "Black pepper", isOptional: false),
            ],
            instructions: [
                "Boil pasta in salted water until just shy of al dente.",
                "Warm olive oil, then soften onion and garlic.",
                "Add canned tomatoes, salt, and pepper. Simmer 10 minutes.",
                "Toss pasta with sauce and grate cheese over the top.",
            ]
        ),
        Recipe(
            id: "egg-fried-rice",
            title: "Egg Fried Rice",
            description: "Cold rice, eggs, and freezer peas become dinner in one pan.",
            minutes: 20,
            servings: 2,
            tags: ["rice", "quick"],
            ingredients: [
                .init(name: "Rice", isOptional: false),
                .init(name: "Eggs", isOptional: false),
                .init(name: "Frozen peas", isOptional: false),
                .init(name: "Onion", isOptional: false),
                .init(name: "Garlic", isOptional: false),
                .init(name: "Olive oil", isOptional: false),
                .init(name: "Salt", isOptional: false),
                .init(name: "Black pepper", isOptional: false),
            ],
            instructions: [
                "Scramble eggs in a little oil and set aside.",
                "Sauté onion and garlic, then add leftover or cooled rice.",
                "Stir in peas until hot, then fold eggs back in.",
                "Season with salt and pepper.",
            ]
        ),
        Recipe(
            id: "cheesy-omelette",
            title: "Cheddar Omelette",
            description: "The fastest thing you can make when the fridge still has eggs.",
            minutes: 10,
            servings: 1,
            tags: ["breakfast", "eggs"],
            ingredients: [
                .init(name: "Eggs", isOptional: false),
                .init(name: "Butter", isOptional: false),
                .init(name: "Cheddar", isOptional: true),
                .init(name: "Salt", isOptional: false),
                .init(name: "Black pepper", isOptional: false),
            ],
            instructions: [
                "Beat eggs with salt and pepper.",
                "Melt butter in a skillet over medium heat.",
                "Cook eggs until just set, add cheddar, and fold.",
            ]
        ),
        Recipe(
            id: "black-bean-skillet",
            title: "Smoky Black Bean Skillet",
            description: "Canned beans, onion, and cumin — pantry dinner with almost no prep.",
            minutes: 20,
            servings: 3,
            tags: ["beans", "vegetarian"],
            ingredients: [
                .init(name: "Black beans", isOptional: false),
                .init(name: "Onion", isOptional: false),
                .init(name: "Garlic", isOptional: false),
                .init(name: "Cumin", isOptional: false),
                .init(name: "Paprika", isOptional: false),
                .init(name: "Olive oil", isOptional: false),
                .init(name: "Salt", isOptional: false),
                .init(name: "Rice", isOptional: true),
            ],
            instructions: [
                "Sauté onion and garlic in olive oil.",
                "Add beans, cumin, paprika, and a splash of water.",
                "Simmer until thick. Serve over rice if you have it.",
            ]
        ),
        Recipe(
            id: "paprika-chicken",
            title: "Paprika Chicken Thighs",
            description: "Thawed or frozen-to-oven chicken with pantry spices.",
            minutes: 40,
            servings: 4,
            tags: ["chicken", "dinner"],
            ingredients: [
                .init(name: "Chicken thighs", isOptional: false),
                .init(name: "Paprika", isOptional: false),
                .init(name: "Garlic", isOptional: false),
                .init(name: "Olive oil", isOptional: false),
                .init(name: "Salt", isOptional: false),
                .init(name: "Black pepper", isOptional: false),
                .init(name: "Onion", isOptional: true),
            ],
            instructions: [
                "Toss chicken with oil, paprika, salt, pepper, and minced garlic.",
                "Roast at 425°F / 220°C until cooked through, about 30–35 minutes.",
                "Rest a few minutes, then serve with rice or pasta.",
            ]
        ),
        Recipe(
            id: "garlic-butter-rice",
            title: "Garlic Butter Rice",
            description: "A side that can also be lunch when the pantry is quiet.",
            minutes: 25,
            servings: 4,
            tags: ["rice", "side"],
            ingredients: [
                .init(name: "Rice", isOptional: false),
                .init(name: "Butter", isOptional: false),
                .init(name: "Garlic", isOptional: false),
                .init(name: "Salt", isOptional: false),
            ],
            instructions: [
                "Melt butter and gently cook garlic until fragrant.",
                "Add rinsed rice and toast for a minute.",
                "Add water and salt, simmer covered until tender.",
            ]
        ),
        Recipe(
            id: "peas-and-eggs",
            title: "Buttered Peas with Eggs",
            description: "Freezer peas and fridge eggs — humble and fast.",
            minutes: 15,
            servings: 2,
            tags: ["quick", "vegetarian"],
            ingredients: [
                .init(name: "Frozen peas", isOptional: false),
                .init(name: "Eggs", isOptional: false),
                .init(name: "Butter", isOptional: false),
                .init(name: "Salt", isOptional: false),
                .init(name: "Black pepper", isOptional: false),
            ],
            instructions: [
                "Warm peas in butter with salt and pepper.",
                "Fry or scramble eggs alongside.",
                "Spoon peas next to the eggs and eat immediately.",
            ]
        ),
        Recipe(
            id: "tomato-bean-stew",
            title: "Tomato and Bean Stew",
            description: "One pot from pantry cans, good with bread or rice.",
            minutes: 30,
            servings: 4,
            tags: ["stew", "vegetarian"],
            ingredients: [
                .init(name: "Canned tomatoes", isOptional: false),
                .init(name: "Black beans", isOptional: false),
                .init(name: "Onion", isOptional: false),
                .init(name: "Garlic", isOptional: false),
                .init(name: "Paprika", isOptional: false),
                .init(name: "Olive oil", isOptional: false),
                .init(name: "Salt", isOptional: false),
                .init(name: "Rice", isOptional: true),
            ],
            instructions: [
                "Sweat onion and garlic in olive oil.",
                "Add tomatoes, beans, paprika, and salt.",
                "Simmer 15–20 minutes until thick. Serve with rice.",
            ]
        ),
    ]
}

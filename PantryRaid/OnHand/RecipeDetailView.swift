import SwiftUI

struct RecipeDetailView: View {
    @EnvironmentObject private var store: InventoryStore
    let recipeId: String

    var match: RecipeMatch? {
        store.matchFor(id: recipeId)
    }

    var body: some View {
        ScrollView {
            if let match {
                VStack(alignment: .leading, spacing: 12) {
                    Text(match.recipe.title).font(.largeTitle.bold())
                    Text("\(match.recipe.minutes) min · \(match.recipe.servings) servings")
                        .foregroundStyle(OnHandTheme.sage)
                        .fontWeight(.bold)
                    Text(match.recipe.description).foregroundStyle(OnHandTheme.muted)

                    Text("On hand").font(.headline)
                    if match.have.isEmpty {
                        Text("None of the required items are logged yet.")
                            .foregroundStyle(OnHandTheme.muted)
                    } else {
                        ForEach(match.have, id: \.self) { name in
                            Text("✓ \(name)").foregroundStyle(OnHandTheme.sage)
                        }
                    }

                    if match.missing.isEmpty {
                        Text("You can make this with what is already in the kitchen.")
                            .fontWeight(.bold)
                            .foregroundStyle(OnHandTheme.sage)
                    } else {
                        Text("Still needed").font(.headline)
                        ForEach(match.missing, id: \.self) { name in
                            Text("• \(name)").foregroundStyle(OnHandTheme.terracotta)
                        }
                    }

                    Text("Steps").font(.headline)
                    ForEach(Array(match.recipe.instructions.enumerated()), id: \.offset) { index, step in
                        Text("\(index + 1). \(step)")
                    }
                }
                .padding()
            } else {
                Text("Recipe not found").padding()
            }
        }
        .background(OnHandTheme.cream)
        .navigationTitle("Recipe")
        .navigationBarTitleDisplayMode(.inline)
    }
}

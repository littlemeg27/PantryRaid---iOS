import SwiftUI

struct RecipesView: View {
    @EnvironmentObject private var store: InventoryStore
    @State private var query = ""
    @State private var showSettings = false

    var matches: [RecipeMatch] {
        store.aiMatches.isEmpty ? store.localMatches(query: query) : store.aiMatches
    }

    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("Search recipes from refrigerator, freezer, pantry, and spice items already on hand.")
                        .foregroundStyle(OnHandTheme.muted)
                    TextField("Pasta, eggs, something fast...", text: $query)
                        .textFieldStyle(.roundedBorder)
                    HStack {
                        Button(store.aiSettings.apiKey.isEmpty ? "Find on hand" : "Ask AI") {
                            Task { await store.searchWithAi(query: query) }
                        }
                        .disabled(store.aiBusy)
                        Button("AI setup") { showSettings = true }
                    }
                    if store.aiBusy {
                        ProgressView()
                    }
                    if let error = store.aiError {
                        Text(error).foregroundStyle(OnHandTheme.terracotta)
                    }
                    Text(store.aiMatches.isEmpty ? "Local matcher · \(store.items.count) items on hand" : "AI suggestions · \(store.items.count) items on hand")
                        .font(.caption.weight(.bold))
                        .foregroundStyle(OnHandTheme.terracotta)
                }
                ForEach(matches) { match in
                    NavigationLink {
                        RecipeDetailView(recipeId: match.recipe.id)
                    } label: {
                        VStack(alignment: .leading, spacing: 6) {
                            Text(match.recipe.title).font(.headline)
                            Text(match.recipe.description)
                                .font(.subheadline)
                                .foregroundStyle(OnHandTheme.muted)
                            Text(caption(match))
                                .font(.caption.weight(.semibold))
                                .foregroundStyle(OnHandTheme.sage)
                        }
                    }
                }
            }
            .navigationTitle("Recipes")
            .sheet(isPresented: $showSettings) {
                SettingsView()
            }
        }
    }

    private func caption(_ match: RecipeMatch) -> String {
        let source = match.source == .ai ? "AI" : "On hand"
        let ready = match.missing.isEmpty ? "ready" : "\(match.missing.count) missing"
        return "\(source) · \(ready) · \(match.recipe.minutes) min"
    }
}

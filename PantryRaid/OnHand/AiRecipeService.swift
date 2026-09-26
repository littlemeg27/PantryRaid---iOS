import Foundation

enum AiRecipeService {
    struct Envelope: Decodable {
        let recipes: [Recipe]
    }

    struct ChatResponse: Decodable {
        struct Choice: Decodable {
            struct Message: Decodable { let content: String }
            let message: Message
        }
        let choices: [Choice]
    }

    static func search(items: [InventoryItem], query: String, settings: AiSettings) async throws -> [RecipeMatch] {
        if settings.apiKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return RecipeMatcher.suggest(items: items, query: query).map {
                var match = $0
                match.source = .local
                return match
            }
        }

        let root = settings.baseUrl.trimmingCharacters(in: CharacterSet(charactersIn: "/"))
        guard let url = URL(string: "\(root)/chat/completions") else {
            throw URLError(.badURL)
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.timeoutInterval = 60
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(settings.apiKey)", forHTTPHeaderField: "Authorization")
        request.httpBody = try JSONSerialization.data(withJSONObject: [
            "model": settings.model.isEmpty ? "grok-3" : settings.model,
            "temperature": 0.3,
            "messages": [
                ["role": "system", "content": systemPrompt],
                ["role": "user", "content": RecipeMatcher.buildOnHandPrompt(items: items, query: query)],
            ],
        ])

        let (data, response) = try await URLSession.shared.data(for: request)
        let code = (response as? HTTPURLResponse)?.statusCode ?? 0
        guard (200...299).contains(code) else {
            let body = String(data: data, encoding: .utf8) ?? ""
            throw NSError(domain: "OnHandAI", code: code, userInfo: [NSLocalizedDescriptionKey: "AI request failed (\(code)): \(body.prefix(240))"])
        }

        let chat = try JSONDecoder().decode(ChatResponse.self, from: data)
        guard let content = chat.choices.first?.message.content,
              let jsonStart = content.firstIndex(of: "{"),
              let jsonEnd = content.lastIndex(of: "}"),
              jsonStart < jsonEnd else {
            throw NSError(domain: "OnHandAI", code: 0, userInfo: [NSLocalizedDescriptionKey: "AI did not return JSON recipes."])
        }

        let json = String(content[jsonStart...jsonEnd]).data(using: .utf8) ?? Data()
        let envelope = try JSONDecoder().decode(Envelope.self, from: json)
        return envelope.recipes.map { recipe in
            var match = RecipeMatcher.match(recipe, items: items)
            match.source = .ai
            return match
        }
    }

    private static let systemPrompt = """
    You are the OnHand kitchen assistant. Reply with JSON only, no markdown.
    Shape: {"recipes":[{"id":"slug","title":"","description":"","minutes":20,"servings":2,"tags":["quick"],"ingredients":[{"name":"Eggs","optional":false}],"instructions":["step"]}]}
    Prefer recipes the user can cook with on-hand items. Missing ingredients should stay rare and cheap.
    """
}

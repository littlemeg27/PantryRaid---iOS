import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var store: InventoryStore
    @Environment(\.dismiss) private var dismiss
    @State private var apiKey = ""
    @State private var baseUrl = ""
    @State private var model = ""

    var body: some View {
        NavigationStack {
            Form {
                Section {
                    Text("Leave the API key empty to stay on the built-in on-hand matcher. Any OpenAI-compatible chat API works: xAI, OpenAI, or a local proxy.")
                        .foregroundStyle(OnHandTheme.muted)
                    SecureField("API key", text: $apiKey)
                    TextField("Base URL", text: $baseUrl)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                    TextField("Model", text: $model)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled()
                }
            }
            .navigationTitle("AI setup")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Close") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        store.saveAiSettings(AiSettings(apiKey: apiKey, baseUrl: baseUrl, model: model))
                        dismiss()
                    }
                }
            }
            .onAppear {
                apiKey = store.aiSettings.apiKey
                baseUrl = store.aiSettings.baseUrl
                model = store.aiSettings.model
            }
        }
    }
}

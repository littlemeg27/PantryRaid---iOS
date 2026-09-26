import Foundation

enum Expiry {
    private static let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()

    static func parseDay(_ raw: String) -> Date? {
        let trimmed = raw.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !trimmed.isEmpty else { return nil }
        return formatter.date(from: trimmed)
    }

    static func formatDay(_ date: Date?) -> String {
        guard let date else { return "" }
        return formatter.string(from: date)
    }

    static func state(_ date: Date?) -> ExpiryState {
        guard let date else { return .none }
        let days = Calendar.current.dateComponents([.day], from: Calendar.current.startOfDay(for: .now), to: Calendar.current.startOfDay(for: date)).day ?? 0
        if days < 0 { return .expired }
        if days <= 3 { return .soon }
        return .fresh
    }

    static func label(_ date: Date?) -> String? {
        guard let date else { return nil }
        let day = formatDay(date)
        switch state(date) {
        case .expired: return "Expired \(day)"
        case .soon: return "Use by \(day)"
        case .fresh: return "Expires \(day)"
        case .none: return nil
        }
    }
}

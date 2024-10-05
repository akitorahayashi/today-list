import Foundation

struct TLStep: Identifiable, Codable {
    let id = UUID()
    let title: String
    let isChecked: Bool
}

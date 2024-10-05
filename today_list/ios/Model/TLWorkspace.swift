import Foundation

struct TLWorkspace: Codable {
    var name: String
    var bigCategories: [TLCategory]
    var smallCategories: [String: [TLCategory]]
    var toDos: [String: TLToDos]
}

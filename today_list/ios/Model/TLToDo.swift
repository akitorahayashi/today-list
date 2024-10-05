import Foundation

struct TLToDo: Identifiable, Codable {
    var id: UUID
    var title: String
    var isChecked: Bool
    var steps: [TLStep]
    
    // デフォルトイニシャライザ
    init(id: UUID = UUID(), title: String, isChecked: Bool, steps: [TLStep]) {
        self.id = id
        self.title = title
        self.isChecked = isChecked
        self.steps = steps
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case isChecked
        case steps
    }
    
    // カスタムデコード処理
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        self.title = try container.decode(String.self, forKey: .title)
        self.isChecked = try container.decode(Bool.self, forKey: .isChecked)
        self.steps = try container.decode([TLStep].self, forKey: .steps)
    }
}

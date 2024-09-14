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
    
    // JSON からインスタンスを生成するカスタムイニシャライザ
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        // `id` が JSON に存在しない場合は、新しい UUID を設定
        self.id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        self.title = try container.decode(String.self, forKey: .title)
        self.isChecked = try container.decode(Bool.self, forKey: .isChecked)
        self.steps = try container.decode([TLStep].self, forKey: .steps)
    }
    
    // インスタンスを JSON に変換
    func toJson() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // 読みやすい形式にする場合
        do {
            let jsonData = try encoder.encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print("Error encoding to JSON: \(error)")
            return nil
        }
    }
    
    // JSON からインスタンスを生成
    static func fromJson(_ json: String) -> TLToDo? {
        let decoder = JSONDecoder()
        guard let jsonData = json.data(using: .utf8) else { return nil }
        do {
            return try decoder.decode(TLToDo.self, from: jsonData)
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case isChecked
        case steps
    }
}

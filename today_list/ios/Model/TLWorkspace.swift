import Foundation

struct TLWorkspace: Codable, Identifiable {
    var id: UUID
    var name: String
    var bigCategories: [TLCategory]
    var smallCategories: [String: [TLCategory]]
    var toDos: [String: TLToDos]
    
    // Default initializer
    init(id: UUID = UUID(), name: String, bigCategories: [TLCategory] = [], smallCategories: [String: [TLCategory]] = [:], toDos: [String: TLToDos] = [:]) {
        self.id = id
        self.name = name
        self.bigCategories = bigCategories
        self.smallCategories = smallCategories
        self.toDos = toDos
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case bigCategories
        case smallCategories
        case toDos
    }
    
    // Custom decoding
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(UUID.self, forKey: .id) ?? UUID()
        self.name = try container.decode(String.self, forKey: .name)
        self.bigCategories = try container.decode([TLCategory].self, forKey: .bigCategories)
        self.smallCategories = try container.decode([String: [TLCategory]].self, forKey: .smallCategories)
        self.toDos = try container.decode([String: TLToDos].self, forKey: .toDos)
    }
    
    // JSONからToDosをデコードする関数
    static func decodeWorkspaces(from jsonWorkspaces: String?) -> [TLWorkspace]? {
        // JSON文字列がnilでないかチェックし、データに変換
        guard let jsonString = jsonWorkspaces else {
            print("workspacesDecodeError: jsonWorkspaces is nil")
            return nil
        }
        
        guard let data = jsonString.data(using: .utf8) else {
            print("workspacesDecodeError: failed to convert data")
            return nil
        }
        
        do {
            // JSONをデコードして、[TLWorkspace] 型のデータに変換
            let tlWorkspaces = try JSONDecoder().decode([TLWorkspace].self, from: data)
            
            return tlWorkspaces
        } catch {
            print("JSONデコード中にエラーが発生しました: \(error.localizedDescription)")
            return nil
        }
    }
}

//
//  Model.swift
//  Runner
//
//  Created by 林 明虎 on 2024/10/21.
//
import SwiftUI

struct TLCategory: Codable {
    var id: String
    var title: String
}

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

struct TLStep: Identifiable, Codable {
    let id = UUID()
    let title: String
    let isChecked: Bool
}

struct TLToDos: Codable {
    let toDosInToday: [TLToDo]
    let toDosInWhenever: [TLToDo]
    
    // JSONからToDosをデコードする関数
    static func extractToDos(from jsonWorkspaces: String?, indexInWorkspaces: Int, toDosCategoryId: String) -> TLToDos? {
        // JSON文字列がnilでないかチェックし、データに変換
        guard let jsonString = jsonWorkspaces else {
            print("exit: nil")
            return nil
        }
        
        guard let data = jsonString.data(using: .utf8) else {
            print("データ変換に失敗しました")
            return nil
        }
        
        do {
            // JSONをデコードして、[TLWorkspace] 型のデータに変換
            let tlWorkspaces = try JSONDecoder().decode([TLWorkspace].self, from: data)
            
            // インデックスが有効かどうかをチェック
            guard indexInWorkspaces >= 0 && indexInWorkspaces < tlWorkspaces.count else {
                print("指定されたインデックスが無効です")
                return nil
            }
            
            // 指定されたインデックスのワークスペースを取得
            let selectedWorkspace: TLWorkspace = tlWorkspaces[indexInWorkspaces]
            
            // toDosCategoryIdに基づいて、適切なTLToDosを取得
            guard let toDos: TLToDos = selectedWorkspace.toDos[toDosCategoryId] else {
                print("指定されたカテゴリIDのToDosが見つかりません")
                return nil
            }
            
            return toDos
        } catch {
            print("JSONデコード中にエラーが発生しました: \(error.localizedDescription)")
            return nil
        }
    }
}

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

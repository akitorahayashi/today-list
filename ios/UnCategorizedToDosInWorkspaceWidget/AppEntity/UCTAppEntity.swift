//
//  UCTAppEntity.swift
//  Runner
//
//  Created by 林明虎 on 2025/02/28.
//

import WidgetKit
import AppIntents

// UserDefaults からWorkspacesを取得するクエリ
struct UCTQuery: EntityQuery {
    func entities(for identifiers: [String]) -> [UCTAppEntity] {
        loadSettingsList().filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() -> [UCTAppEntity] {
        loadSettingsList()
    }
    
    private func loadSettingsList() -> [UCTAppEntity] {
        let userDefaults = UserDefaults(suiteName: "group.akitorahayashi.todayListGroup")
        
        guard let jsonString = userDefaults?.string(forKey: "tlWorkspaces") else {
            print("UserDefaults does not contain tlWorkspaces key")
            return []
        }
        
        // 文字列をData型に変換できない場合
        guard let data = jsonString.data(using: .utf8) else {
            print("decodeCustomListError: Failed to convert JSON string to Data")
            return []
        }
        
        // JSONデコード処理
        do {
            let decodedSettings = try JSONDecoder().decode([TLWorkspace].self, from: data)
            
            let entities = decodedSettings.map {
                UCTAppEntity(
                    id: $0.id,
                    name: $0.name,
                    workspaceID: $0.id
                )
            }
            return entities
        } catch {
            print("decodeCustomListError: JSON decoding failed -> \(error.localizedDescription)")
            return []
        }
    }
}

struct UCTAppEntity: AppEntity {
    // snapshotなどで使う
    static let defaultEntity = UCTAppEntity(
        id: TLUUIDGenerator.generate(),
        name: TCWExampleState.BigCategoryID.projectA.name,
        workspaceID:  TCWExampleState.WorkspaceID.work.rawValue
    )
    
    static var defaultQuery = UCTQuery()
    
    var id: String
    var name: String
    var workspaceID: String
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation {
        "Selected Workspace"
    }
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: LocalizedStringResource(stringLiteral: name))
    }
}

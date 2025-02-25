//
//  TCEntity.swift
//  Runner
//
//  Created by 林 明虎 on 2025/02/09.
//

import WidgetKit
import AppIntents


struct TCEntity: AppEntity {
    // snapshotなどで使う
    static let defaultEntity = TCEntity(
        id: TLUUIDGenerator.generate(),
        title: WorkspaceID.work.name,
        workspaceID:  WorkspaceID.work.rawValue,
        categoryID: BigCategoryID.projectA.rawValue
    )
    
    static var defaultQuery = TCQuery()
        
        var id: String
        var title: String
    var workspaceID: String
    var categoryID: String

        static var typeDisplayRepresentation: TypeDisplayRepresentation {
            "Widget Settings"
        }
        
        var displayRepresentation: DisplayRepresentation {
            DisplayRepresentation(
                title: "\(title)",
                subtitle: nil
            )
        }
}

// UserDefaults からウィジェットの設定リストを取得するクエリ
struct TCQuery: EntityQuery {
    func entities(for identifiers: [String]) -> [TCEntity] {
        loadSettingsList().filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() -> [TCEntity] {
        loadSettingsList()
    }
    
    private func loadSettingsList() -> [TCEntity] {
        let userDefaults = UserDefaults(suiteName: "group.akitorahayashi.todayListGroup")
        
        guard let jsonString = userDefaults?.string(forKey: "listOfToDosInCategoryWidgetSettings") else {
            print("UserDefaults does not contain listOfToDosInCategoryWidgetSettings key")
            return []
        }
        
        // 文字列をData型に変換できない場合
        guard let data = jsonString.data(using: .utf8) else {
            print("decodeCustomListError: Failed to convert JSON string to Data")
            return []
        }
        
        // JSONデコード処理
        do {
            let decodedSettings = try JSONDecoder().decode([ToDosInCategoryWidgetSettings].self, from: data)
            
            let entities = decodedSettings.map {
                TCEntity(
                    id: $0.id,
                    title: $0.title,
                    workspaceID: $0.workspace.id,
                    categoryID: $0.smallCategory?.id ?? $0.bigCategory?.id ?? $0.workspace.id
                )
            }
            return entities
        } catch {
            print("decodeCustomListError: JSON decoding failed -> \(error.localizedDescription)")
            return []
        }
    }
}

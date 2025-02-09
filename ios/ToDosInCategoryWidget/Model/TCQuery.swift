//
//  TCQuery.swift
//  Runner
//
//  Created by 林 明虎 on 2025/02/09.
//

import WidgetKit
import AppIntents

/// UserDefaults からウィジェットの設定リストを取得するクエリ
struct TCQuery: EntityQuery {
    func entities(for identifiers: [String]) -> [TCEntity] {
        loadSettingsList().filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() -> [TCEntity] {
        loadSettingsList()
    }
    
    private func loadSettingsList() -> [TCEntity] {
        let userDefaults = UserDefaults(suiteName: "group.akitorahayashi.todayListGroup")
        
        guard let jsonString = userDefaults?.string(forKey: "wksList") else {
            print("UserDefaults does not contain wksList key")
            return []
        }
        print("JSON String: \(jsonString)")
        
        guard let settings = TCSettings.decodeWKSList(from: jsonString) else {
            print("Failed to decode JSON")
            return []
        }
        
        let entities = settings.map {
            TCEntity(
                id: $0.id,
                title: $0.title,
                workspaceID: $0.workspaceID,
                categoryID: $0.categoryID
            )
        }
        print("Loaded Entities: \(entities)")
        return entities
    }
}

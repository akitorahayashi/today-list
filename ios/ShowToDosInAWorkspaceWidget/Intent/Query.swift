//
//  Query.swift
//  Runner
//
//  Created by 林 明虎 on 2024/11/24.
//

import AppIntents

struct TLWidgetKitSettingsQuery: EntityQuery {
    func entities(for identifiers: [String]) -> [TLWidgetKitSettingsEntity] {
        loadSettingsList().filter { identifiers.contains($0.id) }
    }
    
    func suggestedEntities() -> [TLWidgetKitSettingsEntity] {
        loadSettingsList()
    }
    
    private func loadSettingsList() -> [TLWidgetKitSettingsEntity] {
        let userDefaults = UserDefaults(suiteName: "group.akitorahayashi.todayListGroup")
        
        // JSON文字列の取得を確認
        guard let jsonString = userDefaults?.string(forKey: "wksList") else {
            print("UserDefaults does not contain wksList key")
            return []
        }
        print("JSON String: \(jsonString)")

        // JSONデコードの確認
        guard let settings = TLWidgetKitSettings.decodeWKSList(from: jsonString) else {
            print("Failed to decode JSON")
            return []
        }

        // 正しいエンティティに変換されているか確認
        let entities = settings.map {
            TLWidgetKitSettingsEntity(
                id: $0.id,
                title: $0.title,
                workspaceIdx: $0.workspaceIdx,
                bcIdx: $0.bcIdx,
                scIdx: $0.scIdx
            )
        }
        print("Loaded Entities: \(entities)")
        return entities
    }
}


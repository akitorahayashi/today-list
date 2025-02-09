//
//  TLWidgetKitSettingsQuery.swift
//  Runner
//
//  Created by 林 明虎 on 2025/02/09.
//

import WidgetKit
import AppIntents

/// UserDefaults からウィジェットの設定リストを取得するクエリ
struct TCWQuery: EntityQuery {
    func entities(for identifiers: [String]) -> [TCWEntity] {
        loadSettingsList().filter { identifiers.contains($0.id) }
    }

    func suggestedEntities() -> [TCWEntity] {
        loadSettingsList()
    }

    private func loadSettingsList() -> [TCWEntity] {
        guard let jsonString = UserDefaults(suiteName: "group.akitorahayashi.todayListGroup")?.string(forKey: "wksList"),
              let settings = TCWSettings.decodeWKSList(from: jsonString) else {
            return []
        }

        return settings.map {
            TCWEntity(id: $0.id, title: $0.title, workspaceIdx: $0.workspaceIdx, bcIdx: $0.bcIdx, scIdx: $0.scIdx)
        }
    }
}

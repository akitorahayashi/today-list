//
//  TWAppEntity.swift
//  Runner
//
//  Created by akitora.hayashi on 2025/03/29.
//

import AppIntents
import WidgetKit

struct TWAppEntity: AppEntity {
    // snapshotなどで使う
    static let defaultEntity = TWAppEntity(
        id: TLUUIDGenerator.generate(),
        name: "Work",
        workspaceID: TCWExampleState.WorkspaceID.general.rawValue
    )

    static var defaultQuery = TWQuery()

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

// UserDefaults からWorkspacesを取得するクエリ
struct TWQuery: EntityQuery {
    func entities(for identifiers: [String]) -> [TWAppEntity] {
        loadSettingsList().filter { identifiers.contains($0.id) }
    }

    func suggestedEntities() -> [TWAppEntity] {
        loadSettingsList()
    }

    private func loadSettingsList() -> [TWAppEntity] {
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
                TWAppEntity(
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

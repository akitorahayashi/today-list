//
//  AppIntent.swift
//  ShowToDosInAWorkspaceWidget
//
//  Created by 林 明虎 on 2024/10/21.
//

import WidgetKit
import AppIntents

struct TLWidgetKitSettingsIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "iOS Widget Settings"
    static var description = IntentDescription("Select your widget settings")
    
    @Parameter(title: "Widget Title")
    var selectedWKS: TLWidgetKitSettingsEntity?
    
    static var parameterSummary: some ParameterSummary {
        Summary("Select widge: \(\.$selectedWKS)")
    }
}

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
                title: $0.title
            )
        }
        print("Loaded Entities: \(entities)")
        return entities
    }
}

struct TLWidgetKitSettingsEntity: AppEntity {
    let id: String
    let title: String

    static var defaultQuery = TLWidgetKitSettingsQuery()
    
    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(
            title: "\(title)",
            subtitle: nil,
            image: nil
        )
    }
    
    static var typeDisplayRepresentation: TypeDisplayRepresentation {
        "Widget Settings"
    }
}

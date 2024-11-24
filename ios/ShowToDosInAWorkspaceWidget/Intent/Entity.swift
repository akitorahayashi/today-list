//
//  Entity.swift
//  Runner
//
//  Created by 林 明虎 on 2024/11/24.
//

import AppIntents

let defaultEntity = TLWidgetKitSettingsEntity(id: noneID, title: "ToDo", workspaceIdx: 0, bcIdx: 0)

struct TLWidgetKitSettingsEntity: AppEntity {
    var id: String
    var title: String
    var workspaceIdx: Int
    var bcIdx: Int
    var scIdx:Int?

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

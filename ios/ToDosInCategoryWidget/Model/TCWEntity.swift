//
//  TLWidgetKitSettingsEntity.swift
//  Runner
//
//  Created by 林 明虎 on 2025/02/09.
//

import WidgetKit
import AppIntents

let defaultEntity = TCWEntity(id: noneID, title: "ToDo", workspaceIdx: 0, bcIdx: 0)

struct TCWEntity: AppEntity {
    var id: String
    var title: String
    var workspaceIdx: Int
    var bcIdx: Int
    var scIdx: Int?

    static var defaultQuery = TCWQuery()

    var displayRepresentation: DisplayRepresentation {
        DisplayRepresentation(title: "\(title)")
    }

    static var typeDisplayRepresentation: TypeDisplayRepresentation {
        "Widget Settings"
    }
}

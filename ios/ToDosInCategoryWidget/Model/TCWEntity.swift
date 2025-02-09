//
//  TLWidgetKitSettingsEntity.swift
//  Runner
//
//  Created by 林 明虎 on 2025/02/09.
//

import WidgetKit
import AppIntents

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

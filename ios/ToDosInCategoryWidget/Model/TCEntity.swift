//
//  TCEntity.swift
//  Runner
//
//  Created by 林 明虎 on 2025/02/09.
//

import WidgetKit
import AppIntents

let defaultEntity = TCEntity(
    id: TLWorkspacesExample.noneID.rawValue,
    title: "ToDo",
    workspaceID: TLWorkspacesExample.noneID.rawValue,
    categoryID: TLWorkspacesExample.noneID.rawValue
)

struct TCEntity: AppEntity {
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

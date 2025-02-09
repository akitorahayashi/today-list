//
//  TCEntity.swift
//  Runner
//
//  Created by 林 明虎 on 2025/02/09.
//

import WidgetKit
import AppIntents

let defaultEntity = TCEntity(
    id: noneID,
    title: "ToDo",
    workspaceIdx: 0,
    bcIdx: 0
)

struct TCEntity: AppEntity {
    static var defaultQuery = TCQuery()
        
        var id: String
        var title: String
        var workspaceIdx: Int
        var bcIdx: Int
        var scIdx: Int?

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

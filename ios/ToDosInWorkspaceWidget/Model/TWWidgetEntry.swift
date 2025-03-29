//
//  TWWidgetEntry.swift
//  Runner
//
//  Created by akitora.hayashi on 2025/03/29.
//

import WidgetKit

struct TWWidgetEntry: TimelineEntry {
    let date: Date
    let entity: TWAppEntity?
    let selectedThemeType: TLThemeType
    let tlWorkspaces: [TLWorkspace]
}

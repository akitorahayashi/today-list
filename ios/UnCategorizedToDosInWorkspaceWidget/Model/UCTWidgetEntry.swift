//
//  UCTWidgetEntry.swift
//  Runner
//
//  Created by 林明虎 on 2025/02/28.
//

import WidgetKit

struct UCTWidgetEntry: TimelineEntry {
    let date: Date
    let entity: UCTAppEntity?
    let selectedThemeType: TLThemeType
    let tlWorkspaces: [TLWorkspace]
}

//
//  TTWidgetEntry.swift
//  Runner
//
//  Created by akitora.hayashi on 2025/03/29.
//

import WidgetKit

struct TTWidgetEntry: TimelineEntry {
    let date: Date
    let selectedThemeType: TLThemeType
    let tlWorkspaces: [TLWorkspace]
}

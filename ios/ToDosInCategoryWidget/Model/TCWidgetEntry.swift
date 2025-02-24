//
//  TLWidgetEntry.swift
//  Runner
//
//  Created by 林 明虎 on 2025/02/09.
//

import WidgetKit

struct TCWidgetEntry: TimelineEntry {
    let date: Date
    let entity: TCEntity
    let selectedThemeType: TLThemeType
    // デコードや読み取り失敗時にnilとなる
    let tlWorkspaces: [TLWorkspace]?
}

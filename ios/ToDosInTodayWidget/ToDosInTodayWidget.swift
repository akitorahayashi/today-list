//
//  ToDosInTodayWidget.swift
//  ToDosInTodayWidget
//
//  Created by 林明虎 on 2025/03/12.
//

import WidgetKit
import SwiftUI

struct ToDosInTodayWidget: Widget {
    static let kind: String = "ToDosInWorkspaceWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: ToDosInTodayWidget.kind, provider: TTProvider()) { entry in
            ToDosInTodayWidgetEntryView(entry: entry)
                .containerBackground(.fill.tertiary, for: .widget)
        }
        .supportedFamilies([.systemLarge])
    }
}

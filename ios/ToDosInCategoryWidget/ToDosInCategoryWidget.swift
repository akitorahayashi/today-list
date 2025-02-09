//
//  ToDosInCategoryWidget.swift
//  ToDosInCategoryWidget
//
//  Created by 林 明虎 on 2025/02/09.
//

import WidgetKit
import SwiftUI


struct ToDosInCategoryWidgetEntryView : View {

    var body: some View {
        VStack {

        }
    }
}

struct ToDosInCategoryWidget: Widget {
    let kind: String = "ToDosInCategoryWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind) { entry in
            if #available(iOS 17.0, *) {
                ToDosInCategoryWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                ToDosInCategoryWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

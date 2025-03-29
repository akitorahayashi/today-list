//
//  ToDosInTodayWidget.swift
//  ToDosInTodayWidget
//
//  Created by 林明虎 on 2025/03/12.
//

import WidgetKit
import SwiftUI

struct ToDosInTodayWidget: Widget {
    static let kind: String = "ToDosInTodayWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: ToDosInTodayWidget.kind, provider: TTProvider()) { entry in
            ToDosInTodayWidgetEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    VStack(spacing: 0) {
                        ZStack {
                            entry.selectedThemeType.config.gradientOfTopBar
                            Text("Today List")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(entry.selectedThemeType.config.navigationTitleColor)
                        }
                        .frame(height: 28)
                        
                        ZStack {
                            entry.selectedThemeType.config.backgroundColorOfToDoList
                            
                            Color.white
                                .cornerRadius(15)
                                .padding(6)
                                .shadow(radius: 1)
                        }
                    }
                }
                .widgetURL(URL(string: "todaylist:/"))
        }
        .configurationDisplayName("Today's ToDos Widget")
        .description("Show your today's ToDo list in a beautiful widget.")
        .supportedFamilies([.systemLarge])
    }
}

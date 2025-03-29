//
//  ToDosInWorkspaceWidget.swift
//  ToDosInWorkspaceWidget
//
//  Created by 林明虎 on 2025/02/28.
//

import WidgetKit
import SwiftUI
import AppIntents

// メインウィジェット定義
struct ToDosInWorkspaceWidget: Widget {
    static let kind: String = "ToDosInWorkspaceWidget"

        var body: some WidgetConfiguration {
            AppIntentConfiguration(kind: ToDosInWorkspaceWidget.kind, intent: TWWorkspaceSelectionAppIntent.self, provider: TWProvider()) { entry in
                TWEntryView(entry: entry)
                    .containerBackground(for: .widget) {
                        VStack(spacing: 0) {
                            ZStack {
                                entry.selectedThemeType.config.gradientOfTopBar
                                Text(entry.entity?.name ?? entry.tlWorkspaces.first!.name)
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
                    .widgetURL(URL(string: "todaylist://workspace?id=\(entry.entity?.workspaceID ?? entry.tlWorkspaces.first!.id)"))
            }
            .configurationDisplayName("Show Uncategorized ToDos Widget")
            .description("Show an uncategorized ToDo list in a workspace. After placing the widget, long press to edit and select the workspace you want to display.")
            .supportedFamilies([.systemSmall, .systemMedium])
        }
}

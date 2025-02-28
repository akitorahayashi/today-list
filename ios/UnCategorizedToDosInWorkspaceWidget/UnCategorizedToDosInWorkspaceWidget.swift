//
//  UnCategorizedToDosInWorkspaceWidget.swift
//  UnCategorizedToDosInWorkspaceWidget
//
//  Created by 林明虎 on 2025/02/28.
//

import WidgetKit
import SwiftUI

struct UnCategorizedToDosInWorkspaceWidget: Widget {
    static let kind: String = "UnCategorizedToDosInWorkspaceWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: UnCategorizedToDosInWorkspaceWidget.kind, intent: WorkspaceSelectionAppIntent.self, provider: UCTProvider()) { entry in
            UCTEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    VStack(spacing: 0) {
                        ZStack {
                            entry.selectedThemeType.config.gradientOfTopBar
                            Text(entry.entity?.name ?? entry.tlWorkspaces.first!.name)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
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
        }
        .configurationDisplayName("Show Uncategorized ToDos Widget")
        .description("Show an uncategorized ToDo list in a workspace. After placing the widget, long press to edit and select the workspace you want to display.")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}


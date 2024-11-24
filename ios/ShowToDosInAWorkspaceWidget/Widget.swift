//
//  ShowToDosInAWorkspaceWidget.swift
//  ShowToDosInAWorkspaceWidget
//
//  Created by 林 明虎 on 2024/10/05.
//

import WidgetKit
import SwiftUI



struct ShowToDosInAWorkspaceWidget: Widget {
    let kind: String = "ShowToDosInAWorkspaceWidget"
    
    var body: some WidgetConfiguration {
        
        AppIntentConfiguration(kind: kind, intent: TLWidgetKitSettingsIntent.self, provider: TLProvider()) { entry in
            
            ShowToDosInAWorkspaceWidgetEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    VStack(spacing: 0) {
                        ZStack {
                            // テーマの適用
                            kTLThemes[entry.selectedThemeIdx].gradientOfTopBar
                            Text(entry.entity.title)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                        }.frame(height: 28)
                        ZStack {
                            kTLThemes[entry.selectedThemeIdx].backgroundColorOfToDoList
                            Color.white
                                .cornerRadius(15) // 角を10ポイント丸める
                                .padding(6)        // 周囲に余白をつける
                                .shadow(radius: 1)
                        }
                    }
                    
                }
        }
        .configurationDisplayName("Show ToDo Widget")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

//#Preview(as: .systemSmall) {
//    ShowToDosInAWorkspaceWidget()
//} timeline: {
//    SimpleEntry(date: .now, selectedThemeIdx: 0, tlWorkspaces: TLWorkspace.decodeWorkspaces(from: kTLContentExample) ?? [])
//}

//#Preview(as: .systemMedium) {
//    ShowToDosInAWorkspaceWidget()
//} timeline: {
//    SimpleEntry(date: .now, selectedThemeIdx: 0, tlWorkspaces: TLWorkspace.decodeWorkspaces(from: kTLContentExample) ?? [])
//}

//#Preview(as: .systemLarge) {
//    ShowToDosInAWorkspaceWidget()
//} timeline: {
//    SimpleEntry(date: .now, configuration: TLWidgetKitSettingsIntent(), selectedThemeIdx: 0, tlWorkspaces: TLWorkspace.decodeWorkspaces(from: kTLContentExample) ?? [])
//}

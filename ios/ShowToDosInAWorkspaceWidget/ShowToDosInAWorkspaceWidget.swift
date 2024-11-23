//
//  ShowToDosInAWorkspaceWidget.swift
//  ShowToDosInAWorkspaceWidget
//
//  Created by 林 明虎 on 2024/10/05.
//

import WidgetKit
import SwiftUI

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), tlContentExample: nil)
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), tlContentExample: kTLContentExample)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        entries.append(SimpleEntry(date: Date(), tlContentExample: nil))
        
        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let tlContentExample: String?
}

struct ShowToDosInAWorkspaceWidget: Widget {
    let kind: String = "ShowToDosInAWorkspaceWidget"

    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            // UserDefaultsからテーマを取得
            let selectedThemeIdx: Int = UserDefaults(suiteName: "group.akitorahayashi.todayListGroup")?.integer(forKey: "selectedThemeIdx") ?? 0

            ShowToDosInAWorkspaceWidgetEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    VStack(alignment: .center, spacing: 0) {
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                            // テーマの適用
                            kTLThemes[selectedThemeIdx].gradientOfTopBar
                            Text("ToDo")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .frame(height: 28)
                        kTLThemes[selectedThemeIdx].backgroundColorOfToDoList
                    }
                }
        }
        .configurationDisplayName("Show ToDo Widget")
        .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}

//#Preview(as: .systemSmall) {
//    ShowToDoWidget()
//} timeline: {
//    SimpleEntry(date: .now, contentsToShow: contentsToShow)
//}

//#Preview(as: .systemMedium) {
//    ShowToDoWidget()
//} timeline: {
//    SimpleEntry(date: .now, contentsToShow: contentsToShow)
//}

#Preview(as: .systemLarge) {
    ShowToDosInAWorkspaceWidget()
} timeline: {
    SimpleEntry(date: .now, tlContentExample: kTLContentExample)
}

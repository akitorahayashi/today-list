//
//  ShowToDoWidget.swift
//  ShowToDoWidget
//
//  Created by 林 明虎 on 2024/09/05.
//

import WidgetKit
import SwiftUI



struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), tlContents: nil)
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        SimpleEntry(date: Date(), tlContents: tlContents)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        entries.append(SimpleEntry(date: Date(), tlContents: nil))
        
        return Timeline(entries: entries, policy: .atEnd)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let tlContents: String?
}


struct ShowToDoWidgetEntryView : View {
    var entry: Provider.Entry
    
    @State private var tLToDosData: TLToDos? = nil
    
    // @Environmentを使ってWidgetFamilyを取得
    @Environment(\.widgetFamily) var widgetFamily
    
    // ウィジェットサイズに応じたtopPaddingを返す関数
    private func topPaddingOfToDoList(for family: WidgetFamily) -> CGFloat {
        switch family {
        case .systemLarge:
            return 21
        default:
            return 18
        }
    }
    
    var body: some View {
        GeometryReader { geometry in
            // ToDoリストの表示
            ToDoListView(tLToDosData: tLToDosData)
                .padding(.top, topPaddingOfToDoList(for: widgetFamily))
        }.onAppear {
            // UserDefaultsからデータを取得してtLToDosDataに代入
            tLToDosData = TLToDos.extractToDos(
                from: entry.tlContents ?? UserDefaults(suiteName: "group.akitora0703.todo")?.string(forKey: "idToJsonWorkspaceList") ?? nil,
                workspaceCategoryId: noneId,
                toDosCategoryId: noneId,
                indexInStringWorkspaces: 0
            )
        }
    }
}



struct ShowToDoWidget: Widget {
    let kind: String = "ShowToDoWidget"
    
    @State private var selectedColorTheme: String = UserDefaults(suiteName: "group.akitora0703.todo")?.string(forKey: "selectedTheme") ?? "Sun Orange"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind, intent: ConfigurationAppIntent.self, provider: Provider()) { entry in
            ShowToDoWidgetEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    VStack(alignment: .center, spacing: 0) {
                        ZStack(alignment: Alignment(horizontal: .center, vertical: .center)) {
                            tlThemeColor[selectedColorTheme]!.gradientOfTopBar
                            Text("ToDo")
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                        }.frame(height: 28)
                        tlThemeColor[selectedColorTheme]!.backgroundColorOfToDoList
                    }
                }
        }.configurationDisplayName("Show ToDo Widget")
            .description("デフォルトWorkspaceのなしカテゴリーに登録されているToDoを表示します")
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
    ShowToDoWidget()
} timeline: {
    SimpleEntry(date: .now, tlContents: tlContents)
}

import WidgetKit
import SwiftUI

struct ShowToDosInAWorkspaceWidgetEntryView : View {
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
        GeometryReader { _ in
            // ToDoリストの表示
            TLToDoListView(tLToDosData: tLToDosData)
                .padding(.top, topPaddingOfToDoList(for: widgetFamily))
        }.onAppear {
            // UserDefaultsからデータを取得してtLToDosDataに代入
            tLToDosData = TLToDos.extractToDos(
                from: entry.tlContentExample ?? UserDefaults(suiteName: "group.akitorahayashi.todayListGroup")?.string(forKey: "jsonWorksapces"),
                toDosCategoryId: noneId,
                indexInStringWorkspaces: 0
            )
        }
    }
}

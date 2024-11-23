import WidgetKit
import SwiftUI

struct ShowToDosInAWorkspaceWidgetEntryView : View {
    var entry: Provider.Entry
    
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
        VStack {
            // ToDoリストの表示
//            TLToDoListView(entry: entry)
//                .padding(.top, topPaddingOfToDoList(for: widgetFamily))
        }
        
    }
}


#Preview(as: .systemSmall) {
    ShowToDosInAWorkspaceWidget()
} timeline: {
    SimpleEntry(date: .now, selectedThemeIdx: 0, tlWorkspaces: TLWorkspace.decodeWorkspaces(from: kTLContentExample) ?? [])
}


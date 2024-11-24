import WidgetKit
import SwiftUI

struct TLToDoListView: View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            let toDosInToday = entry.tlWorkspaces[0].categoryIDToToDos[noneID]!
                .toDosInToday.filter { !$0.isChecked }
            
            // 表示する最大アイテム数
            let maxItems = {
                switch widgetFamily {
                case .systemLarge:
                    return 14
                default:
                    return 5
                }
            }()
            
            // コンテンツを格納する配列
            let contentsToShow: [TLToDo] = {
                var contentCounter = 0
                var contents = [TLToDo]()
                
                for tlToDo in toDosInToday {
                    if contentCounter >= maxItems { break }
                    
                    var createdToDo = TLToDo(id:tlToDo.id, title: tlToDo.title, isChecked: false, steps: [])
                    contentCounter += 1
                    
                    for tlStep in tlToDo.steps {
                        if contentCounter >= maxItems { break }
                        if !tlStep.isChecked {
                            createdToDo.steps.append(tlStep)
                            contentCounter += 1
                        }
                    }
                    
                    contents.append(createdToDo)
                    
                }
                
                return contents
            }()
            
            let spacing: Double = {
                switch widgetFamily {
                case .systemLarge:
                    return 3.0
                default:
                    return 4.0
                }
            }()
            
            ForEach(contentsToShow) { tlToDoData in
                TLToDoRow(spacing: spacing,tlToDoData: tlToDoData)
                    .padding(.bottom, spacing)
            }
            
            Spacer()
            
            
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
//        .background(Color.red)
        .padding(.top, 27)
    }
}


#Preview(as: .systemLarge) {
    ShowToDosInAWorkspaceWidget()
} timeline: {
    SimpleEntry(date: .now, configuration: TLWidgetKitSettingsIntent(), selectedThemeIdx: 0, tlWorkspaces: TLWorkspace.decodeWorkspaces(from: kTLContentExample) ?? [])
}

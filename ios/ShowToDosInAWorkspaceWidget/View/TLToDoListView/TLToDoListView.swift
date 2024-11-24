//
//  EntryView.swift
//  Runner
//
//  Created by 林 明虎 on 2024/11/24.
//

import WidgetKit
import SwiftUI

struct TLToDoListView: View {
    var entry: TLProvider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    
    
    var body: some View {
        VStack(alignment: .leading) {
            
            let wksEntity: TLWidgetKitSettingsEntity = entry.entity
            
            let corrWorkspace: TLWorkspace = entry.tlWorkspaces[wksEntity.workspaceIdx]
            
            var corrCategoryID = {
                let corrBC = corrWorkspace.bigCategories[wksEntity.bcIdx]
                if (wksEntity.scIdx == nil) {
                    return corrBC.id
                } else {
                    let corrSC = corrWorkspace.smallCategories[corrBC.id]![wksEntity.scIdx!]
                    return corrSC.id
                }
            }()
            
            let toDosInToday = corrWorkspace.categoryIDToToDos[corrCategoryID]!
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
    TLWidgetEntry(date: .now, entity: defaultEntity, selectedThemeIdx: 0, tlWorkspaces: TLWorkspace.decodeWorkspaces(from: kTLContentExample) ?? [])
}

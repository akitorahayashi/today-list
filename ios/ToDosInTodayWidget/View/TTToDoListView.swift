//
//  TTToDoListView.swift
//  Runner
//
//  Created by akitora.hayashi on 2025/03/29.
//

import SwiftUI
import WidgetKit

struct TTToDoListView: View {
    var entry: TTProvider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        VStack(alignment: .leading) {
            
            ForEach(entry.tlWorkspaces) { workspace in
                
            }
            
            
            let maxItems = 13
            let spacing: CGFloat = 1.6
            
            let contentsToShow = getContentsToShow(toDosInToday: toDosInToday, maxItems: maxItems)
            
            ForEach(contentsToShow) { tlToDoData in
                TLToDoRowForWidget(spacing: spacing, tlToDoData: tlToDoData, textColor: textColor)
                    .padding(.bottom, spacing)
            }
            Spacer()
                
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.top, 25.5)
    }
    
    private func getContentsToShow(toDosInToday: [TLToDo], maxItems: Int) -> [TLToDo] {
        var contentCounter = 0
        var contents: [TLToDo] = []
        
        for tlToDo in toDosInToday {
            guard contentCounter < maxItems else { break }
            
            var createdToDo = TLToDo(id: tlToDo.id, workspaceID: tlToDo.workspaceID, isInToday: true, isChecked: false, content: tlToDo.content, steps: [])
            contentCounter += 1
            
            for tlStep in tlToDo.steps {
                guard contentCounter < maxItems else { break }
                
                if !tlStep.isChecked {
                    createdToDo.steps.append(tlStep)
                    contentCounter += 1
                }
            }
            contents.append(createdToDo)
        }
        return contents
    }
}

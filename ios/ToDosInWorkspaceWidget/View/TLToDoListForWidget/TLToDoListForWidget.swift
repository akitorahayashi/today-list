//
//  TLToDoListForWidget.swift
//  Runner
//
//  Created by akitora.hayashi on 2025/03/29.
//

import SwiftUI
import WidgetKit

struct TLToDoListForWidgetView: View {
    let toDosInToday: [TLToDo]
    let widgetFamily: WidgetFamily
    let textColor: Color
    
    init(toDosInToday: [TLToDo], widgetFamily: WidgetFamily, textColor: Color = .black) {
        self.toDosInToday = toDosInToday
        self.widgetFamily = widgetFamily
        self.textColor = textColor
    }
    
    var body: some View {
        let maxItems = widgetFamily == .systemLarge ? 13 : 5
        let spacing: CGFloat = widgetFamily == .systemLarge ? 1.6 : 1.3
        
        let contentsToShow = getContentsToShow(toDosInToday: toDosInToday, maxItems: maxItems)
        
        ForEach(contentsToShow) { tlToDoData in
            TLToDoRowForWidget(spacing: spacing, tlToDoData: tlToDoData, textColor: textColor)
                .padding(.bottom, spacing)
        }
        Spacer()
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

//
//  UCTToDoListView.swift
//  Runner
//
//  Created by 林明虎 on 2025/02/28.
//

import SwiftUI
import WidgetKit

struct UCTToDoListView: View {
    var entry: UCTProvider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        VStack(alignment: .leading) {
            let utcEntity = entry.entity
            
            let corrWorkspace: TLWorkspace = TLWorkspace.getWorkspace(from: entry.tlWorkspaces, by: utcEntity?.workspaceID ?? entry.tlWorkspaces.first!.id)!
            
            let toDosInToday = (corrWorkspace.categoryIDToToDos[corrWorkspace.id]!.toDosInToday.filter { !$0.isChecked })
            
            ToDoListView(toDosInToday: toDosInToday, widgetFamily: widgetFamily)
                
        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.top, 25.5)
    }
    
    // MARK: - ToDo リスト表示 View
    private struct ToDoListView: View {
        let toDosInToday: [TLToDo]
        let widgetFamily: WidgetFamily
        
        var body: some View {
            let maxItems = widgetFamily == .systemLarge ? 14 : 5
            let spacing: CGFloat = widgetFamily == .systemLarge ? 3.0 : 2.0
            
            let contentsToShow = getContentsToShow(toDosInToday: toDosInToday, maxItems: maxItems)
            
            ForEach(contentsToShow) { tlToDoData in
                UCTToDoRow(spacing: spacing, tlToDoData: tlToDoData)
                    .padding(.bottom, spacing)
            }
            Spacer()
        }
        
        private func getContentsToShow(toDosInToday: [TLToDo], maxItems: Int) -> [TLToDo] {
            var contentCounter = 0
            var contents: [TLToDo] = []
            
            for tlToDo in toDosInToday {
                guard contentCounter < maxItems else { break }
                
                var createdToDo = TLToDo(id: tlToDo.id, workspaceID: tlToDo.workspaceID, categoryID: tlToDo.categoryID, isInToday: true, isChecked: false, content: tlToDo.content, steps: [])
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
    
    // MARK: - 設定がない場合の View
    private struct NoSettingsView: View {
        let message: String
        let widgetFamily: WidgetFamily
        
        var body: some View {
            VStack {
                Spacer()
                Text("⚠️ \(message)")
                    .font(.system(size: widgetFamily == .systemSmall ? 12 : 14, weight: .bold))
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                
                if widgetFamily != .systemSmall {
                    Text("No settings available")
                        .font(.system(size: 10))
                        .foregroundColor(.gray)
                        .padding(.top, 4)
                }
                
                Spacer()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
    }
}

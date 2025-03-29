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
            let spacing: CGFloat = 1.3
            let maxItems = 13
            
            let displayData = getWorkspacesAndToDosToShow(workspaces: entry.tlWorkspaces, maxItems: maxItems)
            
            ForEach(Array(displayData.workspaces.enumerated()), id: \.element.id) { _, workspace in
                ZStack(alignment: .leading) {
                    entry.selectedThemeType.config.gradientOfTopBar
                        .cornerRadius(12)
                    
                    Text(workspace.name)
                        .font(.system(size: 13))
                        .fontWeight(.bold)
                        .foregroundColor(entry.selectedThemeType.config.navigationTitleColor)
                        .padding(.vertical, 0)
                        .padding(.horizontal, 10)
                }
                .fixedSize(horizontal: true, vertical: false)
                .frame(height: 16)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.gray.opacity(0.2), lineWidth: 0.5)
                )
                .padding(.bottom, spacing)
                ForEach(Array(workspace.toDos.enumerated()), id: \.element.id) { _, todo in
                    TLToDoRowForWidget(
                        spacing: spacing,
                        tlToDoData: todo,
                        textColor: entry.selectedThemeType.config.textColor
                    )
                    .padding(.bottom, spacing)
                }
            }
            
            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.top, 24)
    }
    
    private struct WorkspaceWithToDos: Identifiable {
        let id: String
        let name: String
        let toDos: [TLToDo]
    }
    
    private struct DisplayContent {
        let workspaces: [WorkspaceWithToDos]
    }
    
    private func getWorkspacesAndToDosToShow(workspaces: [TLWorkspace], maxItems: Int) -> DisplayContent {
        var itemCount = 0
        var result: [WorkspaceWithToDos] = []
        
        for workspace in workspaces {
            guard itemCount < maxItems else { break }
            
            // Workspace name counts as one item
            itemCount += 1
            
            let toDosInToday = workspace.toDos.toDosInToday
            var workspaceToDos: [TLToDo] = []
            
            for todo in toDosInToday {
                guard itemCount < maxItems else { break }
                
                // チェック済みのToDoは表示しない
                if todo.isChecked { continue }
                
                var createdToDo = TLToDo(
                    id: todo.id,
                    workspaceID: todo.workspaceID,
                    isInToday: true,
                    isChecked: false,
                    content: todo.content,
                    steps: []
                )
                
                itemCount += 1
                
                for step in todo.steps {
                    guard itemCount < maxItems else { break }
                    
                    if !step.isChecked {
                        createdToDo.steps.append(step)
                        itemCount += 1
                    }
                }
                
                workspaceToDos.append(createdToDo)
            }
            
            if !workspaceToDos.isEmpty {
                result.append(WorkspaceWithToDos(
                    id: workspace.id,
                    name: workspace.name,
                    toDos: workspaceToDos
                ))
            } else {
                // If no ToDos were added, decrement the counter for the workspace name
                itemCount -= 1
            }
        }
        
        return DisplayContent(workspaces: result)
    }
    
    private func getContentsToShow(toDosInToday: [TLToDo], maxItems: Int) -> [TLToDo] {
        var contentCounter = 0
        var contents: [TLToDo] = []
        
        for tlToDo in toDosInToday {
            guard contentCounter < maxItems else { break }
            
            // チェック済みのToDoは表示しない
            if tlToDo.isChecked { continue }
            
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

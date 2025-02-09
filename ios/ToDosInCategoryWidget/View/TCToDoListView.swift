//
//  TCToDoListView.swift
//  Runner
//
//  Created by 林 明虎 on 2025/02/09.
//

import SwiftUI

struct TCToDoListView: View {
    var entry: TCProvider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        VStack(alignment: .leading) {
            let wksEntity = entry.entity
            let corrWorkspace = TLWorkspace.getWorkspace(from: entry.tlWorkspaces, by: wksEntity.workspaceID)
            
            if let workspace = corrWorkspace {
                // MARK: - 正常時の UI
                let corrCategoryID: String = wksEntity.categoryID
                
                let toDosInToday = workspace.categoryIDToToDos[corrCategoryID]?
                    .toDosInToday.filter { !$0.isChecked } ?? []
                
                // 表示する最大アイテム数
                let maxItems: Int = {
                    switch widgetFamily {
                    case .systemLarge:
                        return 14
                    default:
                        return 5
                    }
                }()
                
                // ToDoとStepをまとめて上限まで並べる
                let contentsToShow: [TLToDo] = {
                    var contentCounter = 0
                    var contents: [TLToDo] = []
                    
                    for tlToDo in toDosInToday {
                        guard contentCounter < maxItems else { break }
                        
                        var createdToDo = TLToDo(id: tlToDo.id,
                                                 title: tlToDo.title,
                                                 isChecked: false,
                                                 steps: [])
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
                }()
                
                let spacing: CGFloat = {
                    switch widgetFamily {
                    case .systemLarge:
                        return 3.0
                    default:
                        return 4.0
                    }
                }()
                
                // ToDo本体とそのStepを順に表示
                ForEach(contentsToShow) { tlToDoData in
                    TCToDoRow(spacing: spacing, tlToDoData: tlToDoData)
                        .padding(.bottom, spacing)
                }
                
                Spacer()
            } else {
                // MARK: - エラー時の UI
                VStack {
                    Spacer()
                    Text("⚠️ ワークスペースが見つかりません")
                        .font(.system(size: 14, weight: .bold))
                        .padding()
                        .cornerRadius(10)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(Color.gray.opacity(0.2))
            }
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .topLeading)
        .padding(.top, 27)
    }
}

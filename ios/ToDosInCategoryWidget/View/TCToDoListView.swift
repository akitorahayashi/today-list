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
            
            // `tlWorkspaces` が `nil` の場合のフォールバック UI
            if let workspaces = entry.tlWorkspaces,
                let wksEntity = wksEntity {
                
                // 設定のidに対して
                let corrWorkspace = TLWorkspace.getWorkspace(from: workspaces, by: wksEntity.workspaceID)
                
                if let workspace = corrWorkspace,
                    let toDosInToday =
                    (workspace.categoryIDToToDos[wksEntity.categoryID]?
                        .toDosInToday.filter { !$0.isChecked }) {
                    
                    // MARK: - 正常時の UI
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
                            guard contentCounter < maxItems else {
                                break }
                            
                            var createdToDo = TLToDo(id: tlToDo.id,
                                                     workspaceID: tlToDo.workspaceID,
                                                     categoryID: tlToDo.categoryID,
                                                     isInToday: true,
                                                     isChecked: false,
                                                     content: tlToDo.content,
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
                            return 2.0
                        }
                    }()
                    
                    // ToDo本体とそのStepを順に表示
                    ForEach(contentsToShow) { tlToDoData in
                        TCToDoRow(spacing: spacing, tlToDoData: tlToDoData)
                            .padding(.bottom, spacing)
                    }
                    
                    Spacer()
                } else {
                    // MARK: - エラー時の UI（ワークスペースが見つからない場合）
                    VStack {
                        Spacer()
                        Text("⚠️ 設定に対してデータがありません")
                            .font(.system(size: 14, weight: .bold))
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                        
                        Text("ウィジェットの設定を確認してください")
                            .font(.system(size: 12))
                            .foregroundColor(.gray)
                            .padding(.top, 4)
                        
                        Spacer()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            } else {
                // MARK: - データ取得エラー
                VStack {
                    Spacer()
                    Text("⚠️ データを取得できません")
                        .font(.system(size: 14, weight: .bold))
                        .padding()
                        .background(Color.gray.opacity(0.2))
                        .foregroundStyle(.gray)
                        .cornerRadius(10)
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .frame(maxWidth: .infinity,
               maxHeight: .infinity,
               alignment: .topLeading)
        .padding(.top, 27)
    }
}

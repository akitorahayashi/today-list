//
//  TCToDoListView.swift
//  Runner
//
//  Created by 林 明虎 on 2025/02/09.
//

import SwiftUI
import WidgetKit

struct TCToDoListView: View {
    var entry: TCProvider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        VStack(alignment: .leading) {
            let wksEntity = entry.entity
            
            // Workspaces のが存在するか
            if let wksEntity = wksEntity {
                // WorkspaceID に紐づく Workspace の取得に成功するか
                if let workspace = TLWorkspace.getWorkspace(from: entry.tlWorkspaces, by: wksEntity.workspaceID),
                   let toDosInToday = (workspace.categoryIDToToDos[wksEntity.categoryID]?.toDosInToday.filter { !$0.isChecked }) {
                    TLToDoListForWidgetView(toDosInToday: toDosInToday, widgetFamily: widgetFamily)
                } else {
                    // Workspaces と 設定した設定データ が不整合
                    NoSettingsView(message: "Reconfigure the settings", widgetFamily: widgetFamily)
                }
            } else {
                // 設定が未登録の場合の UI
                NoSettingsView(message: "Long press to edit", widgetFamily: widgetFamily)
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
        .padding(.top, 25.5)
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

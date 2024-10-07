//
//  ShowToDosInAWorkspaceInTodayView.swift
//  Runner
//
//  Created by 林 明虎 on 2024/10/07.
//

import SwiftUI

struct ShowToDosInTodayInAWorkspaceView: View {
    
    var tlWorkspace: TLWorkspace
    
    @ObservedObject var tlConnector = TLPhoneConnector()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            TLWatchAppBar(appbarTitle: "todo",selectedColorTheme: self.tlConnector.selectedTheme)
            
            ScrollView {
                // BigCategoryに対応するToDosを取り出して表示
                ForEach(tlWorkspace.bigCategories, id: \.id) { bigCategory in
                    TLBigcategorySection(tlWorkspace: tlWorkspace, corrBigCategory: bigCategory)
                }
            }
        }
    }
}

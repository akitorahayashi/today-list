//
//  TLBigcatgeorySection.swift
//  Runner
//
//  Created by 林 明虎 on 2024/10/07.
//

import SwiftUI

struct TLBigcategorySection: View {
    
    var tlWorkspace: TLWorkspace
    var corrBigCategory: TLCategory
    
    var body: some View {
        VStack {
            // 大カテゴリのヘッダーを表示
            if corrBigCategory.id != "---n" {
                Section(header: Text(corrBigCategory.title)) {
                    ShowToDosForCategory(tlWorkspace: tlWorkspace, categoryId: corrBigCategory.id)
                }
            } else {
                // ヘッダーなしでToDosを表示
                ShowToDosForCategory(tlWorkspace: tlWorkspace, categoryId: corrBigCategory.id)
            }
            
            // 対応する小カテゴリーを大カテゴリーの下に表示
            if let smallCategories = tlWorkspace.smallCategories[corrBigCategory.id] {
                ForEach(smallCategories, id: \.id) { smallCategory in
                    if smallCategory.id != "---n" {
                        Section(header: Text(smallCategory.title)) {
                            ShowToDosForCategory(tlWorkspace: tlWorkspace, categoryId: smallCategory.id)
                        }
                    } else {
                        // ヘッダーなしでToDosを表示
                        ShowToDosForCategory(tlWorkspace: tlWorkspace, categoryId: smallCategory.id)
                    }
                }
            }
        }
    }
}

//
//  ShowToDoWidgetEntryView.swift
//  ShowToDoWidgetExtension
//
//  Created by 林 明虎 on 2024/09/06.
//

import SwiftUI
import WidgetKit

struct ShowToDoWidgetEntryView: View {
    var entry: Provider.Entry
    let tLToDosData: TLToDos?
    
    var body: some View {
        VStack(spacing: 0) {
            // カテゴリー名の表示
            ZStack {
                Color.orange
                    .frame(maxWidth: .infinity, maxHeight: 40)
                Text("買い物")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
            
            Divider()
            
            // ToDoリストの表示
            ToDoListView(tLToDosData: tLToDosData)
                .padding()
                .background(Color(red: 1.0, green: 1.0, blue: 0.8)) // 背景色を黄色に設定
        }
        .padding()
    }
}

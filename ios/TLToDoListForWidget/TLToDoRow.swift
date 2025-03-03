//
//  TLToDoRow.swift
//  Runner
//
//  Created by 林明虎 on 2025/03/02.
//

import SwiftUI

// RowのTextStyle
struct ToDoTextStyle: ViewModifier {
    let isToDo: Bool
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 13))
            .lineLimit(1)
            .truncationMode(.tail)
            .fontWeight(.bold)
            .opacity(0.6)
            .foregroundColor(.black)
    }
}

// Viewにモディファイアを追加
extension View {
    func toDoTextStyle(isToDo: Bool) -> some View {
        self.modifier(ToDoTextStyle(isToDo: isToDo))
    }
}

struct TLToDoRowForWidget: View {
    let spacing: Double
    let tlToDoData: TLToDo
    
    var body: some View {
        VStack(alignment: .leading) {
            // メインカード（ToDoのタイトル）
            HStack {
                // チェックマークアイコン
                Image(systemName: "square")
                    .toDoTextStyle(isToDo: true)
                // タイトル
                Text(tlToDoData.content)
                    .toDoTextStyle(isToDo: true)
            }
            .padding(.bottom, spacing)
            // ステップカード（ToDoに含まれるStep）
            ForEach(tlToDoData.steps) { step in
                HStack {
                    Image(systemName: "square")
                        .toDoTextStyle(isToDo: false)
                    
                    Text(step.content)
                        .toDoTextStyle(isToDo: false)
                    
                }
            }
            .padding(.leading, 10)
            .padding(.bottom, spacing)
            
        }
    }
}

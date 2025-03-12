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
    let textColor: Color
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 13))
            .lineLimit(1)
            .truncationMode(.tail)
            .fontWeight(.bold)
            .opacity(0.6)
            .foregroundColor(textColor)
    }
}

// Viewにモディファイアを追加
extension View {
    func toDoTextStyle(isToDo: Bool, textColor: Color = .black) -> some View {
        self.modifier(ToDoTextStyle(isToDo: isToDo, textColor: textColor))
    }
}

struct TLToDoRowForWidget: View {
    let spacing: Double
    let tlToDoData: TLToDo
    let textColor: Color
    
    init(spacing: Double, tlToDoData: TLToDo, textColor: Color = .black) {
        self.spacing = spacing
        self.tlToDoData = tlToDoData
        self.textColor = textColor
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            // メインカード（ToDoのタイトル）
            HStack {
                // チェックマークアイコン
                Image(systemName: "square")
                    .toDoTextStyle(isToDo: true, textColor: textColor)
                // タイトル
                Text(tlToDoData.content)
                    .toDoTextStyle(isToDo: true, textColor: textColor)
            }
            .padding(.bottom, spacing)
            // ステップカード（ToDoに含まれるStep）
            ForEach(tlToDoData.steps) { step in
                HStack {
                    Image(systemName: "square")
                        .toDoTextStyle(isToDo: false, textColor: textColor)
                    
                    Text(step.content)
                        .toDoTextStyle(isToDo: false, textColor: textColor)
                    
                }
            }
            .padding(.leading, 10)
            .padding(.bottom, spacing)
            
        }
    }
}

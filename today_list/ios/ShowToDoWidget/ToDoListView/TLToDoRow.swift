//
//  TLToDoRow.swift
//  ShowToDoWidgetExtension
//
//  Created by 林 明虎 on 2024/09/07.
//

import SwiftUI

// カスタム ViewModifier の定義
struct ToDoTextStyle: ViewModifier {
    let isToDo: Bool
    
    func body(content: Content) -> some View {
        content
            .font(.system(size: 13))
            .lineLimit(1)
            .truncationMode(.tail)
            .fontWeight(.bold)
            .opacity(0.6)
    }
}

// 使いやすいように View に拡張メソッドを追加
extension View {
    func toDoTextStyle(isToDo: Bool) -> some View {
        self.modifier(ToDoTextStyle(isToDo: isToDo))
    }
}

struct TLToDoRow: View {
    let tlToDoData: TLToDo

    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // メインカード（ToDoのタイトル）
            HStack {
                // チェックマークアイコン
                Image(systemName: "square")
                    .toDoTextStyle(isToDo: true)
                
                // タイトル
                Text(tlToDoData.title)
                    .toDoTextStyle(isToDo: true)
                
            }
            
            // ステップカード（ToDoに含まれるStep）
            
                ForEach(tlToDoData.steps
                ) { step in
                    HStack {
                        Image(systemName: "square")
                            .toDoTextStyle(isToDo: false)
                        
                        Text(step.title)
                            .toDoTextStyle(isToDo: false)
                        
                    }
                }
                .padding(.leading, 10)
            
        }.padding(.bottom, 4)
    }

    
    
}

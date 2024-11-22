//
//  ShowToDosForCategory.swift
//  Runner
//
//  Created by 林 明虎 on 2024/10/07.
//

import SwiftUI

struct ShowToDosForCategory: View {
    
    var tlWorkspace: TLWorkspace
    var categoryId: String
    
    var body: some View {
        // ToDosを取得
        if let corrToDos = tlWorkspace.toDos[categoryId] {
            VStack {
                ForEach(corrToDos.toDosInToday.indices, id: \.self) { index in
                    var toDoData = corrToDos.toDosInToday[index]
                    VStack {
                        Button(action: {
                            // チェックボックスのトグルアクションを実装
                            toDoData.isChecked.toggle()
                        }) {
                            Image(systemName: toDoData.isChecked ? "checkmark.square" : "square")
                                .resizable() // 画像をリサイズ可能にする
                                .frame(width: 20, height: 20) // 幅と高さを指定
                                .foregroundColor(.primary) // 色を設定
                        }
                        Text(toDoData.title)
                        Spacer()
                    }
                    // Cardのデザイン
                    .background(Color.blue)
                    .cornerRadius(10)
                    .shadow(radius: 5)
                    .padding(.horizontal, 4)
                }
            }.padding(.all, 4)
        } else {
            Text("Error: ToDoがありません")
        }
    }
}

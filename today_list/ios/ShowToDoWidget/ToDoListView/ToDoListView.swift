//
//  ToDoListView.swift
//  ShowToDoWidgetExtension
//
//  Created by 林 明虎 on 2024/09/06.
//

import WidgetKit
import SwiftUI

struct ToDoListView: View {
    let tLToDosData: TLToDos?
    
    
    @Environment(\.widgetFamily) var widgetFamily
    
    // ウィジェットサイズに応じたtopPaddingを返す関数
    private func bottomPaddingOfToDoList(for family: WidgetFamily) -> CGFloat {
        switch family {
        case .systemLarge:
            return 4
        default:
            return 4
        }
    }
    
    var body: some View {
        ZStack(alignment: .topLeading) {
            Color.white
                .cornerRadius(12) // 角丸
                .shadow(color: Color.black.opacity(0.2), radius: 2, x: 0, y: 0) // 影
            VStack(alignment: .leading, spacing: 4) {
                if let tLToDosData = tLToDosData {
                    
                    let toDosInToday = tLToDosData.toDosInToday.filter { !$0.isChecked }

                    // 表示する最大アイテム数
                    let maxItems = {
                        switch widgetFamily {
                        case .systemLarge:
                            return 15
                        default:
                            return 5
                        }
                    }()

                    // コンテンツを格納する配列
                    let contentsToShow: [TLToDo] = {
                        var contentCounter = 0
                        var contents = [TLToDo]()
                        
                        for tlToDo in toDosInToday {
                            if contentCounter >= maxItems { break }
                            
                            var createdToDo = TLToDo(title: tlToDo.title, isChecked: false, steps: [])
                            contentCounter += 1
                            
                            for tlStep in tlToDo.steps {
                                if contentCounter >= maxItems { break }
                                if !tlStep.isChecked {
                                    createdToDo.steps.append(tlStep)
                                    contentCounter += 1
                                }
                            }
                            
                            contents.append(createdToDo)
                            
                        }
                        
                        return contents
                    }()

                    ForEach(contentsToShow) { tlToDoData in
                        TLToDoRow(tlToDoData: tlToDoData)
                    }
                    
                } else {
                    // データが存在しない場合の表示
                    Text("アプリからデータを設定してください")
                        .font(.system(size: 14))
                        .padding()
                }
            }
            .padding(.leading, 5)
            .padding(.top, 8)
            .padding(.bottom, 300)
        }
        
    }
}

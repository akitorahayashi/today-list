//
//  TLToDos.swift
//  Runner
//
//  Created by 林 明虎 on 2024/09/06.
//

import Foundation

struct TLToDos: Codable {
    let toDosInToday: [TLToDo]
    let toDosInWhenever: [TLToDo]
    
    // JSONからToDosをデコードする関数
    static func extractToDos(from jsonIdToJsonWorkspaceList: String?, workspaceCategoryId: String, toDosCategoryId: String, indexInStringWorkspaces: Int) -> TLToDos? {
        // JSON文字列がnilでないかチェックし、データに変換
        guard let jsonString = jsonIdToJsonWorkspaceList,
              let data = jsonString.data(using: .utf8) else {
            print("無効な JSON 文字列")
            return nil
        }
        
        do {
            // JSONをデコードして、[String: [String]] 型のデータに変換
            let idToJsonWorkspaceList = try JSONDecoder().decode([String: [TLWorkspace]].self, from: data)
            
            
            // workspaceCategoryIdに基づいて、適切なWorkspaceの配列を取得
            guard let workspacesArray = idToJsonWorkspaceList[workspaceCategoryId],
                  indexInStringWorkspaces >= 0 && indexInStringWorkspaces < workspacesArray.count else {
                print("指定された workspaceCategoryId またはインデックスが無効です")
                return nil
            }
            
            let selectedWorkspace: TLWorkspace = workspacesArray[indexInStringWorkspaces]
            
            // toDosCategoryIdに基づいて、適切なTLToDosを取得
            guard let toDos: TLToDos = selectedWorkspace.toDos[toDosCategoryId] else {
                print("指定されたカテゴリIDのToDosが見つかりません")
                return nil
            }
            
            return toDos
        } catch {
            print("JSONデコード中にエラーが発生しました: \(error.localizedDescription)")
            return nil
        }
    }
    
    
    static func fromJson(_ json: String) -> [String: TLToDos]? {
        let decoder = JSONDecoder()
        // JSONデコード
        if let jsonData = json.data(using: .utf8) {
            do {
                let decodedData = try JSONDecoder().decode([String: TLToDos].self, from: jsonData)
                print("デコード成功: \(decodedData)")
                
                // デコードされた内容を使う
                if let purChaseToDoData = decodedData["purchaseId"] {
                    for todo in purChaseToDoData.toDosInToday {
                        print("Title: \(todo.title), Is Checked: \(todo.isChecked)")
                        for step in todo.steps {
                            print(" - Step: \(step.title), Is Checked: \(step.isChecked)")
                        }
                    }
                }
                return decodedData
            } catch {
                print("デコードエラー: \(error)")
                return nil
            }
            
        } else {
            print("JSONデータの生成に失敗しました")
            return nil
        }
    }
}

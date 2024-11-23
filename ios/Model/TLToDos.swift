//
//  TLToDos.swift
//  Runner
//
//  Created by 林 明虎 on 2024/11/23.
//

import SwiftUI

struct TLToDos: Codable {
    let toDosInToday: [TLToDo]
    let toDosInWhenever: [TLToDo]
    
    // JSONからToDosをデコードする関数
    static func extractToDos(from jsonWorkspaces: String?, indexInWorkspaces: Int, toDosCategoryId: String) -> TLToDos? {
        // JSON文字列がnilでないかチェックし、データに変換
        guard let jsonString = jsonWorkspaces else {
            print("exit: nil")
            return nil
        }
        
        guard let data = jsonString.data(using: .utf8) else {
            print("データ変換に失敗しました")
            return nil
        }
        
        do {
            // JSONをデコードして、[TLWorkspace] 型のデータに変換
            let tlWorkspaces = try JSONDecoder().decode([TLWorkspace].self, from: data)
            
            // インデックスが有効かどうかをチェック
            guard indexInWorkspaces >= 0 && indexInWorkspaces < tlWorkspaces.count else {
                print("指定されたインデックスが無効です")
                return nil
            }
            
            // 指定されたインデックスのワークスペースを取得
            let selectedWorkspace: TLWorkspace = tlWorkspaces[indexInWorkspaces]
            
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
}

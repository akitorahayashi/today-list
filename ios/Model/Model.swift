//
//  Model.swift
//  Runner
//
//  Created by 林 明虎 on 2025/02/09.
//

import SwiftUI

struct TLCategory: Codable {
    var id: String
    var title: String
}

struct TLToDo: Identifiable, Codable {
    var id: String
    var title: String
    var isChecked: Bool
    var steps: [TLStep]
}

struct TLStep: Identifiable, Codable {
    let id: String
    let title: String
    let isChecked: Bool
}

struct TLToDosInTodayAndWhenever: Codable {
    let toDosInToday: [TLToDo]
    let toDosInWhenever: [TLToDo]
    
    // JSONからToDosをデコードする関数
    static func extractToDos(from jsonWorkspaces: String?, indexInWorkspaces: Int, toDosCategoryId: String) -> TLToDosInTodayAndWhenever? {
        // JSONをデコード
        guard let tlWorkspaces: [TLWorkspace] = TLiOSUtils.decodeCustomList(from: jsonWorkspaces) else {
            print("exit: デコードに失敗しました")
            return nil
        }
        
        // インデックスが有効かチェック
        guard indexInWorkspaces >= 0 && indexInWorkspaces < tlWorkspaces.count else {
            print("指定されたインデックスが無効です")
            return nil
        }
        
        // 指定インデックスのワークスペースを取得
        let selectedWorkspace = tlWorkspaces[indexInWorkspaces]
        
        // 指定カテゴリIDのToDosを取得
        guard let toDos = selectedWorkspace.categoryIDToToDos[toDosCategoryId] else {
            print("指定されたカテゴリIDのToDosが見つかりません")
            return nil
        }
        
        return toDos
    }
}

struct TLWorkspace: Codable, Identifiable {
    var id: String
    var name: String
    var bigCategories: [TLCategory]
    var smallCategories: [String: [TLCategory]]
    var categoryIDToToDos: [String: TLToDosInTodayAndWhenever]
    
    // JSONからワークスペースをデコードする関数
    static func decodeWorkspaces(from jsonWorkspaces: String?) -> [TLWorkspace]? {
        return TLiOSUtils.decodeCustomList(from: jsonWorkspaces)
    }
}

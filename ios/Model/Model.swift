//
//  Model.swift
//  Runner
//
//  Created by 林 明虎 on 2025/02/09.
//

import SwiftUI

struct TLToDoCategory: Identifiable, Codable {
    let id: String
    let parentBigCategoryID: String?
    let name: String

    init(
        id: String?,
        parentBigCategoryID: String?,
        name: String
    ) {
        self.id = id ?? TLUUIDGenerator.generate()
        self.parentBigCategoryID = parentBigCategoryID
        self.name = name
    }
}

struct TLToDo: Identifiable, Codable {
    let id: String
    let workspaceID: String
    let isInToday: Bool
    var isChecked: Bool
    let content: String
    var steps: [TLStep]

    init(
        id: String = TLUUIDGenerator.generate(),
        workspaceID: String,
        isInToday: Bool,
        isChecked: Bool = false,
        content: String,
        steps: [TLStep] = []
    ) {
        self.id = id
        self.workspaceID = workspaceID
        self.isInToday = isInToday
        self.isChecked = isChecked
        self.content = content
        self.steps = steps
    }
}

struct TLStep: Identifiable, Codable {
    let id: String
    let isChecked: Bool
    let content: String

    init(
        id: String = TLUUIDGenerator.generate(),
        isChecked: Bool = false,
        content: String
    ) {
        self.id = id
        self.isChecked = isChecked
        self.content = content
    }
}

struct TLToDosInTodayAndWhenever: Codable {
    let workspaceID: String
    let toDosInToday: [TLToDo]
    let toDosInWhenever: [TLToDo]

    init(
        workspaceID: String,
        toDosInToday: [TLToDo] = [],
        toDosInWhenever: [TLToDo] = []
    ) {
        self.workspaceID = workspaceID
        self.toDosInToday = toDosInToday
        self.toDosInWhenever = toDosInWhenever
    }

    // JSONからToDosをデコードする関数
    static func extractToDos(from jsonWorkspaces: String?, indexInWorkspaces: Int, workspaceID _: String) -> TLToDosInTodayAndWhenever? {
        // JSON文字列がnilまたは空の場合、エラーを出力して終了
        guard let jsonWorkspaces = jsonWorkspaces else {
            print("TLToDosInTodayAndWhenever.extractToDos - jsonWorkspaces is nil")
            return nil
        }

        // 文字列をData型に変換できるか
        guard let data = jsonWorkspaces.data(using: .utf8) else {
            print("TLToDosInTodayAndWhenever.extractToDos - Failed to convert JSON string to Data")
            return nil
        }

        // JSONをデコード
        guard let tlWorkspaces: [TLWorkspace] = try? JSONDecoder().decode([TLWorkspace].self, from: data) else {
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

        // 指定ワークスペースのToDosを取得
        let toDos = selectedWorkspace.toDos

        return toDos
    }
}

struct TLWorkspace: Codable, Identifiable {
    var id: String
    var name: String
    var toDos: TLToDosInTodayAndWhenever

    init(
        id: String?,
        name: String,
        toDos: TLToDosInTodayAndWhenever
    ) {
        self.id = id ?? TLUUIDGenerator.generate()
        self.name = name
        self.toDos = toDos
    }

    // JSONからワークスペースをデコードする関数
    static func decodeWorkspaces(from jsonStringWorkspaces: String?) -> [TLWorkspace]? {
        // JSON文字列がnilの場合、エラーを出力して終了
        guard let jsonStringWorkspaces = jsonStringWorkspaces else {
            print("TLWorkspace.decodeWorkspaces - jsonString is nil")
            return nil
        }

        // 文字列をData型に変換できない場合
        guard let data = jsonStringWorkspaces.data(using: .utf8) else {
            print("TLWorkspace.decodeWorkspaces - Failed to convert JSON string to Data")
            return nil
        }

        // JSONデコード処理
        do {
            return try JSONDecoder().decode([TLWorkspace].self, from: data)
        } catch {
            print("decodeCustomListError: JSON decoding failed -> \(error.localizedDescription)")
            return nil
        }
    }

    // 配列からIDに一致するワークスペースを取得
    static func getWorkspace(from workspaces: [TLWorkspace], by id: String) -> TLWorkspace? {
        return workspaces.first(where: { $0.id == id })
    }
}

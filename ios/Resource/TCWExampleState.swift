//
//  TCWExampleState.swift
//  Runner
//
//  Created by 林明虎 on 2025/02/27.
//

import Foundation

enum TCWExampleState {
    enum WorkspaceID: String, Codable {
        case life = "lifeId"
        case work = "workId"
        
        var name: String {
            switch self {
            case .life: return "Life"
            case .work: return "Work"
            }
        }
    }
    
    // MARK: - kTLWorkspacesExample
    static let kTLWorkspacesExample: [TLWorkspace] = [
        // MARK: - Work Workspace
        TLWorkspace(
            id: WorkspaceID.work.rawValue,
            name: WorkspaceID.work.name,
            workspaceIDToToDos: [
                WorkspaceID.work.rawValue: TLToDosInTodayAndWhenever(
                    workspaceID: WorkspaceID.work.rawValue,
                    toDosInToday: [
                        TLToDo(
                            workspaceID: WorkspaceID.work.rawValue,
                            isInToday: true,
                            content: "Aさんとのスケジュールを調整"
                        ),
                        TLToDo(
                            workspaceID: WorkspaceID.work.rawValue,
                            isInToday: true,
                            content: "書類の作成",
                            steps: [
                                TLStep(content: "資料を用意する"),
                                TLStep(content: "送り先に送信する")
                            ]
                        ),
                        TLToDo(
                            workspaceID: WorkspaceID.work.rawValue,
                            isInToday: false,
                            content: "次回会議の資料作成",
                            steps: [
                                TLStep(content: "構成を考える"),
                                TLStep(content: "スライド作成"),
                                TLStep(content: "チームに共有")
                            ]
                        )
                    ]
                )
            ]
        ),
        
        // MARK: - Life Workspace
        TLWorkspace(
            id: WorkspaceID.life.rawValue,
            name: "Life",
            workspaceIDToToDos: [
                WorkspaceID.life.rawValue: TLToDosInTodayAndWhenever(
                    workspaceID: WorkspaceID.life.rawValue,
                    toDosInToday: [
                        TLToDo(
                            workspaceID: WorkspaceID.life.rawValue,
                            isInToday: true,
                            content: "ご飯を炊く"
                        ),
                        TLToDo(
                            workspaceID: WorkspaceID.life.rawValue,
                            isInToday: true,
                            content: "鶏むね肉の照り焼き",
                            steps: [
                                TLStep(content: "鶏むね肉"),
                                TLStep(content: "醤油"),
                                TLStep(content: "みりん"),
                                TLStep(content: "砂糖")
                            ]
                        ),
                        TLToDo(
                            workspaceID: WorkspaceID.life.rawValue,
                            isInToday: true,
                            content: "じゃがいもと玉ねぎの味噌汁",
                            steps: [
                                TLStep(content: "じゃがいも"),
                                TLStep(content: "玉ねぎ"),
                                TLStep(content: "味噌")
                            ]
                        )
                    ]
                )
            ]
        )
    ]
}

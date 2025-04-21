//
//  TCWExampleState.swift
//  Runner
//
//  Created by 林明虎 on 2025/02/27.
//

import Foundation

enum TCWExampleState {
    enum WorkspaceID: String, Codable {
        case general = "generalId"

        var name: String {
            switch self {
            case .general: return "General"
            }
        }
    }

    // MARK: - kTLWorkspacesExample

    static let kTLWorkspacesExample: [TLWorkspace] = [
        // MARK: - General Workspace

        TLWorkspace(
            id: WorkspaceID.general.rawValue,
            name: WorkspaceID.general.name,
            toDos: TLToDosInTodayAndWhenever(
                workspaceID: WorkspaceID.general.rawValue,
                toDosInToday: [
                    TLToDo(
                        workspaceID: WorkspaceID.general.rawValue,
                        isInToday: true,
                        content: "Aさんとのスケジュールを調整"
                    ),
                    TLToDo(
                        workspaceID: WorkspaceID.general.rawValue,
                        isInToday: true,
                        content: "書類の作成",
                        steps: [
                            TLStep(content: "資料を用意する"),
                            TLStep(content: "送り先に送信する"),
                        ]
                    ),
                    TLToDo(
                        workspaceID: WorkspaceID.general.rawValue,
                        isInToday: false,
                        content: "来月の旅行計画",
                        steps: [
                            TLStep(content: "宿を予約する"),
                            TLStep(content: "交通手段を調べる"),
                        ]
                    ),
                ],
                toDosInWhenever: []
            )
        ),
    ]
}

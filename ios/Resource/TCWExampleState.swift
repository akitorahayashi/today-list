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
        
        var bigCategories: [BigCategoryID] {
            switch self {
            case .life: return [.mealPrep]
            case .work: return [.projectA]
            }
        }
    }
    
    // MARK: - BigCategory ID
    enum BigCategoryID: String, Codable {
        case mealPrep = "mealPrepId"
        case projectA = "projectAId"
        
        var name: String {
            switch self {
            case .mealPrep: return "食事の準備"
            case .projectA: return "プロジェクトA"
            }
        }
        
        var smallCategories: [SmallCategoryID] {
            switch self {
            case .mealPrep: return [.breakfast, .lunch, .dinner]
            case .projectA: return []
            }
        }
    }
    
    // MARK: - SmallCategory ID
    enum SmallCategoryID: String, Codable {
        case breakfast = "breakfastId"
        case lunch = "lunchId"
        case dinner = "dinnerId"
        
        var name: String {
            switch self {
            case .breakfast: return "朝食"
            case .lunch: return "昼食"
            case .dinner: return "夕食"
            }
        }
    }
    
    // MARK: - kTLWorkspacesExample
    static let kTLWorkspacesExample: [TLWorkspace] = [
        // MARK: - Work Workspace
        TLWorkspace(
            id: WorkspaceID.work.rawValue,
            name: WorkspaceID.work.name,
            bigCategories: [
                TLToDoCategory(id: BigCategoryID.projectA.rawValue, parentBigCategoryID: nil, name: BigCategoryID.projectA.name)
            ],
            smallCategories: [
                BigCategoryID.projectA.rawValue: []
            ],
            categoryIDToToDos: [
                WorkspaceID.work.rawValue: TLToDosInTodayAndWhenever(
                    categoryID: WorkspaceID.work.rawValue,
                    toDosInToday: [
                        TLToDo(workspaceID: WorkspaceID.work.rawValue, categoryID: BigCategoryID.projectA.rawValue, isInToday: true, content: "Aさんとのスケジュールを調整"),
                        TLToDo(
                            workspaceID: WorkspaceID.work.rawValue,
                            categoryID: BigCategoryID.projectA.rawValue,
                            isInToday: true,
                            content: "書類の作成",
                            steps: [
                                TLStep(content: "資料を用意する"),
                                TLStep(content: "送り先に送信する")
                            ]
                        )
                    ]),
                BigCategoryID.projectA.rawValue: TLToDosInTodayAndWhenever(
                    categoryID: BigCategoryID.projectA.rawValue,
                    toDosInWhenever: [
                        TLToDo(
                            workspaceID: WorkspaceID.work.rawValue,
                            categoryID: BigCategoryID.projectA.rawValue,
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
            bigCategories: [
                TLToDoCategory(
                    id: BigCategoryID.mealPrep.rawValue,
                    parentBigCategoryID: nil,
                    name: BigCategoryID.mealPrep.name
                )
            ],
            smallCategories: [
                BigCategoryID.mealPrep.rawValue: [
                    TLToDoCategory(id: SmallCategoryID.breakfast.rawValue, parentBigCategoryID: BigCategoryID.mealPrep.rawValue, name: SmallCategoryID.breakfast.name),
                    TLToDoCategory(id: SmallCategoryID.lunch.rawValue, parentBigCategoryID: BigCategoryID.mealPrep.rawValue, name: SmallCategoryID.lunch.name),
                    TLToDoCategory(id: SmallCategoryID.dinner.rawValue, parentBigCategoryID: BigCategoryID.mealPrep.rawValue, name: SmallCategoryID.dinner.name)
                ]
            ],
            categoryIDToToDos: [
                WorkspaceID.life.rawValue: TLToDosInTodayAndWhenever(categoryID: WorkspaceID.life.rawValue),
                BigCategoryID.mealPrep.rawValue: TLToDosInTodayAndWhenever(categoryID: BigCategoryID.mealPrep.rawValue),
                SmallCategoryID.breakfast.rawValue: TLToDosInTodayAndWhenever(
                    categoryID: SmallCategoryID.breakfast.rawValue,
                    toDosInToday: [
                        TLToDo(
                            workspaceID: WorkspaceID.life.rawValue,
                            categoryID: SmallCategoryID.breakfast.rawValue,
                            isInToday: true,
                            content: "ご飯を炊く"
                        )
                    ]
                ),
                SmallCategoryID.lunch.rawValue: TLToDosInTodayAndWhenever(categoryID: SmallCategoryID.lunch.rawValue),
                SmallCategoryID.dinner.rawValue: TLToDosInTodayAndWhenever(
                    categoryID: SmallCategoryID.dinner.rawValue,
                    toDosInToday: [
                        TLToDo(workspaceID: WorkspaceID.life.rawValue, categoryID: SmallCategoryID.dinner.rawValue, isInToday: true, content: "鶏むね肉の照り焼き", steps: [
                            TLStep(content: "鶏むね肉"),
                            TLStep(content: "醤油"),
                            TLStep(content: "みりん"),
                            TLStep(content: "砂糖")
                        ]),
                        TLToDo(workspaceID: WorkspaceID.life.rawValue, categoryID: SmallCategoryID.dinner.rawValue, isInToday: true, content: "じゃがいもと玉ねぎの味噌汁", steps: [
                            TLStep(content: "じゃがいも"),
                            TLStep(content: "玉ねぎ"),
                            TLStep(content: "味噌")
                        ])
                    ]
                )
            ]
        )
    ]
    
}

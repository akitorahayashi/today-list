//
//  TLWidgetKitSettings.swift
//  Runner
//
//  Created by 林 明虎 on 2024/11/23.
//

import SwiftUI

let defaultWKS = ToDosInCategoryWidgetSettings(
    id: TLWorkspacesExample.noneID.rawValue,
    title: "ToDo",
    // noneIDしか使わない予定
    workspace: TLWorkspace(id: TLWorkspacesExample.noneID.rawValue, name: "Default", bigCategories: [], smallCategories: [:], categoryIDToToDos: [:]),
    bigCategory: TLCategory(id: TLWorkspacesExample.noneID.rawValue, title: "なし")
)

struct ToDosInCategoryWidgetSettings: Codable, Identifiable {
    
    var id: String
    var title: String
    // これより下はオブジェクトのIDしか使わない予定だが、flutterアプリで保存したjsonと対応させるため、クラスにしている
    var workspace: TLWorkspace
    var bigCategory: TLCategory
    var smallCategory: TLCategory?
    
    static func decodeListOfToDosInCategoryWidgetSettings(from jsonList: String?) -> [ToDosInCategoryWidgetSettings]? {
        return TLiOSUtils.decodeCustomList(from: jsonList)
    }
}


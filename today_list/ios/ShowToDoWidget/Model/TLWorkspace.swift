//
//  TLWorkspace.swift
//  ShowToDoWidgetExtension
//
//  Created by 林 明虎 on 2024/09/12.
//

import Foundation

struct TLWorkspace: Codable {
    var name: String
    var bigCategories: [TLCategory]
    var smallCategories: [String: [TLCategory]]
    var toDos: [String: TLToDos]
}

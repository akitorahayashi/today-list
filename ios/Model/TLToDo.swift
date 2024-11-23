//
//  TLToDo.swift
//  Runner
//
//  Created by 林 明虎 on 2024/11/23.
//


struct TLToDo: Identifiable, Codable {
    var id: String
    var title: String
    var isChecked: Bool
    var steps: [TLStep]
}

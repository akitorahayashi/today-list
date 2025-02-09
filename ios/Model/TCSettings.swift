//
//  TLWidgetKitSettings.swift
//  Runner
//
//  Created by 林 明虎 on 2024/11/23.
//

import SwiftUI

let defaultWKS = TCSettings(
    id: noneID,
    title: "ToDo",
    workspaceID: noneID,
    categoryID: noneID
)

struct TCSettings: Codable, Identifiable {
    
    var id: String
    var title: String
    var workspaceID: String
    var categoryID: String
    
    // JSONからwksListへデコードする関数
    static func decodeWKSList(from jsonWKSList: String?) -> [TCSettings]? {
        // JSON文字列がnilでないかチェックし、データに変換
        guard let jsonString = jsonWKSList else {
            print("workspacesDecodeError: jsonWKSList is nil")
            return nil
        }
        
        guard let data = jsonString.data(using: .utf8) else {
            print("wksListDecodeError: failed to convert data")
            return nil
        }
        
        do {
            // JSONをデコードして、[TLWorkspace] 型のデータに変換
            let wksList = try JSONDecoder().decode([TCSettings].self, from: data)
            
            return wksList
        } catch {
            print("JSONデコード中にエラーが発生しました: \(error.localizedDescription)")
            return nil
        }
    }
}


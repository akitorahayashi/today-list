//
//  TLWidgetKitSettings.swift
//  Runner
//
//  Created by 林 明虎 on 2024/11/23.
//

import SwiftUI

let defaultWKS = TCWSettings(
    id: noneID,
    title: "ToDo",
    workspaceIdx: 0,
    bcIdx: 0,
    scIdx: nil
)

struct TCWSettings: Codable, Identifiable {
    
    var id: String
    var title: String
    var workspaceIdx: Int
    var bcIdx: Int
    var scIdx:Int?
    
    // JSONからwksListへデコードする関数
    static func decodeWKSList(from jsonWKSList: String?) -> [TCWSettings]? {
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
            let wksList = try JSONDecoder().decode([TCWSettings].self, from: data)
            
            return wksList
        } catch {
            print("JSONデコード中にエラーが発生しました: \(error.localizedDescription)")
            return nil
        }
    }
}


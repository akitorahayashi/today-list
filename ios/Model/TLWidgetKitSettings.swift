//
//  TLWidgetKitSettings.swift
//  Runner
//
//  Created by 林 明虎 on 2024/11/23.
//

import SwiftUI

struct TLWidgetKitSettings: Codable, Identifiable {
    
    var id: String
    var title: String
    var workspaceIdx: Int
    var bcIdx: Int
    var scIdx:Int?
    
    // JSONからwksListへデコードする関数
    static func decodeWKSList(from jsonWKSList: String?) -> [TLWidgetKitSettings]? {
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
            let wksList = try JSONDecoder().decode([TLWidgetKitSettings].self, from: data)
            
            return wksList
        } catch {
            print("JSONデコード中にエラーが発生しました: \(error.localizedDescription)")
            return nil
        }
    }
}


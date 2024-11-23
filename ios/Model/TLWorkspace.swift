//
//  TLWorkspace.swift
//  Runner
//
//  Created by 林 明虎 on 2024/11/23.
//

import SwiftUI

struct TLWorkspace: Codable, Identifiable {
    var id: String
    var name: String
    var bigCategories: [TLCategory]
    var smallCategories: [String: [TLCategory]]
    var categoryIDToToDos: [String: TLToDos]
    
    // JSONからToDosをデコードする関数
    static func decodeWorkspaces(from jsonWorkspaces: String?) -> [TLWorkspace]? {
        // JSON文字列がnilでないかチェックし、データに変換
        guard let jsonString = jsonWorkspaces else {
            print("workspacesDecodeError: jsonWorkspaces is nil")
            return nil
        }
        
        guard let data = jsonString.data(using: .utf8) else {
            print("workspacesDecodeError: failed to convert data")
            return nil
        }
        
        do {
            // JSONをデコードして、[TLWorkspace] 型のデータに変換
            let tlWorkspaces = try JSONDecoder().decode([TLWorkspace].self, from: data)
            
            return tlWorkspaces
        } catch {
            print("JSONデコード中にエラーが発生しました: \(error.localizedDescription)")
            return nil
        }
    }
}


//
//  TLWidgetKitSettings.swift
//  Runner
//
//  Created by 林 明虎 on 2024/11/23.
//

import SwiftUI

struct ToDosInCategoryWidgetSettings: Codable, Identifiable {
    
    var id: String
    var title: String
    // これより下はオブジェクトのIDしか使わないが、flutterアプリで保存したjsonと対応させるため、クラスにしている
    var workspace: TLWorkspace
    var bigCategory: TLToDoCategory?
    var smallCategory: TLToDoCategory?
    
    static func decodeListOfToDosInCategoryWidgetSettings(from jsonStringList: String?) -> [ToDosInCategoryWidgetSettings]? {
        
        // JSON文字列がnilまたは空の場合、エラーを出力して終了
        guard let jsonStringList = jsonStringList, !jsonStringList.isEmpty else {
            print("decodeListOfToDosInCategoryWidgetSettings - decodeCustomListError: jsonString is nil or empty")
            return nil
        }
        
        // 文字列をData型に変換できない場合
        guard let data = jsonStringList.data(using: .utf8) else {
            print("decodeListOfToDosInCategoryWidgetSettings - decodeCustomListError: Failed to convert JSON string to Data")
            return nil
        }
        
        // JSONデコード処理
        do {
            return try JSONDecoder().decode([ToDosInCategoryWidgetSettings].self, from: data)
        } catch {
            print("decodeCustomListError: JSON decoding failed -> \(error.localizedDescription)")
            return nil
        }
        
    }
}


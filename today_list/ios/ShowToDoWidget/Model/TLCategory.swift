//
//  TLCategory.swift
//  ShowToDoWidgetExtension
//
//  Created by 林 明虎 on 2024/09/12.
//

import Foundation

struct TLCategory: Codable {
    var id: String
    var title: String
    
    // インスタンスを JSON に変換
    func toJson() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // 読みやすい形式にするオプション
        do {
            let jsonData = try encoder.encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print("Error encoding to JSON: \(error)")
            return nil
        }
    }
    
    // JSON からインスタンスを生成
    static func fromJson(_ json: String) -> TLCategory? {
        let decoder = JSONDecoder()
        guard let jsonData = json.data(using: .utf8) else { return nil }
        do {
            return try decoder.decode(TLCategory.self, from: jsonData)
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
    
    // [TLCategory]からStringにエンコードする関数
    static func encodeCategories(categories: [TLCategory]) -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted // 整形されたJSONを出力する場合（オプション）
        
        do {
            // [TLCategory]配列をJSONデータにエンコード
            let jsonData = try encoder.encode(categories)
            // JSONデータをStringに変換して返す
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print("Failed to encode categories: \(error)")
            return nil
        }
    }
    
    static func decodeCategories(jsonString: String) -> [TLCategory]? {
        let decoder = JSONDecoder()
        
        // 文字列をData型に変換
        guard let jsonData = jsonString.data(using: .utf8) else {
            print("Invalid JSON string")
            return nil
        }
        
        do {
            // JSONDecoderを使って[TLCategory]にデコード
            let categories = try decoder.decode([TLCategory].self, from: jsonData)
            return categories
        } catch {
            print("Failed to decode JSON: \(error)")
            return nil
        }
    }
}

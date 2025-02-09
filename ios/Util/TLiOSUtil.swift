//
//  TLiOSUtil.swift
//  Runner
//
//  Created by 林 明虎 on 2025/02/09.
//

import Foundation

enum TLiOSUtils {
    // カスタマイズした型のリストをデコードする関数
    static func decodeCustomList<T: Codable>(from jsonString: String?) -> [T]? {
        // JSON文字列がnilまたは空の場合、エラーを出力して終了
        guard let jsonString = jsonString, !jsonString.isEmpty else {
            print("decodeCustomListError: jsonString is nil or empty")
            return nil
        }
        
        // 文字列をData型に変換できない場合
        guard let data = jsonString.data(using: .utf8) else {
            print("decodeCustomListError: Failed to convert JSON string to Data")
            return nil
        }
        
        // JSONデコード処理
        do {
            return try JSONDecoder().decode([T].self, from: data)
        } catch {
            print("decodeCustomListError: JSON decoding failed -> \(error.localizedDescription)")
            return nil
        }
    }
}

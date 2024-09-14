//
//  TLStep.swift
//  Runner
//
//  Created by 林 明虎 on 2024/09/05.
//

import Foundation

struct TLStep: Identifiable, Codable {
    let id = UUID()
    let title: String
    let isChecked: Bool
    
    // インスタンスを JSON に変換
    func toJson() -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let jsonData = try encoder.encode(self)
            return String(data: jsonData, encoding: .utf8)
        } catch {
            print("Error encoding to JSON: \(error)")
            return nil
        }
    }
    
    // JSON からインスタンスを生成
    static func fromJson(_ json: String) -> TLStep? {
        let decoder = JSONDecoder()
        guard let jsonData = json.data(using: .utf8) else { return nil }
        do {
            return try decoder.decode(TLStep.self, from: jsonData)
        } catch {
            print("Error decoding JSON: \(error)")
            return nil
        }
    }
}

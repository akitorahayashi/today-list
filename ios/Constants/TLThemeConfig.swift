//
//  TLTheme.swift
//  Runner
//
//  Created by 林 明虎 on 2024/10/05.
//

import SwiftUI


// MARK: - Struct: TLThemeConfig
struct TLThemeConfig {
    let gradientOfTopBar: LinearGradient
    let backgroundColorOfToDoList: Color
    let toDoCardColor: Color
}

// MARK: - Enum: TLThemeType
enum TLThemeType: String {
    case sunOrange
    case limeGreen
    case marineBlue

    // Convert String to TLThemeType safely
    static func from(_ value: String) -> TLThemeType {
        if let matchedCase = TLThemeType(rawValue: value) {
            return matchedCase
        } else {
            print("Warning: \(value) does not match any TLThemeType case. Returning .sunOrange as default.")
            return .sunOrange
        }
    }

    // MARK: - Theme Configuration (Safe Accessor)
    var config: TLThemeConfig {
        switch self {
        case .sunOrange:
            return TLThemeConfig(
                gradientOfTopBar: LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 255 / 255, green: 163 / 255, blue: 163 / 255),
                        Color(red: 255 / 255, green: 230 / 255, blue: 87 / 255)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                backgroundColorOfToDoList: Color(red: 255 / 255, green: 229 / 255, blue: 214 / 255),
                toDoCardColor: Color(red: 255 / 255, green: 229 / 255, blue: 214 / 255)
            )

        case .limeGreen:
            return TLThemeConfig(
                gradientOfTopBar: LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 73 / 255, green: 194 / 255, blue: 70 / 255),
                        Color(red: 143 / 255, green: 250 / 255, blue: 56 / 255)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                backgroundColorOfToDoList: Color(red: 239 / 255, green: 255 / 255, blue: 214 / 255),
                toDoCardColor: Color(red: 255 / 255, green: 229 / 255, blue: 214 / 255)
            )

        case .marineBlue:
            return TLThemeConfig(
                gradientOfTopBar: LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 131 / 255, green: 169 / 255, blue: 252 / 255),
                        Color(red: 144 / 255, green: 242 / 255, blue: 249 / 255)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                backgroundColorOfToDoList: Color(red: 241 / 255, green: 251 / 255, blue: 253 / 255),
                toDoCardColor: Color(red: 255 / 255, green: 229 / 255, blue: 214 / 255)
            )
        }
    }
}


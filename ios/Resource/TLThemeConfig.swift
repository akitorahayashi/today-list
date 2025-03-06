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
    case monochrome
    case cherryBlossom
    case urbanNight
    case patisserie

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
                toDoCardColor: Color(red: 235 / 255, green: 255 / 255, blue: 179 / 255)
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
                toDoCardColor: Color(red: 255 / 255, green: 253 / 255, blue: 184 / 255)
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
                toDoCardColor: Color(red: 214 / 255, green: 252 / 255, blue: 255 / 255)
            )
            
        case .monochrome:
            return TLThemeConfig(
                gradientOfTopBar: LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 70 / 255, green: 70 / 255, blue: 70 / 255),
                        Color(red: 40 / 255, green: 40 / 255, blue: 40 / 255)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                backgroundColorOfToDoList: Color(red: 248 / 255, green: 248 / 255, blue: 248 / 255),
                toDoCardColor: Color(red: 245 / 255, green: 245 / 255, blue: 245 / 255)
            )
            
        case .cherryBlossom:
            return TLThemeConfig(
                gradientOfTopBar: LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 255 / 255, green: 182 / 255, blue: 193 / 255),
                        Color(red: 255 / 255, green: 192 / 255, blue: 203 / 255)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                backgroundColorOfToDoList: Color(red: 253 / 255, green: 245 / 255, blue: 247 / 255),
                toDoCardColor: Color(red: 255 / 255, green: 245 / 255, blue: 250 / 255)
            )
            
        case .urbanNight:
            return TLThemeConfig(
                gradientOfTopBar: LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 33 / 255, green: 33 / 255, blue: 33 / 255),
                        Color(red: 15 / 255, green: 15 / 255, blue: 15 / 255)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                backgroundColorOfToDoList: Color(red: 30 / 255, green: 30 / 255, blue: 30 / 255),
                toDoCardColor: Color(red: 45 / 255, green: 45 / 255, blue: 45 / 255)
            )
            
        case .patisserie:
            return TLThemeConfig(
                gradientOfTopBar: LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 255 / 255, green: 223 / 255, blue: 186 / 255),
                        Color(red: 255 / 255, green: 236 / 255, blue: 210 / 255)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                backgroundColorOfToDoList: Color(red: 255 / 255, green: 252 / 255, blue: 245 / 255),
                toDoCardColor: Color(red: 255 / 255, green: 248 / 255, blue: 225 / 255)
            )
        }
    }
}


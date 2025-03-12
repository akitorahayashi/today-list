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
    let navigationTitleColor: Color
    let textColor: Color
}

// MARK: - Enum: TLThemeType
enum TLThemeType: String {
    case sunOrange
    case limeGreen
    case marineBlue
    case cherryBlossom
    case pastryBloom
    case notebook

    // Convert String to TLThemeType safely
    static func from(_ value: String) -> TLThemeType {
        if let matchedCase = TLThemeType(rawValue: value) {
            return matchedCase
        } else {
            print("Warning: \(value) does not match any TLThemeType case. Returning .notebook as default.")
            return .notebook
        }
    }

    // MARK: - Theme Configuration (Safe Accessor)
    var config: TLThemeConfig {
        switch self {
            
        // MARK: - sunOrange
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
                toDoCardColor: Color(red: 235 / 255, green: 255 / 255, blue: 179 / 255),
                navigationTitleColor: Color.white,
                textColor: Color.black
            )
            
        // MARK: - limeGreen
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
                toDoCardColor: Color(red: 255 / 255, green: 253 / 255, blue: 184 / 255),
                navigationTitleColor: Color.white,
                textColor: Color.black
            )
            
        // MARK: - marineBlue
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
                toDoCardColor: Color(red: 214 / 255, green: 252 / 255, blue: 255 / 255),
                navigationTitleColor: Color.white,
                textColor: Color.black
            )
            
        // MARK: - cherryBlossom
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
                toDoCardColor: Color(red: 255 / 255, green: 245 / 255, blue: 250 / 255),
                navigationTitleColor: Color.white,
                textColor: Color.black
            )
            
        // MARK: - pastryBloom
        case .pastryBloom:
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
                toDoCardColor: Color(red: 255 / 255, green: 248 / 255, blue: 225 / 255),
                navigationTitleColor: Color.white,
                textColor: Color.black
            )
            
        // MARK: - notebook
        case .notebook:
            return TLThemeConfig(
                gradientOfTopBar: LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 240 / 255, green: 240 / 255, blue: 240 / 255),
                        Color(red: 250 / 255, green: 250 / 255, blue: 250 / 255)
                    ]),
                    startPoint: .leading,
                    endPoint: .trailing
                ),
                backgroundColorOfToDoList: Color(red: 255 / 255, green: 255 / 255, blue: 255 / 255),
                toDoCardColor: Color(red: 240 / 255, green: 240 / 255, blue: 240 / 255),
                navigationTitleColor: Color(red: 94 / 255, green: 158 / 255, blue: 214 / 255),
                textColor: Color.black
            )
        }
    }
}


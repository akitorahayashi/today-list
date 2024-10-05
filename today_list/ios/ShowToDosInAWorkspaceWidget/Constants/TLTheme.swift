//
//  TLTheme.swift
//  Runner
//
//  Created by 林 明虎 on 2024/10/05.
//

import SwiftUI

class TLTheme {
    let gradientOfTopBar: LinearGradient
    let backgroundColorOfToDoList: Color
    
    init(gradientOfTopBar: LinearGradient, backgroundColorOfToDoList: Color) {
        self.gradientOfTopBar = gradientOfTopBar
        self.backgroundColorOfToDoList = backgroundColorOfToDoList
    }
}

let kTLThemes: [String: TLTheme] = [
    "Sun Orange": TLTheme(
        gradientOfTopBar: LinearGradient(
            gradient: Gradient(colors: [
                Color(red: 255 / 255, green: 163 / 255, blue: 163 / 255),
                Color(red: 255 / 255, green: 230 / 255, blue: 87 / 255)
            ]),
            startPoint: .leading,
            endPoint: .trailing
        ),
        backgroundColorOfToDoList: Color(red: 255 / 255, green: 229 / 255, blue: 214 / 255)
    ),
    "Lime Green": TLTheme(gradientOfTopBar: LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 73 / 255, green: 194 / 255, blue: 70 / 255),
            Color(red: 143 / 255, green: 250 / 255, blue: 56 / 255)
        ]),
        startPoint: .leading,
        endPoint: .trailing
    ),
    backgroundColorOfToDoList: Color(red: 239 / 255, green: 255 / 255, blue: 214 / 255)),
    "Marine Blue": TLTheme(gradientOfTopBar: LinearGradient(
        gradient: Gradient(colors: [
            Color(red: 131 / 255, green: 169 / 255, blue: 252 / 255),
            Color(red: 144 / 255, green: 242 / 255, blue: 249 / 255)
        ]),
        startPoint: .leading,
        endPoint: .trailing
    ),
    backgroundColorOfToDoList: Color(red: 241 / 255, green: 251 / 255, blue: 253 / 255)),
]

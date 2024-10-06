//
//  TLWatchAppBar.swift
//  Runner
//
//  Created by 林 明虎 on 2024/10/05.
//

import SwiftUI

struct TLWatchAppBar: View {
    let appbarTitle: String
    var selectedColorTheme: String
    
    var body: some View {
        // グラデーションを持つビュー
        kTLThemes[self.selectedColorTheme]!.gradientOfTopBar
            .shadow(radius: 4)
        // AppBarのテキスト部分
            .overlay(
                VStack {
                    Spacer()
                    Text(appbarTitle)
                        .font(.system(size: 20, weight: .bold)) // 太い白文字
                        .foregroundColor(.white) // 白色
                        .padding(.bottom, 4)
                }
            )
            .edgesIgnoringSafeArea(.all)
            .frame(height: 15) // 上部3割の高さ
    }
}

//
//  ToDosInCategoryWidget.swift
//  ToDosInCategoryWidget
//
//  Created by 林 明虎 on 2025/02/09.
//

import WidgetKit
import SwiftUI
import AppIntents

struct ToDosInCategoryWidget: Widget {
    let kind: String = "ToDosInCategoryWidget"
    
    var body: some WidgetConfiguration {
        AppIntentConfiguration(kind: kind,
                               intent: TCIntent.self,
                               provider: TCProvider()) { entry in
            TCEntryView(entry: entry)
                .containerBackground(for: .widget) {
                    VStack(spacing: 0) {
                        ZStack {
                            // テーマの適用
                            kTLThemes[entry.selectedThemeIdx].gradientOfTopBar
                            Text(entry.entity.title)
                                .font(.system(size: 18, weight: .bold))
                                .foregroundColor(.white)
                        }
                        .frame(height: 28)
                        
                        ZStack {
                            kTLThemes[entry.selectedThemeIdx].backgroundColorOfToDoList
                            
                            Color.white
                                .cornerRadius(15)
                                .padding(6)
                                .shadow(radius: 1)
                        }
                    }
                }
        }.configurationDisplayName("ToDos In Category")
            .description("Select widget settings from the app")
            .supportedFamilies([.systemSmall, .systemMedium, .systemLarge])
    }
}


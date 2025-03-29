//
//  TWProvider.swift
//  Runner
//
//  Created by akitora.hayashi on 2025/03/29.
//

import SwiftUI
import WidgetKit
import AppIntents

struct TWProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> TWWidgetEntry {
        return TWWidgetEntry(
            date: Date(),
            entity: nil,
            selectedThemeType: TLThemeType.sunOrange,
            tlWorkspaces: TCWExampleState.kTLWorkspacesExample
        )
    }
    
    func snapshot(for configuration: TWWorkspaceSelectionAppIntent, in context: Context) async -> TWWidgetEntry {
        let themeName = TLThemeType.sunOrange.rawValue
        let corrThemeType = TLThemeType.from(themeName)
        return TWWidgetEntry(
            date: Date(),
            entity: nil,
            selectedThemeType: corrThemeType,
            tlWorkspaces: TCWExampleState.kTLWorkspacesExample
        )
    }
    
    func timeline(for configuration: TWWorkspaceSelectionAppIntent, in context: Context) async -> Timeline<TWWidgetEntry> {
        
        // 保存してあるデータの読み取り
        let userDefaults = TLUserDefaultsManager.shared.userDefaults
        let themeName = userDefaults?.string(forKey: "selectedThemeName") ?? TLThemeType.sunOrange.rawValue
        let stringOfTLWorkspace: String? = TLUserDefaultsManager.shared.userDefaults?.string(forKey: "tlWorkspaces")
        
        // テーマの特定
        let corrThemeType = TLThemeType.from(themeName)
        
        // workspaceのデコード
        let tlWorkspaces: [TLWorkspace] = TLWorkspace.decodeWorkspaces(from: stringOfTLWorkspace) ?? TCWExampleState.kTLWorkspacesExample
        
        
        let loadedEntry = TWWidgetEntry(
            date: Date(),
            // selectedWorkspace は オプショナル
            entity: configuration.selectedWorkspace,
            selectedThemeType: corrThemeType,
            tlWorkspaces: tlWorkspaces
        )
        
        
        
        return Timeline(entries: [loadedEntry], policy: .never)
    }
}

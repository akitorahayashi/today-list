//
//  UCTProvider.swift
//  Runner
//
//  Created by 林明虎 on 2025/02/28.
//

import SwiftUI
import WidgetKit
import AppIntents

struct UCTProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> UCTWidgetEntry {
        return UCTWidgetEntry(
            date: Date(),
            entity: nil,
            selectedThemeType: TLThemeType.sunOrange,
            tlWorkspaces: TCWExampleState.kTLWorkspacesExample
        )
    }
    
    func snapshot(for configuration: WorkspaceSelectionAppIntent, in context: Context) async -> UCTWidgetEntry {
        let themeName = TLThemeType.sunOrange.rawValue
        let corrThemeType = TLThemeType.from(themeName)
        return UCTWidgetEntry(
            date: Date(),
            entity: nil,
            selectedThemeType: corrThemeType,
            tlWorkspaces: TCWExampleState.kTLWorkspacesExample
        )
    }
    
    func timeline(for configuration: WorkspaceSelectionAppIntent, in context: Context) async -> Timeline<UCTWidgetEntry> {
        
        // 保存してあるデータの読み取り
        let userDefaults = TLUserDefaultsManager.shared.userDefaults
        let themeName = userDefaults?.string(forKey: "selectedThemeName") ?? TLThemeType.sunOrange.rawValue
        let stringOfTLWorkspace: String? = TLUserDefaultsManager.shared.userDefaults?.string(forKey: "tlWorkspaces")
        
        // テーマの特定
        let corrThemeType = TLThemeType.from(themeName)
        
        // workspaceのデコード
        let tlWorkspaces: [TLWorkspace] = TLWorkspace.decodeWorkspaces(from: stringOfTLWorkspace) ?? TCWExampleState.kTLWorkspacesExample
        
        
        let loadedEntry = UCTWidgetEntry(
            date: Date(),
            // selectedWorkspace は オプショナル
            entity: configuration.selectedWorkspace,
            selectedThemeType: corrThemeType,
            tlWorkspaces: tlWorkspaces
        )
        
        
        
        return Timeline(entries: [loadedEntry], policy: .never)
    }
}

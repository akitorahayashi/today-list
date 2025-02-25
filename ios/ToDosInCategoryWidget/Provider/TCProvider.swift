//
//  TLProvider.swift
//  Runner
//
//  Created by 林 明虎 on 2025/02/09.
//

import SwiftUI
import WidgetKit
import AppIntents

struct TCProvider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> TCWidgetEntry {
        return TCWidgetEntry(
            date: Date(),
            entity: TCEntity.defaultEntity,
            selectedThemeType: TLThemeType.sunOrange,
            tlWorkspaces: kTLWorkspacesExample
        )
    }
    
    func snapshot(for configuration: TCIntent, in context: Context) async -> TCWidgetEntry {
        let themeName = TLThemeType.sunOrange.rawValue
        let corrThemeType = TLThemeType.from(themeName)
        return TCWidgetEntry(
            date: Date(),
            entity: TCEntity.defaultEntity,
            selectedThemeType: corrThemeType,
            tlWorkspaces: kTLWorkspacesExample
        )
    }
    
    func timeline(for configuration: TCIntent, in context: Context) async -> Timeline<TCWidgetEntry> {
        
        // 保存してあるデータの読み取り
        let userDefaults = TLUserDefaultsManager.shared.userDefaults
        let themeName = userDefaults?.string(forKey: "selectedThemeName") ?? TLThemeType.sunOrange.rawValue
        let stringOfTLWorkspace: String? = TLUserDefaultsManager.shared.userDefaults?.string(forKey: "tlWorkspaces")
        
        // テーマの特定
        let corrThemeType = TLThemeType.from(themeName)
        
        // workspaceのデコード
        let tlWorkspaces: [TLWorkspace] = TLWorkspace.decodeWorkspaces(from: stringOfTLWorkspace) ?? kTLWorkspacesExample
        
        
        let loadedEntry = TCWidgetEntry(
            date: Date(),
            // selectedWKS は オプショナル
            entity: configuration.selectedWKS,
            selectedThemeType: corrThemeType,
            tlWorkspaces: tlWorkspaces
        )
        
        
        
        return Timeline(entries: [loadedEntry], policy: .never)
    }
}

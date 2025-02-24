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
            entity: defaultEntity,
            selectedThemeType: TLThemeType.sunOrange,
            tlWorkspaces: kTLWorkspacesExample
        )
    }
    
    func snapshot(for configuration: TCIntent, in context: Context) async -> TCWidgetEntry {
        let themeName = TLThemeType.sunOrange.rawValue
        let corrThemeType = TLThemeType.from(themeName)
        return TCWidgetEntry(
            date: Date(),
            entity: defaultEntity,
            selectedThemeType: corrThemeType,
            tlWorkspaces: kTLWorkspacesExample
        )
    }
    
    func timeline(for configuration: TCIntent, in context: Context) async -> Timeline<TCWidgetEntry> {
        var entries: [TCWidgetEntry] = []
        
        // 保存してあるデータの読み取り
        let userDefaults = TLUserDefaultsManager.shared.userDefaults
        let themeName = userDefaults?.string(forKey: "selectedThemeName") ?? TLThemeType.sunOrange.rawValue
        let stringOfTLWorkspace: String? = TLUserDefaultsManager.shared.userDefaults?.string(forKey: "tlWorkspaces")
        
        // workspaceのデコード
        let tlWorkspaces: [TLWorkspace]? =
        TLWorkspace.decodeWorkspaces(from: stringOfTLWorkspace) ?? kTLWorkspacesExample
        
        // テーマの特定
        let corrThemeType = TLThemeType.from(themeName)
        
        let loadedEntry = TCWidgetEntry(
            date: Date(),
            entity:
//                defaultEntity,
                configuration.selectedWKS,
            selectedThemeType: corrThemeType,
            tlWorkspaces: tlWorkspaces
        )
        
        entries.append(loadedEntry)
        
        return Timeline(entries: entries, policy: .never)
    }
}

//
//  Provider.swift
//  Runner
//
//  Created by 林 明虎 on 2024/11/23.
//

import WidgetKit

struct TLWidgetEntry: TimelineEntry {
    let date: Date
    let entity: TLWidgetKitSettingsEntity
    let selectedThemeIdx: Int
    let tlWorkspaces: [TLWorkspace]
}

struct TLProvider: AppIntentTimelineProvider {
    typealias Intent = TLWidgetKitSettingsIntent
    
    func placeholder(in context: Context) -> TLWidgetEntry {
        let tlWorkspacesSample: [TLWorkspace] = TLWorkspace.decodeWorkspaces(from: kTLWorkspacesExample) ?? []
        return TLWidgetEntry(date: Date(), entity: defaultEntity, selectedThemeIdx: 0, tlWorkspaces: tlWorkspacesSample)
    }
    
    func snapshot(for configuration: TLWidgetKitSettingsIntent, in context: Context) async -> TLWidgetEntry {
        let userDefaults = UserDefaults(suiteName: "group.akitorahayashi.todayListGroup")
        let themeIdx: Int = userDefaults?.integer(forKey: "selectedThemeIdx") ?? 0
        let tlWorkspacesSample: [TLWorkspace] = TLWorkspace.decodeWorkspaces(from: kTLWorkspacesExample) ?? []
        return TLWidgetEntry(date: Date(), entity: defaultEntity, selectedThemeIdx: themeIdx, tlWorkspaces: tlWorkspacesSample)
    }
    
    func timeline(for configuration: TLWidgetKitSettingsIntent, in context: Context) async -> Timeline<TLWidgetEntry> {
        var entries: [TLWidgetEntry] = []
        
        let userDefaults = UserDefaults(suiteName: "group.akitorahayashi.todayListGroup")
        let themeIdx: Int = userDefaults?.integer(forKey: "selectedThemeIdx") ?? 0
        let stringOfTLWorkspace = userDefaults?.string(forKey: "tlWorkspaces")
        let decodedTLWorkspaces: [TLWorkspace] = TLWorkspace.decodeWorkspaces(from: stringOfTLWorkspace) ?? []
        let loadedEntry = TLWidgetEntry(date: Date(), entity: configuration.selectedWKS ?? defaultEntity, selectedThemeIdx: themeIdx, tlWorkspaces: decodedTLWorkspaces)
        
        entries.append(loadedEntry)
        
        return Timeline(entries: entries, policy: .atEnd)
    }
}

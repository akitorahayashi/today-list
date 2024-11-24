//
//  Provider.swift
//  Runner
//
//  Created by 林 明虎 on 2024/11/23.
//

import WidgetKit

struct SimpleEntry: TimelineEntry {
    let date: Date
    let configuration: TLWidgetKitSettingsIntent
    let selectedThemeIdx: Int
    let tlWorkspaces: [TLWorkspace]
}

struct Provider: AppIntentTimelineProvider {
    typealias Intent = TLWidgetKitSettingsIntent
    
    func placeholder(in context: Context) -> SimpleEntry {
        let tlWorkspacesSample: [TLWorkspace] = TLWorkspace.decodeWorkspaces(from: kTLContentExample) ?? []
        return SimpleEntry(date: Date(), configuration: TLWidgetKitSettingsIntent(), selectedThemeIdx: 0, tlWorkspaces: tlWorkspacesSample)
    }
    
    func snapshot(for configuration: TLWidgetKitSettingsIntent, in context: Context) async -> SimpleEntry {
        let userDefaults = UserDefaults(suiteName: "group.akitorahayashi.todayListGroup")
        let themeIdx: Int = userDefaults?.integer(forKey: "selectedThemeIdx") ?? 0
        let tlWorkspacesSample: [TLWorkspace] = TLWorkspace.decodeWorkspaces(from: kTLContentExample) ?? []
        return SimpleEntry(date: Date(), configuration: configuration, selectedThemeIdx: themeIdx, tlWorkspaces: tlWorkspacesSample)
    }
    
    func timeline(for configuration: TLWidgetKitSettingsIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        let userDefaults = UserDefaults(suiteName: "group.akitorahayashi.todayListGroup")
        let themeIdx: Int = userDefaults?.integer(forKey: "selectedThemeIdx") ?? 0
        let stringOfTLWorkspace = userDefaults?.string(forKey: "tlWorkspaces")
        let decodedTLWorkspaces: [TLWorkspace] = TLWorkspace.decodeWorkspaces(from: stringOfTLWorkspace) ?? []
        let loadedEntry = SimpleEntry(date: Date(), configuration: configuration, selectedThemeIdx: themeIdx, tlWorkspaces: decodedTLWorkspaces)
        
        entries.append(loadedEntry)
        
        return Timeline(entries: entries, policy: .atEnd)
    }
}

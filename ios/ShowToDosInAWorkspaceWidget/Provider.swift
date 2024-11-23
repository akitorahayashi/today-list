//
//  Provider.swift
//  Runner
//
//  Created by 林 明虎 on 2024/11/23.
//

import WidgetKit

struct SimpleEntry: TimelineEntry {
    let date: Date
    let selectedThemeIdx: Int
    let tlWorkspaces: [TLWorkspace]
}

struct Provider: AppIntentTimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        let tlWorkspacesSample: [TLWorkspace] = TLWorkspace.decodeWorkspaces(from: kTLContentExample) ?? []
        return SimpleEntry(date: Date(), selectedThemeIdx: 0, tlWorkspaces: tlWorkspacesSample)
    }
    
    func snapshot(for configuration: ConfigurationAppIntent, in context: Context) async -> SimpleEntry {
        let userDefaults = UserDefaults(suiteName: "group.akitorahayashi.todayListGroup")
        let themeIdx: Int = userDefaults?.integer(forKey: "selectedThemeIdx") ?? 0
        let tlWorkspacesSample: [TLWorkspace] = TLWorkspace.decodeWorkspaces(from: kTLContentExample) ?? []
        return SimpleEntry(date: Date(), selectedThemeIdx: themeIdx, tlWorkspaces: tlWorkspacesSample)
    }
    
    func timeline(for configuration: ConfigurationAppIntent, in context: Context) async -> Timeline<SimpleEntry> {
        var entries: [SimpleEntry] = []
        
        let userDefaults = UserDefaults(suiteName: "group.akitorahayashi.todayListGroup")
        let themeIdx: Int = userDefaults?.integer(forKey: "selectedThemeIdx") ?? 0
        let stringOfTLWorkspace = userDefaults?.string(forKey: "tlWorkspaces")
        let decodedTLWorkspaces: [TLWorkspace] = TLWorkspace.decodeWorkspaces(from: stringOfTLWorkspace) ?? []
        let loadedEntry = SimpleEntry(date: Date(), selectedThemeIdx: themeIdx, tlWorkspaces: decodedTLWorkspaces)
        
        entries.append(loadedEntry)
        
        return Timeline(entries: entries, policy: .atEnd)
    }
}

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
        let tlWorkspacesSample: [TLWorkspace] = TLWorkspace.decodeWorkspaces(from: kTLWorkspacesExample) ?? []
        return TCWidgetEntry(
            date: Date(),
            entity: defaultEntity,
            selectedThemeIdx: 0,
            tlWorkspaces: tlWorkspacesSample
        )
    }
    
    func snapshot(for configuration: TCIntent, in context: Context) async -> TCWidgetEntry {
        let userDefaults = UserDefaults(suiteName: "group.akitorahayashi.todayListGroup")
        let themeIdx = userDefaults?.integer(forKey: "selectedThemeIdx") ?? 0
        let tlWorkspacesSample = TLWorkspace.decodeWorkspaces(from: kTLWorkspacesExample) ?? []
        return TCWidgetEntry(
            date: Date(),
            entity: defaultEntity,
            selectedThemeIdx: themeIdx,
            tlWorkspaces: tlWorkspacesSample
        )
    }
    
    func timeline(for configuration: TCIntent, in context: Context) async -> Timeline<TCWidgetEntry> {
        var entries: [TCWidgetEntry] = []
        
        let userDefaults = UserDefaults(suiteName: "group.akitorahayashi.todayListGroup")
        let themeIdx = userDefaults?.integer(forKey: "selectedThemeIdx") ?? 0
        let stringOfTLWorkspace = userDefaults?.string(forKey: "tlWorkspaces") ?? kTLWorkspacesExample
        let decodedTLWorkspaces = TLWorkspace.decodeWorkspaces(from: stringOfTLWorkspace) ?? []
        
        let loadedEntry = TCWidgetEntry(
            date: Date(),
            entity: configuration.selectedWKS ?? defaultEntity,
            selectedThemeIdx: themeIdx,
            tlWorkspaces: decodedTLWorkspaces
        )
        
        entries.append(loadedEntry)
        
        return Timeline(entries: entries, policy: .never)
    }
}

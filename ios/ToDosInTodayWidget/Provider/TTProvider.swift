//
//  TTProvider.swift
//  Runner
//
//  Created by akitora.hayashi on 2025/03/29.
//

import SwiftUI
import WidgetKit

struct TTProvider: TimelineProvider {
    typealias Entry = TTWidgetEntry

    func placeholder(in _: Context) -> TTWidgetEntry {
        return TTWidgetEntry(
            date: Date(),
            selectedThemeType: TLThemeType.notebook,
            tlWorkspaces: TCWExampleState.kTLWorkspacesExample
        )
    }

    func getSnapshot(in _: Context, completion: @escaping (TTWidgetEntry) -> Void) {
        // 保存してあるデータの読み取り
        let userDefaults = TLUserDefaultsManager.shared.userDefaults
        let themeName = userDefaults?.string(forKey: "selectedThemeName") ?? TLThemeType.sunOrange.rawValue
        let corrThemeType = TLThemeType.from(themeName)
        let entry = TTWidgetEntry(
            date: Date(),
            selectedThemeType: corrThemeType,
            tlWorkspaces: TCWExampleState.kTLWorkspacesExample
        )
        completion(entry)
    }

    func getTimeline(in _: Context, completion: @escaping (Timeline<TTWidgetEntry>) -> Void) {
        // 保存してあるデータの読み取り
        let userDefaults = TLUserDefaultsManager.shared.userDefaults
        let themeName = userDefaults?.string(forKey: "selectedThemeName") ?? TLThemeType.sunOrange.rawValue
        let stringOfTLWorkspace: String? = TLUserDefaultsManager.shared.userDefaults?.string(forKey: "tlWorkspaces")

        // テーマの特定
        let corrThemeType = TLThemeType.from(themeName)

        // workspaceのデコード
        let tlWorkspaces: [TLWorkspace] = TLWorkspace.decodeWorkspaces(from: stringOfTLWorkspace) ?? TCWExampleState.kTLWorkspacesExample

        // Since we can't get the selectedWorkspace from AppIntent anymore,
        // we need to retrieve it from UserDefaults or another source
        let selectedWorkspaceId = userDefaults?.string(forKey: "selectedWorkspaceId")
        let selectedWorkspace = selectedWorkspaceId != nil ?
            tlWorkspaces.first(where: { $0.id == selectedWorkspaceId }) : nil

        let loadedEntry = TTWidgetEntry(
            date: Date(),
            selectedThemeType: corrThemeType,
            tlWorkspaces: tlWorkspaces
        )

        let timeline = Timeline(entries: [loadedEntry], policy: .never)
        completion(timeline)
    }
}

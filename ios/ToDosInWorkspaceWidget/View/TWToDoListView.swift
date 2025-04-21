//
//  TWToDoListView.swift
//  Runner
//
//  Created by akitora.hayashi on 2025/03/29.
//

import SwiftUI
import WidgetKit

struct TWToDoListView: View {
    var entry: TWProvider.Entry

    @Environment(\.widgetFamily) var widgetFamily

    var body: some View {
        VStack(alignment: .leading) {
            let utcEntity = entry.entity

            let corrWorkspace: TLWorkspace = .getWorkspace(from: entry.tlWorkspaces, by: utcEntity?.workspaceID ?? entry.tlWorkspaces.first!.id)!

            let toDosInToday = (corrWorkspace.toDos.toDosInToday.filter { !$0.isChecked })

            TLToDoListForWidgetView(
                toDosInToday: toDosInToday,
                widgetFamily: widgetFamily,
                textColor: entry.selectedThemeType.config.textColor
            )

        }.frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
            .padding(.top, 25.5)
    }
}

// MARK: - 設定がない場合の View

private struct NoSettingsView: View {
    let message: String
    let widgetFamily: WidgetFamily

    var body: some View {
        VStack {
            Spacer()
            Text("⚠️ \(message)")
                .font(.system(size: widgetFamily == .systemSmall ? 12 : 14, weight: .bold))
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(10)

            if widgetFamily != .systemSmall {
                Text("No settings available")
                    .font(.system(size: 10))
                    .foregroundColor(.gray)
                    .padding(.top, 4)
            }

            Spacer()
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

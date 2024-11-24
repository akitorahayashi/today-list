//
//  AppIntent.swift
//  ShowToDosInAWorkspaceWidget
//
//  Created by 林 明虎 on 2024/10/21.
//

import WidgetKit
import AppIntents

struct TLWidgetKitSettingsIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Widget Kit Settings"
    static var description = IntentDescription("Select the WidgetKit settings configured in the app and display the ToDo items for the desired category!")


    @Parameter(title: "Soup")
    var name: String?


    @Parameter(title: "Shuffle", default: true)
    var shuffle: Bool


    @Parameter(title: "Refresh", default: .daily)
    var interval: RefreshInterval


    static var parameterSummary: some ParameterSummary {
        When(\.$shuffle, .equalTo, true) {
            Summary {
                \.$name
                \.$shuffle
                \.$interval
            }
        } otherwise: {
            Summary {
                \.$name
                \.$shuffle
            }
        }
    }
}

enum RefreshInterval: String, AppEnum {
    case hourly, daily, weekly


    static var typeDisplayRepresentation: TypeDisplayRepresentation = "Refresh Interval"
    static var caseDisplayRepresentations: [RefreshInterval : DisplayRepresentation] = [
        .hourly: "Every Hour",
        .daily: "Every Day",
        .weekly: "Every Week",
    ]
}

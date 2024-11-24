//
//  AppIntent.swift
//  ShowToDosInAWorkspaceWidget
//
//  Created by 林 明虎 on 2024/10/21.
//

import WidgetKit
import AppIntents

struct TLWidgetKitSettingsIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "iOS Widget Settings"
    static var description = IntentDescription("Select your widget settings")
    
    @Parameter(title: "Widget Title")
    var selectedWKS: TLWidgetKitSettingsEntity?
    
    static var parameterSummary: some ParameterSummary {
        Summary("Select widget: \(\.$selectedWKS)")
    }
}

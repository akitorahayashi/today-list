//
//  TLWidgetKitSettingsIntent.swift
//  Runner
//
//  Created by 林 明虎 on 2025/02/09.
//

import WidgetKit
import AppIntents

struct TCWIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "iOS Widget Settings"
    static var description = IntentDescription("Select your widget settings")
    
    @Parameter(title: "Widget Title")
    var selectedWKS: TCWEntity?

    static var parameterSummary: some ParameterSummary {
        Summary("Select widget: \(\.$selectedWKS)")
    }
}

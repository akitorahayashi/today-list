//
//  TWWorkspaceSelectionAppIntent.swift
//  Runner
//
//  Created by akitora.hayashi on 2025/03/29.
//

import WidgetKit
import AppIntents

struct TWWorkspaceSelectionAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configration"
    static var description = IntentDescription("Show ToDo list of today in a workspace widget.")
    
    @Parameter(title: "Select Workspace", default: nil)
    var selectedWorkspace: TWAppEntity?
    
    static var parameterSummary: some ParameterSummary {
        Summary("Select Workspace: \(\.$selectedWorkspace)")
    }
}

//
//  WorkspaceSelectionAppIntent.swift
//  Runner
//
//  Created by 林明虎 on 2025/02/28.
//


import WidgetKit
import AppIntents

struct WorkspaceSelectionAppIntent: WidgetConfigurationIntent {
    static var title: LocalizedStringResource = "Configration"
    static var description = IntentDescription("Show an uncategorized ToDo list in a workspace widget.")
    
    @Parameter(title: "Select Workspace", default: nil)
    var selectedWorkspace: UCTAppEntity?
    
    static var parameterSummary: some ParameterSummary {
        Summary("Select Workspace: \(\.$selectedWorkspace)")
    }
}

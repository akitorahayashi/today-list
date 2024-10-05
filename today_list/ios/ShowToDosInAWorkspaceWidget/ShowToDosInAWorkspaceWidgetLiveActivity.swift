//
//  ShowToDosInAWorkspaceWidgetLiveActivity.swift
//  ShowToDosInAWorkspaceWidget
//
//  Created by 林 明虎 on 2024/10/05.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ShowToDosInAWorkspaceWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct ShowToDosInAWorkspaceWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ShowToDosInAWorkspaceWidgetAttributes.self) { context in
            // Lock screen/banner UI goes here
            VStack {
                Text("Hello \(context.state.emoji)")
            }
            .activityBackgroundTint(Color.cyan)
            .activitySystemActionForegroundColor(Color.black)

        } dynamicIsland: { context in
            DynamicIsland {
                // Expanded UI goes here.  Compose the expanded UI through
                // various regions, like leading/trailing/center/bottom
                DynamicIslandExpandedRegion(.leading) {
                    Text("Leading")
                }
                DynamicIslandExpandedRegion(.trailing) {
                    Text("Trailing")
                }
                DynamicIslandExpandedRegion(.bottom) {
                    Text("Bottom \(context.state.emoji)")
                    // more content
                }
            } compactLeading: {
                Text("L")
            } compactTrailing: {
                Text("T \(context.state.emoji)")
            } minimal: {
                Text(context.state.emoji)
            }
            .widgetURL(URL(string: "http://www.apple.com"))
            .keylineTint(Color.red)
        }
    }
}

extension ShowToDosInAWorkspaceWidgetAttributes {
    fileprivate static var preview: ShowToDosInAWorkspaceWidgetAttributes {
        ShowToDosInAWorkspaceWidgetAttributes(name: "World")
    }
}

extension ShowToDosInAWorkspaceWidgetAttributes.ContentState {
    fileprivate static var smiley: ShowToDosInAWorkspaceWidgetAttributes.ContentState {
        ShowToDosInAWorkspaceWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: ShowToDosInAWorkspaceWidgetAttributes.ContentState {
         ShowToDosInAWorkspaceWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: ShowToDosInAWorkspaceWidgetAttributes.preview) {
   ShowToDosInAWorkspaceWidgetLiveActivity()
} contentStates: {
    ShowToDosInAWorkspaceWidgetAttributes.ContentState.smiley
    ShowToDosInAWorkspaceWidgetAttributes.ContentState.starEyes
}

//
//  ShowToDoWidgetLiveActivity.swift
//  ShowToDoWidget
//
//  Created by 林 明虎 on 2024/09/05.
//

import ActivityKit
import WidgetKit
import SwiftUI

struct ShowToDoWidgetAttributes: ActivityAttributes {
    public struct ContentState: Codable, Hashable {
        // Dynamic stateful properties about your activity go here!
        var emoji: String
    }

    // Fixed non-changing properties about your activity go here!
    var name: String
}

struct ShowToDoWidgetLiveActivity: Widget {
    var body: some WidgetConfiguration {
        ActivityConfiguration(for: ShowToDoWidgetAttributes.self) { context in
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

extension ShowToDoWidgetAttributes {
    fileprivate static var preview: ShowToDoWidgetAttributes {
        ShowToDoWidgetAttributes(name: "World")
    }
}

extension ShowToDoWidgetAttributes.ContentState {
    fileprivate static var smiley: ShowToDoWidgetAttributes.ContentState {
        ShowToDoWidgetAttributes.ContentState(emoji: "😀")
     }
     
     fileprivate static var starEyes: ShowToDoWidgetAttributes.ContentState {
         ShowToDoWidgetAttributes.ContentState(emoji: "🤩")
     }
}

#Preview("Notification", as: .content, using: ShowToDoWidgetAttributes.preview) {
   ShowToDoWidgetLiveActivity()
} contentStates: {
    ShowToDoWidgetAttributes.ContentState.smiley
    ShowToDoWidgetAttributes.ContentState.starEyes
}

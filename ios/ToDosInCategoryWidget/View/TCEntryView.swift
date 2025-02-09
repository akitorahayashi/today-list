//
//  TCEntryView.swift
//  Runner
//
//  Created by 林 明虎 on 2025/02/09.
//

import WidgetKit
import SwiftUI

struct TCEntryView : View {
    var entry: TCProvider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        GeometryReader { geometry in
            TCToDoListView(entry: entry)
                .frame(width: geometry.size.width,
                       height: geometry.size.height,
                       alignment: .top)
        }
    }
}

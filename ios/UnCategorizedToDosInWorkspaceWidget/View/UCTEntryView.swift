//
//  UCTEntryView.swift
//  Runner
//
//  Created by 林明虎 on 2025/02/28.
//

import WidgetKit
import SwiftUI

struct UCTEntryView : View {
    var entry: UCTProvider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        GeometryReader { geometry in
            UCTToDoListView(entry: entry)
                .frame(width: geometry.size.width,
                       height: geometry.size.height,
                       alignment: .top)
        }
    }
}

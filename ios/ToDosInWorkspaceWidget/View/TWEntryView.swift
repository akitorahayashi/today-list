//
//  TWEntryView.swift
//  Runner
//
//  Created by akitora.hayashi on 2025/03/29.
//

import WidgetKit
import SwiftUI

struct TWEntryView : View {
    var entry: TWProvider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        GeometryReader { geometry in
            TWToDoListView(entry: entry)
                .frame(width: geometry.size.width,
                       height: geometry.size.height,
                       alignment: .top)
        }
    }
}

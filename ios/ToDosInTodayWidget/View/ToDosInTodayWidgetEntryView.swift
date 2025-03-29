//
//  ToDosInTodayWidgetEntryView.swift
//  Runner
//
//  Created by akitora.hayashi on 2025/03/29.
//

import SwiftUI

struct ToDosInTodayWidgetEntryView : View {
    var entry: TTProvider.Entry
    
    @Environment(\.widgetFamily) var widgetFamily
    
    var body: some View {
        GeometryReader { geometry in
            TTToDoListView(entry: entry)
                .frame(width: geometry.size.width,
                       height: geometry.size.height,
                       alignment: .top)
        }
    }
}

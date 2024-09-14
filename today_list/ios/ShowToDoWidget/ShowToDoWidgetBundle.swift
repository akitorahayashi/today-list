//
//  ShowToDoWidgetBundle.swift
//  ShowToDoWidget
//
//  Created by 林 明虎 on 2024/09/05.
//

import WidgetKit
import SwiftUI

@main
struct ShowToDoWidgetBundle: WidgetBundle {
    var body: some Widget {
        ShowToDoWidget()
        ShowToDoWidgetLiveActivity()
    }
}

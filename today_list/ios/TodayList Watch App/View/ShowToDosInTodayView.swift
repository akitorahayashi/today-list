//
//  ShowToDosInTodayView.swift
//  Runner
//
//  Created by 林 明虎 on 2024/10/05.
//

import SwiftUI

struct ShowToDosInTodayView: View {
    
    @State private var selectedColorTheme: String = UserDefaults(suiteName: "group.akitorahayashi.todayListGroup")?.string(forKey: "selectedTheme") ?? "Sun Orange"
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            TLWatchAppBar(selectedColorTheme: self.selectedColorTheme)
            
            ScrollView {
                Text("Congrats!")
            }
            
        }
    }
}

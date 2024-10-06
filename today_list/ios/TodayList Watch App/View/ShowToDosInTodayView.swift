//
//  ShowToDosInTodayView.swift
//  Runner
//
//  Created by 林 明虎 on 2024/10/05.
//

import SwiftUI

struct ShowToDosInTodayView: View {
    
    @ObservedObject var tlConnector = TLPhoneConnector()
    
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            TLWatchAppBar(appbarTitle: "todo",selectedColorTheme: self.tlConnector.selectedTheme)
            
            ScrollView {
                Text("Congrats!")
            }
            
        }
    }
}

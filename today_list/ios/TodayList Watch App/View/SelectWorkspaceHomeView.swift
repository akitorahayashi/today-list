//
//  SelectWorkspaceHomeView.swift
//  Runner
//
//  Created by 林 明虎 on 2024/10/05.
//


import SwiftUI

struct SelectWorkspaceHomeView: View {
    
    @State private var isSecondViewActive = false
    @State private var decodedWorkspaces: [TLWorkspace]?
    
    @ObservedObject var tlConnector = TLPhoneConnector()
    
    var body: some View {
        NavigationStack {
            VStack {
                TLWatchAppBar(appbarTitle: "workspace", selectedColorTheme: self.tlConnector.selectedTheme)
                
                ScrollView {
                    // ForEach to display TLWorkspace names
                    ForEach(tlConnector.decodedTLWorkspace) { tlWorkspace in
                        NavigationLink(destination: ShowToDosInTodayView()) {
                            Text(tlWorkspace.name) // Display workspace name
                                .padding()
                        }
                    }
                    
                }
            }
        }
        .background(kTLThemes[self.tlConnector.selectedTheme]?.backgroundColorOfToDoList ?? Color.clear) // nil handling
        .edgesIgnoringSafeArea(.all)
    }
}

//struct SelectWorkspaceHomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectWorkspaceHomeView()
//            .previewDevice("Apple Watch Series 9 - 41mm (watchOS 11.0)") // デバイス名を指定
//    }
//}

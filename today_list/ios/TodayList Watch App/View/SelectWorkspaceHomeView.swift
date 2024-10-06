//
//  SelectWorkspaceHomeView.swift
//  Runner
//
//  Created by 林 明虎 on 2024/10/05.
//


import SwiftUI

struct SelectWorkspaceHomeView: View {
    
    @State private var isSecondViewActive = false
    
    @ObservedObject var tlConnector = TLPhoneConnector()
    
    var body: some View {
        NavigationStack {
            VStack {
                TLWatchAppBar(selectedColorTheme: self.tlConnector.selectedTheme)
                
                ScrollView {
                    Button(action: {
                        isSecondViewActive = true
                    }) {
                        Text("Go to Second View")
                    }
                    .navigationDestination(isPresented: $isSecondViewActive) {
                        ShowToDosInTodayView()
                    }
                }
                
            }
            
        }
        .background(kTLThemes[self.tlConnector.selectedTheme]?.backgroundColorOfToDoList ?? Color.clear) // nilの場合の対策
        .edgesIgnoringSafeArea(.all)
    }
}

//struct SelectWorkspaceHomeView_Previews: PreviewProvider {
//    static var previews: some View {
//        SelectWorkspaceHomeView()
//            .previewDevice("Apple Watch Series 9 - 41mm (watchOS 11.0)") // デバイス名を指定
//    }
//}

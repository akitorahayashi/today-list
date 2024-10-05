//
//  ContentView.swift
//  TodayList Watch App
//
//  Created by 林 明虎 on 2024/10/05.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .previewDevice("Apple Watch Series 9 - 41mm (watchOS 11.0)") // デバイス名を指定
    }
}

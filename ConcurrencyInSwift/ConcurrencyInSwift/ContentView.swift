//
//  ContentView.swift
//  ConcurrencyInSwift
//
//  Created by Rakesh Yadav on 27/09/25.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            CurrentDateTimeView()
                .tabItem {
                    Label("Current Date", systemImage: "calendar")
                }
            NewsView()
                .tabItem {
                    Label("News App", systemImage: "clock")
                }
        }
    }
}

#Preview {
    ContentView()
}

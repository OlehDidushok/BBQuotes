//
//  ContentView.swift
//  BBQuotes
//
//  Created by Oleh on 17.12.2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView{
            Text("Breaking Bad View")
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label("Breaking Bad", systemImage: "tortoise")
                }
            
            Text("Better Call Saul View")
                .toolbarBackground(.visible, for: .tabBar)
                .tabItem {
                    Label("Better Call Saul", systemImage: "briefcase")
                }
        }
        .preferredColorScheme(.dark)
    }
}

#Preview {
    ContentView()
}

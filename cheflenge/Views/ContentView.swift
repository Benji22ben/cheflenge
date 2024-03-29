//
//  ContentView.swift
//  cheflenge
//
//  Created by Benjamin MARQUES on 04/03/2024.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            HomeView()
                .badge(/*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/).tabItem {
                    Label("Home", systemImage: "house")
                }
        }
    }
}

#Preview {
    ContentView()
}

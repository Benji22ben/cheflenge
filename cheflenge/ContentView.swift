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
            HomeView().badge(0).tabItem {
                Label("Accueil", systemImage: "house")
            };
            RecipeView().badge(0).tabItem {
                Label("Défi", systemImage: "fork.knife")
            };
            GalleryView().badge(0).tabItem {
                Label("Galerie", systemImage: "photo")
            };
        }
    }
}

#Preview {
    ContentView()
}

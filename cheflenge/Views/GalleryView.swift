//
//  GalleryView.swift
//  cheflenge
//
//  Created by Henri Phothinantha on 14/03/2024.
//

import SwiftUI

struct GalleryView: View {
    @State private var searchText = ""
    @State private var showFavoritesOnly = false
    @StateObject var recipesNetwork = RecipesNetwork()

    var filteredRecipes: [Recipe] {
        var filtered = recipesNetwork.recipes

        // Filtrer par favoris
        if showFavoritesOnly {
            filtered = filtered.filter { $0.favorite ?? false }
        }

        // Filtrer par recherche
        if !searchText.isEmpty {
            filtered = filtered.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }

        // Trier par date (le plus récent d'abord)
        filtered.sort { $0.createdAt > $1.createdAt }

        return filtered
    }

    var body: some View {
        PageWrapperView {
            VStack(spacing: 10) {
                SearchBar(text: $searchText)

                HStack {
                    Button(action: {
                        showFavoritesOnly.toggle()
                    }) {
                        Text("Favoris")
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .foregroundColor(showFavoritesOnly ? Color.white : .gray)
                            .background(showFavoritesOnly ? Color.accentColor : Color.clear)
                            .clipShape(RoundedRectangle(cornerRadius: 8))
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(showFavoritesOnly ? Color.accentColor : .gray, lineWidth: 1)
                            )
                    }
                    Spacer()
                }
            }
            
            ScrollView {
                GridTable(gridItems: filteredRecipes, numOfColumns: 2, recipesNetwork: recipesNetwork)
            }
        }.onAppear {
            recipesNetwork.fetchRecipes()
        }
        .refreshable {
            recipesNetwork.fetchRecipes()
        }
    }
}


#Preview {
    GalleryView()
}

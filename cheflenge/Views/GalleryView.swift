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

//    // Tri sur la date
//    var sortedCustomGridItems: [Recipe] {
//        return recipes.sorted(by: { $0.createdAt > $1.createdAt })
//    }
//
//    // Tri sur la recherche et la sélection des favoris
//    var filteredCustomGridItems: [Recipe] {
//        if searchText.isEmpty {
//            if showFavoritesOnly {
//                return sortedCustomGridItems.filter { $0.favorite ?? false }
//            } else {
//                return sortedCustomGridItems
//            }
//        } else {
//            if showFavoritesOnly {
//                return sortedCustomGridItems.filter { $0.title.localizedCaseInsensitiveContains(searchText) && ($0.favorite != nil) }
//            } else {
//                return sortedCustomGridItems.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
//            }
//        }
//    }

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
                GridTable(gridItems: recipesNetwork.recipes, numOfColumns: 2)
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

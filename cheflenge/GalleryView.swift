//
//  GalleryView.swift
//  cheflenge
//
//  Created by Henri Phothinantha on 14/03/2024.
//

import SwiftUI

var gridItems: [GridItem] = [
    GridItem(imgString: "spaghetti", title: "Spaghetti bolognese", creationDate: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 14)) ?? Date(), favorite: true),
    GridItem(imgString: "salad", title: "Salade César", creationDate: Calendar.current.date(from: DateComponents(year: 2023, month: 4, day: 7)) ?? Date()),
    GridItem(imgString: "pizza", title: "Pizza Margherita", creationDate: Calendar.current.date(from: DateComponents(year: 2023, month: 9, day: 18)) ?? Date(), favorite: true),
    GridItem(imgString: "cake", title: "Gâteau au chocolat", creationDate: Calendar.current.date(from: DateComponents(year: 2024, month: 2, day: 2)) ?? Date(), favorite: true),
    GridItem(imgString: "muffin", title: "Muffin au chocolat", creationDate: Calendar.current.date(from: DateComponents(year: 2024, month: 2, day: 5)) ?? Date()),
    GridItem(imgString: "lasagna", title: "Lasagne", creationDate: Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 1)) ?? Date())
]

struct GalleryView: View {
    @State private var searchText = ""
    @State private var showFavoritesOnly = false
    
    //Tri sur la date
    var sortedGridItems: [GridItem] {
            return gridItems.sorted(by: { $0.creationDate > $1.creationDate })
        }
    
    //Tri sur la recherche et la sélection des favoris
        var filteredGridItems: [GridItem] {
            if searchText.isEmpty {
                if showFavoritesOnly {
                    return sortedGridItems.filter { $0.favorite }
                } else {
                    return sortedGridItems
                }
            } else {
                if showFavoritesOnly {
                    return sortedGridItems.filter { $0.title.localizedCaseInsensitiveContains(searchText) && $0.favorite }
                } else {
                    return sortedGridItems.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
                }
            }
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
                GridTable(gridItems: filteredGridItems, numOfColumns: 2)
            }
        }
        
    }
}

#Preview {
    GalleryView()
}


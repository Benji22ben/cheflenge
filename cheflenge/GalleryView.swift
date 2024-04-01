//
//  GalleryView.swift
//  cheflenge
//
//  Created by Henri Phothinantha on 14/03/2024.
//

import SwiftUI

var gridItems: [CustomGridItem] = [
    CustomGridItem(imgString: "spaghetti", title: "Spaghetti bolognese", creationDate: Calendar.current.date(from: DateComponents(year: 2023, month: 8, day: 14)) ?? Date(), favorite: true),
    CustomGridItem(imgString: "salad", title: "Salade César", creationDate: Calendar.current.date(from: DateComponents(year: 2023, month: 4, day: 7)) ?? Date()),
    CustomGridItem(imgString: "pizza", title: "Pizza Margherita", creationDate: Calendar.current.date(from: DateComponents(year: 2023, month: 9, day: 18)) ?? Date(), favorite: true),
    CustomGridItem(imgString: "cake", title: "Gâteau au chocolat", creationDate: Calendar.current.date(from: DateComponents(year: 2024, month: 2, day: 2)) ?? Date(), favorite: true),
    CustomGridItem(imgString: "muffin", title: "Muffin au chocolat", creationDate: Calendar.current.date(from: DateComponents(year: 2024, month: 2, day: 5)) ?? Date()),
    CustomGridItem(imgString: "lasagna", title: "Lasagne", creationDate: Calendar.current.date(from: DateComponents(year: 2024, month: 1, day: 1)) ?? Date())
]

struct GalleryView: View {
    @State private var searchText = ""
    @State private var showFavoritesOnly = false
    
    //Tri sur la date
    var sortedCustomGridItems: [CustomGridItem] {
            return gridItems.sorted(by: { $0.creationDate > $1.creationDate })
        }
    
    //Tri sur la recherche et la sélection des favoris
        var filteredCustomGridItems: [CustomGridItem] {
            if searchText.isEmpty {
                if showFavoritesOnly {
                    return sortedCustomGridItems.filter { $0.favorite }
                } else {
                    return sortedCustomGridItems
                }
            } else {
                if showFavoritesOnly {
                    return sortedCustomGridItems.filter { $0.title.localizedCaseInsensitiveContains(searchText) && $0.favorite }
                } else {
                    return sortedCustomGridItems.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
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
                GridTable(gridItems: filteredCustomGridItems, numOfColumns: 2)
            }
        }
        
    }
}

#Preview {
    GalleryView()
}


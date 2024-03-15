//
//  GalleryView.swift
//  cheflenge
//
//  Created by Henri Phothinantha on 14/03/2024.
//

import SwiftUI

let gridItems = [
    GridItem(imgString: "spaghetti", title: "Spaghetti bolognese", creationDate: Date()),
    GridItem(imgString: "salad", title: "Salade César", creationDate: Date()),
    GridItem(imgString: "pizza", title: "Pizza Margherita", creationDate: Date()),
    GridItem(imgString: "cake", title: "Gâteau au chocolat", creationDate: Date()),
    GridItem(imgString: "muffin", title: "Muffin au chocolat", creationDate: Date()),
    GridItem(imgString: "lasagna", title: "Lasagne", creationDate: Date())
]

struct GalleryView: View {
    @State private var searchText = ""
    
    var filteredGridItems: [GridItem] {
        if searchText.isEmpty {
            return gridItems
        } else {
            return gridItems.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    var body: some View {
        PageWrapperView {
            SearchBar(text: $searchText)
            ScrollView {
                GridTable(gridItems: filteredGridItems, numOfColumns: 2)
            }
        }
        
    }
}

#Preview {
    GalleryView()
}


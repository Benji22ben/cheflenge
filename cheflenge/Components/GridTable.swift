//
//  GridTable.swift
//  cheflenge
//
//  Created by Henri Phothinantha on 15/03/2024.
//

import SwiftUI

struct GridTable: View {
    var recipesNetwork: RecipesNetwork
    
    struct Column: Identifiable {
        let id = UUID()
        var gridItems: [Recipe]
    }

    var columns: [Column]

    let spacing: CGFloat
    let horizontalPadding: CGFloat

    init(gridItems: [Recipe], numOfColumns: Int, recipesNetwork: RecipesNetwork, spacing: CGFloat = 20, horizontalPadding: CGFloat = 0) {
        self.spacing = spacing
        self.horizontalPadding = horizontalPadding
        self.recipesNetwork = recipesNetwork

        var columns = [Column]()
        for _ in 0 ..< numOfColumns {
            columns.append(Column(gridItems: [])) //
        }

        var columnsHeight = [CGFloat](repeating: 0, count: numOfColumns)

        for gridItem in gridItems {
            var smallestColumnIndex = 0
            var smallestHeight = columnsHeight.first!
            for i in 1 ..< columnsHeight.count {
                let curHeight = columnsHeight[i]
                if curHeight < smallestHeight {
                    smallestHeight = curHeight
                    smallestColumnIndex = i
                }
            }

            columns[smallestColumnIndex].gridItems.append(gridItem)

            columnsHeight[smallestColumnIndex] += CGFloat(gridItem.image?.height ?? Int(CGFloat.random(in: 150 ... 400)))
        }

        self.columns = columns
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: spacing) {
            ForEach(columns) { column in
                LazyVStack(spacing: spacing) {
                    ForEach(column.gridItems.indices, id: \.self) { index in
                        let gridItem = column.gridItems[index]
                        CustomGridItemView(gridItem: gridItem, toggleFavorite: {
                            recipesNetwork.toggleFavorite(for: gridItem)
                        })
                    }
                }
            }
        }
        .padding(.horizontal, horizontalPadding)
    }
}

struct CustomGridItemView: View {
    var gridItem: Recipe
    var toggleFavorite: () -> Void

    var body: some View {
        ZStack(alignment: .bottomLeading) {
            GeometryReader { reader in
                AsyncImage(url: URL(string: "\(API.BASE_URL)\(gridItem.image?.url ?? "")"), content: { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: reader.size.width, height: reader.size.height, alignment: .center)
                }, placeholder: { ProgressView() })
            }
            VStack(alignment: .leading, spacing: 0) {
                // Bouton de favoris
                if let favorite = gridItem.favorite {
                    Button(action: toggleFavorite) {
                        Image(systemName: favorite ? "star.fill" : "star")
                        .foregroundColor(favorite ? .yellow : .white)
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .foregroundColor(Color.black.opacity(0.2))
                                .frame(width: 30, height: 30)
                        )
                    }
                    .padding(.leading, 12)
                    .padding(.top, 12)
                }
                Spacer()
                Text(gridItem.title)
                    .foregroundColor(.white)
                    .font(.caption)
                    .padding(8)
                    .background(Color.accentColor.opacity(0.9))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding(8)
            }
        }
        .frame(height: CGFloat.random(in: 150 ... 400))
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 13))
    }
}



#Preview {
    GalleryView()
}

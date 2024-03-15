//
//  GridTable.swift
//  cheflenge
//
//  Created by Henri Phothinantha on 15/03/2024.
//

import SwiftUI

struct GridItem: Identifiable {
    let id = UUID()
    let height: CGFloat = CGFloat.random(in: 150...400)
    let imgString: String
    let title: String
    let creationDate: Date
}

struct GridTable: View {
    
    struct Column: Identifiable {
        let id = UUID()
        var gridItems = [GridItem]()
    }
    
    let columns: [Column]
    
    let spacing: CGFloat
    let horizontalPadding: CGFloat
    
    init(gridItems: [GridItem], numOfColumns: Int, spacing: CGFloat = 20, horizontalPadding: CGFloat = 0) {
        self.spacing = spacing
        self.horizontalPadding = horizontalPadding
        
        var columns = [Column]()
        for _ in 0 ..< numOfColumns {
            columns.append(Column())
        }
        
        var columnsHeight = Array<CGFloat>(repeating: 0, count: numOfColumns)
        
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
            columnsHeight[smallestColumnIndex] += gridItem.height
        }
        
        self.columns = columns
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: spacing) {
            ForEach(columns) { column in
                LazyVStack(spacing: spacing) { 
                    ForEach(column.gridItems) { gridItem in
                    
                        getItemView(gridItem: gridItem)
                        
                    }
                }
            }
        }
        .padding(.horizontal, horizontalPadding)
    }
    
    func getItemView(gridItem: GridItem) -> some View {
        ZStack(alignment: .bottomLeading) {
            GeometryReader { reader in
                Image(gridItem.imgString)
                    .resizable()
                    .scaledToFill()
                    .frame(width: reader.size.width,
                           height: reader.size.height,
                           alignment: .center)
            }
            
            Text(gridItem.title)
                .foregroundColor(.white)
                .font(.caption)
                .padding(8)
                .background(Color.accentColor.opacity(0.9))
                .clipShape(RoundedRectangle(cornerRadius: 8))
                .padding(8)
        }
        .frame(height: gridItem.height)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 13))
    }
}

#Preview {
    GalleryView()
}



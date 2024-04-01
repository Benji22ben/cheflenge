//
//  GridTable.swift
//  cheflenge
//
//  Created by Henri Phothinantha on 15/03/2024.
//

import SwiftUI

class CustomGridItem: Identifiable, ObservableObject {
    var id = UUID()
    var height: CGFloat = CGFloat.random(in: 150...400)
    var imgString: String
    var title: String
    var creationDate: Date
    @Published var favorite: Bool
    
    init(imgString: String, title: String, creationDate: Date, favorite: Bool = false) {
        self.imgString = imgString
        self.title = title
        self.creationDate = creationDate
        self.favorite = favorite
    }
}


struct GridTable: View {
    
    struct Column: Identifiable {
        let id = UUID()
        var gridItems: [CustomGridItem]
    }
    
    var columns: [Column]
    
    let spacing: CGFloat
    let horizontalPadding: CGFloat
    
    init(gridItems: [CustomGridItem], numOfColumns: Int, spacing: CGFloat = 20, horizontalPadding: CGFloat = 0) {
        self.spacing = spacing
        self.horizontalPadding = horizontalPadding
        
        var columns = [Column]()
        for _ in 0..<numOfColumns {
            columns.append(Column(gridItems: []))
        }
        
        var columnsHeight = Array<CGFloat>(repeating: 0, count: numOfColumns)
        
        for gridItem in gridItems {
            var smallestColumnIndex = 0
            var smallestHeight = columnsHeight.first!
            for i in 1..<columnsHeight.count {
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
                    ForEach(column.gridItems.indices, id: \.self) { index in
                        let gridItem = column.gridItems[index]
                        CustomGridItemView(gridItem: gridItem)
                    }
                }
            }
        }
        .padding(.horizontal, horizontalPadding)
    }
}

struct CustomGridItemView: View {
    @StateObject var gridItem: CustomGridItem
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            GeometryReader { reader in
                Image(gridItem.imgString)
                    .resizable()
                    .scaledToFill()
                    .frame(width: reader.size.width,
                           height: reader.size.height,
                           alignment: .center)
            }
            
            VStack(alignment: .leading, spacing: 0) {
                HStack {
                    Button(action: {
                        gridItem.favorite.toggle()
                    }) {
                        Image(systemName: gridItem.favorite ? "star.fill" : "star")
                            .foregroundColor(gridItem.favorite ? .yellow : .white)
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
        .frame(height: gridItem.height)
        .frame(maxWidth: .infinity)
        .clipShape(RoundedRectangle(cornerRadius: 13))
    }
}



#Preview {
    GalleryView()
}




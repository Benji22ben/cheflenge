//
//  GalleryView.swift
//  cheflenge
//
//  Created by Henri Phothinantha on 14/03/2024.
//

import SwiftUI

struct Recipe: Identifiable {
    let id = UUID()
    let title: String
    let imageName: String
    let creationDate: Date
}

let recipes: [Recipe] = [
    Recipe(title: "Spaghetti bolognese", imageName: "spaghetti", creationDate: Date()),
    Recipe(title: "Salade César", imageName: "salad", creationDate: Date()),
    Recipe(title: "Pizza Margherita", imageName: "pizza", creationDate: Date()),
    Recipe(title: "Gâteau au chocolat", imageName: "cake", creationDate: Date()),
    Recipe(title: "Muffin au chocolat", imageName: "muffin", creationDate: Date()),
    Recipe(title: "Lasagne", imageName: "lasagna", creationDate: Date())
]

struct GalleryView: View {
    @State private var searchText = ""

    var filteredRecipes: [Recipe] {
        if searchText.isEmpty {
            return recipes
        } else {
            return recipes.filter { $0.title.localizedCaseInsensitiveContains(searchText) }
        }
    }

    var body: some View {
            ZStack {
                ScrollView {
                    VStack(spacing: 10) {
                        ForEach(0..<filteredRecipes.count, id: \.self) { index in
                            if index % 2 == 0 {
                                HStack(spacing: 10) {
                                    RecipeImageView(imageName: filteredRecipes[index].imageName, maxWidth: 1 / 3)
                                    
                                    if index + 1 < filteredRecipes.count {
                                        RecipeImageView(imageName: filteredRecipes[index + 1].imageName, maxWidth: 2 / 3)
                                    }
                                }
                                .padding(.horizontal, 10)
                            } else {
                                HStack(spacing: 10) {
                                    RecipeImageView(imageName: filteredRecipes[index].imageName, maxWidth: 2 / 3)
                                    
                                    if index + 1 < filteredRecipes.count {
                                        RecipeImageView(imageName: filteredRecipes[index + 1].imageName, maxWidth: 1 / 3)
                                    }
                                }
                                .padding(.horizontal, 10)
                            }
                        }
                    }
                    .padding(.top, 60)
                }
                
                VStack {
                    SearchBar(text: $searchText)
                        .padding(.horizontal)
                        .padding(.bottom, 10)
                        .background(Color.white)
                    Spacer()
                }
            }
        }
}




#Preview {
    GalleryView()
}

struct RecipeImageView: View {
    var imageName: String
    var maxWidth:CGFloat
    
    var body: some View {
        Image(imageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .frame(maxWidth: UIScreen.main.bounds.width * maxWidth)
            .frame(height: 150)
            .cornerRadius(10)
            .clipped()
    }
}

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
                        if index % 3 == 0 { // Premier cas sur 3 : 2 images (1/3, 2/3)
                            HStack(spacing: 10) {
                                Image(filteredRecipes[index].imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                    .cornerRadius(10)
                                    .frame(maxWidth: UIScreen.main.bounds.width * 1 / 3)
                                    .frame(height: 150)
                                    
                                
                                Image(filteredRecipes[index + 1].imageName)
                                    .resizable()
                                    .cornerRadius(10)
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                    .frame(maxWidth: UIScreen.main.bounds.width * 2 / 3)
                                    .frame(height: 150)
              
                            }
                            .padding(.horizontal, 10)
                        } else if index % 3 == 1 { // Deuxième cas sur 3 : 2 images (2/3, 1/3)
                            HStack(spacing: 10) {
                                Image(filteredRecipes[index].imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: UIScreen.main.bounds.width * 2 / 3)
                                    .frame(height: 150)
                                    .cornerRadius(10)
                                    .clipped()
                     
                                
                                Image(filteredRecipes[index + 1].imageName)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(maxWidth: UIScreen.main.bounds.width * 1 / 3)
                                    .frame(height: 150)
                                    .cornerRadius(10)
                                    .clipped()
                            
                            }
                            .padding(.horizontal, 10)
                        } else { // Troisième cas sur 3 : 1 image prenant toute la largeur
                            Image(filteredRecipes[index].imageName)
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(maxWidth: UIScreen.main.bounds.width)
                                .frame(height: 150)
                                .cornerRadius(10)
                                .clipped()
                                .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 0))
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

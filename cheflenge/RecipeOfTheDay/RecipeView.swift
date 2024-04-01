//
//  RecipeView.swift
//  cheflenge
//
//  Created by Benjamin MARQUES on 04/03/2024.
//

import SwiftUI

struct RecipeView: View {
    @EnvironmentObject var recipeOfTheDayModel: RecipeOfTheDayModel
    @EnvironmentObject var recipeOfTheDayFlow: RecipeOfTheDayFlow

    var numberOfRectangle = 5

    var body: some View {
        ScrollView {
            PageWrapperView {
                TitleView(text: "DÉFI DU JOUR")
                SubTitleView(text: recipeOfTheDayModel.recipe.title)
                AsyncImage(url: URL(string: "\(API.BASE_URL)\(recipeOfTheDayModel.recipe.image?.url ?? "")"), content: { image in
                    image.resizable()
                        .aspectRatio(contentMode: .fill)
                        .clipped()
                        .frame(height: 116)
                        .cornerRadius(30)
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                },
                placeholder: { ProgressView() })
            }

            VStack(spacing: 32, content: {
                ScrollElementsView(subTitle: "Ingrédients", recipeOptions: recipeOfTheDayModel.recipe.ingredients)
                ScrollElementsView(subTitle: "Ustensiles", recipeOptions: recipeOfTheDayModel.recipe.utensils)
            })
            PageWrapperView {
                ForEach(Array(recipeOfTheDayModel.recipe.preparationStage.enumerated()), id: \.element) { index, step in
                    VStack {
                        HStack(alignment: .top) {
                            Text("\(index + 1).")
                                .fontWeight(.bold)
                            Text(step)
                        }.frame(maxWidth: .infinity, alignment: .leading)
                    }
                }
                NavigationLink(destination: CameraView().toolbar(.hidden, for: .tabBar)) {
                    Text("Valider le défi")
                }.padding(.horizontal, 30)
                    .padding(.vertical, 20)
                    .background(Color.accentColor)
                    .foregroundColor(Color.white)
                    .cornerRadius(10)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
            }
        }
    }
}

struct ScrollElementsView: View {
    var subTitle: String = "Subtitle"
    var recipeOptions: [Recipe.RecipeOptions] = []

    var body: some View {
        VStack {
            SubTitleView(text: subTitle)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(recipeOptions, id: \.self) { recipeOption in
                        VStack {
                            AsyncImage(url: URL(string: "\(API.BASE_URL)\(recipeOption.photo?.url ?? "")"), content: { image in
                                image.resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .clipped()
                                    .frame(width: 150, height: 150)
                                    .cornerRadius(30)
                                    .shadow(radius: 3)
                            },
                            placeholder: { ProgressView() })

                            Text(recipeOption.name).underline()
                        }
                    }
                }
                .padding(.horizontal, 16)
                .padding(.vertical, 6)
            }
        }
    }
}

#Preview {
    RecipeView()
        .environmentObject(RecipeOfTheDayModel())
        .environmentObject(RecipeOfTheDayFlow())
}
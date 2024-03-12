//
//  RecipeView.swift
//  cheflenge
//
//  Created by Benjamin MARQUES on 04/03/2024.
//

import SwiftUI

struct RecipeView: View {
    var recette = "Tartiflette : la vraie recette"

    var numberOfRectangle = 5

    var body: some View {
        ScrollView {
            PageWrapperView {
                TitleView(text: "DÉFI DU JOUR")
                SubTitleView(text: recette)
                Rectangle().fill(Color.white)
                    .cornerRadius(30)
                    .frame(height: 116)
                    .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
            }

            VStack(spacing: 28, content: {
                ScrollElementsView(subTitle: "Ingrédients")
                ScrollElementsView(subTitle: "Ustensiles")
            })
            PageWrapperView {
                ForEach(1 ... 10, id: \.self) { index in
                    VStack {
                        HStack {
                            Text("\(index).")
                                .fontWeight(.bold)
                            Text("this is a step of the recipe and this is long to test it")
                        }
                    }
                }
                Button {
                    // Add your button action here
                } label: {
                    Label("Valider le défi", systemImage: "camera.fill")
                }
                .padding(.horizontal, 30)
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

    var body: some View {
        VStack {
            SubTitleView(text: subTitle)
                .padding(.horizontal, 16)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 16) {
                    ForEach(1 ... 6, id: \.self) { _ in
                        VStack {
                            Rectangle()
                                .fill(Color.white)
                                .cornerRadius(30)
                                .frame(width: 150, height: 150)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                            Text("coucou").underline()
                        }
                    }
                }
                .padding(.leading, 16)
            }
        }
    }
}

#Preview {
    RecipeView()
}

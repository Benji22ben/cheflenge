//
//  RecipeView.swift
//  cheflenge
//
//  Created by Benjamin MARQUES on 04/03/2024.
//

import SwiftUI

struct RecipeView: View {
    var recette = "Tartiflette : la vraie recette"

    var body: some View {
        TitleView(text: "DÉFI DU JOUR")
        SubTitleView(text: recette)
        Spacer()
    }
}

#Preview {
    RecipeView()
}

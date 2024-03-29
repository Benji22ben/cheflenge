//
//  RecipeOfTheDayNavigation.swift
//  cheflenge
//
//  Created by Benjamin MARQUES on 15/03/2024.
//

import Foundation
import SwiftUI

enum RecipeOfTheDayNavigation {
    case Recipe
    case Camera
    case Library
}

struct RecipeOfTheDay: Identifiable {
    struct RecipeOptions: Identifiable, Hashable {
        let id: UUID
        let name: String
        let picture: String
    }

    let id: UUID
    let name: String
    let image: String
    let ingredients: [RecipeOptions]
    let ustensiles: [RecipeOptions]
    let steps: [String]

    init(id: UUID, name: String, image: String, ingredients: [RecipeOptions], ustensiles: [RecipeOptions], steps: [String]) {
        self.id = UUID()
        self.name = name
        self.image = image
        self.ingredients = ingredients
        self.ustensiles = ustensiles
        self.steps = steps
    }

    static func example() -> RecipeOfTheDay {
        RecipeOfTheDay(
            id: UUID(),
            name: "Spaghetti Bolognese",
            image: "spaghetti_bolognese.jpg",
            ingredients: [
                RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Spaghetti", picture: "spaghetti"),
                RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Ground Beef", picture: "ground_beef"),
                RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Tomato Sauce", picture: "tomato_sauce")
            ],
            ustensiles: [
                RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Pot", picture: "pot"),
                RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Pan", picture: "pan")
            ],
            steps: [
                "Cook the spaghetti according to the package instructions.",
                "In a pan, cook the ground beef until browned.",
                "Add the tomato sauce to the pan and simmer for 10 minutes.",
                "Drain the spaghetti and serve with the meat sauce on top."
            ])
    }

    static func examples() -> [RecipeOfTheDay] {
        [
            RecipeOfTheDay(
                id: UUID(),
                name: "Spaghetti Bolognese",
                image: "spaghetti_bolognese.jpg",
                ingredients: [
                    RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Spaghetti", picture: "spaghetti"),
                    RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Ground Beef", picture: "ground_beef"),
                    RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Tomato Sauce", picture: "tomato_sauce")
                ],
                ustensiles: [
                    RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Pot", picture: "pot"),
                    RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Pan", picture: "pan")
                ],
                steps: [
                    "Cook the spaghetti according to the package instructions.",
                    "In a pan, cook the ground beef until browned.",
                    "Add the tomato sauce to the pan and simmer for 10 minutes.",
                    "Drain the spaghetti and serve with the meat sauce on top."
                ]),
            RecipeOfTheDay(
                id: UUID(),
                name: "Vegetable Stir Fry",
                image: "vegetable_stir_fry.jpg",
                ingredients: [
                    RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Bell Peppers", picture: "bell_peppers"),
                    RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Broccoli", picture: "broccoli"),
                    RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Soy Sauce", picture: "soy_sauce")
                ],
                ustensiles: [
                    RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Wok", picture: "wok"),
                    RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Spatula", picture: "spatula")
                ],
                steps: [
                    "Heat oil in a wok over high heat.",
                    "Add the bell peppers and broccoli and stir fry for 5 minutes.",
                    "Add the soy sauce and stir fry for another 2 minutes.",
                    "Serve hot with rice."
                ]),
            RecipeOfTheDay(
                id: UUID(),
                name: "Chicken Curry",
                image: "chicken_curry.jpg",
                ingredients: [
                    RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Chicken Breast", picture: "chicken_breast"),
                    RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Curry Powder", picture: "curry_powder"),
                    RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Coconut Milk", picture: "coconut_milk")
                ],
                ustensiles: [
                    RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Pot", picture: "pot"),
                    RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Spoon", picture: "spoon")
                ],
                steps: [
                    "Cut the chicken breast into cubes.",
                    "In a pot, cook the chicken with curry powder until browned.",
                    "Add the coconut milk and simmer for 20 minutes.",
                    "Serve hot with rice."
                ]),
            RecipeOfTheDay(
                id: UUID(),
                name: "Pancakes",
                image: "pancakes.jpg",
                ingredients: [
                    RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Flour", picture: "flour"),
                    RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Eggs", picture: "eggs"),
                    RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Milk", picture: "milk")
                ],
                ustensiles: [
                    RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Bowl", picture: "bowl"),
                    RecipeOfTheDay.RecipeOptions(id: UUID(), name: "Pan", picture: "pan")
                ],
                steps: [
                    "In a bowl, mix together the flour, eggs, and milk.",
                    "Heat a pan over medium heat and pour in some of the batter.",
                    "Cook until bubbles form on the surface, then flip and cook until golden brown.",
                    "Serve with maple syrup and butter."
                ])
        ]
    }
}

class RecipeOfTheDayDataManager: ObservableObject {
    @Published var recipeOfTheDay = RecipeOfTheDay.example()
}

class UserRecipesDataManager: ObservableObject {
    @Published var userRecipes = RecipeOfTheDay.examples()
}

class RecipeOfTheDayFlow: ObservableObject {
    static let shared = RecipeOfTheDayFlow()

    @Published var path = NavigationPath()

    func navigateBackToRoot() {
        path.removeLast(path.count)
    }
}

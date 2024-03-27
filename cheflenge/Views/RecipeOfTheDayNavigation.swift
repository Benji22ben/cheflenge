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

struct RecipeOfTheDay: Identifiable, Hashable {
    let id: UUID
    let name: String
    let image: String
    let ingredients: [String]
    let ustensiles: [String]

    init(id: String, name: String, image: String, ingredients: [String], ustensiles: [String]) {
        self.id = UUID()
        self.name = name
        self.image = image
        self.ingredients = ingredients
        self.ustensiles = ustensiles
    }

    static func example() -> RecipeOfTheDay {
        RecipeOfTheDay(id: "1", name: "Tartiflette Classique", image: "/jpg", ingredients: ["Lentilles, Pain, Avion"], ustensiles: ["Casseroles", "Poils", "Cuillère à cafe"])
    }

    static func examples() -> [RecipeOfTheDay] {
        [
            RecipeOfTheDay(id: "1", name: "Tartiflette Classique", image: "/jpg", ingredients: ["Lentilles, Pain, Avion"], ustensiles: ["Casseroles", "Poils", "Cuillère à cafe"]),
            RecipeOfTheDay(id: "2", name: "Spaghetti Bolognese", image: "/jpg", ingredients: ["Spaghetti, Tomates, Viande hachée"], ustensiles: ["Casserole, Poêle, Cuillère en bois"]),
            RecipeOfTheDay(id: "3", name: "Salade Niçoise", image: "/jpg", ingredients: ["Laitue, Thon, Oeufs, Tomates"], ustensiles: ["Bol, Cuillère, Fourchette"])
        ]
    }
}

class RecipeOfTheDayDataManager: ObservableObject {
    @Published var recipeOfTheDay = RecipeOfTheDay.example()
    @Published var userRecipes = RecipeOfTheDay.examples()
}

class RecipeOfTheDayPath {
    @ViewBuilder
    static func setViewForDestination(_ destination: RecipeOfTheDayNavigation, _ photoCollection: PhotoCollection? = nil) -> some View {
        switch destination {
        case .Recipe:
            RecipeView()
        case .Camera:
            CameraView()
        case .Library:
            if let photoCollection {
                PhotoCollectionView(photoCollection: photoCollection)
            } else {
                // Return a default view or an error view when photoCollection is nil
                Text("Error: Photo collection is nil")
            }
        }
    }
}

class RecipeOfTheDayFlow: ObservableObject {
    static let shared = RecipeOfTheDayFlow()

    @Published var path = NavigationPath()
    @Published var recipeOfTheDay: RecipeOfTheDay = .init(id: "", name: "", image: "", ingredients: [], ustensiles: [])

    func clear() {
        path = .init()
    }

    func navigateBackToRoot() {
        path.removeLast(path.count)
    }

    func backToPrevious() {
        path.removeLast()
    }

    func navigateToRecipeView() {
        path.append(RecipeOfTheDayNavigation.Recipe)
    }

    func navigateToCameraView() {
        path.append(RecipeOfTheDayNavigation.Camera)
    }

    func navigateToLibraryView() {
        path.append(RecipeOfTheDayNavigation.Library)
    }

    func done() {
        path = .init()
    }
}

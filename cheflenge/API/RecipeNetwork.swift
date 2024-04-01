//
//  RecipeOfTheDay.swift
//  cheflenge
//
//  Created by Benjamin MARQUES on 01/04/2024.
//

import Foundation

class RecipeOfTheDayNetworkManager: ObservableObject {
    @Published var recipe = Recipe(id: 1, title: "", image: nil, preparationStage: [], isEvent: false, endEvent: "", ingredients: [], utensils: [], createdAt: "", updatedAt: "", publishedAt: "", favorite: false)

    func fetchRecipeOfTheDay() {
        let url = API.BASE_URL.appendingPathComponent("/\(API.Paths.recipeOfTheDay)")

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(API.JWT)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Recipe.self, from: data)
                    DispatchQueue.main.async {
                        self.recipe = response
                    }
                } catch {
                    print("Error: \(error)")
                }
            }
        }.resume()
    }
}

class RecipesNetwork: ObservableObject {
    @Published var recipes: [Recipe] = []

    func fetchRecipes() {
        let url = API.BASE_URL.appendingPathComponent("/\(API.Paths.recipes)")

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer \(API.JWT)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode([Recipe].self, from: data)
                    DispatchQueue.main.async {
                        self.recipes = response
                    }
                } catch {
                    print("Error: \(error)")
                }
            }
        }.resume()
    }
}

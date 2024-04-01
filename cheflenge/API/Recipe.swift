//
//  RecipeOfTheDay.swift
//  cheflenge
//
//  Created by Benjamin MARQUES on 01/04/2024.
//

import Foundation

class RecipeOfTheDayNetworkManager: ObservableObject {
    @Published var recipe = Recipe(id: 1, title: "", image: nil, preparationStage: [], isEvent: false, endEvent: "", ingredients: [], utensils: [], createdAt: "", updatedAt: "", publishedAt: "")

    func fetchRecipeOfTheDay() {
        let url = API.BASE_URL.appendingPathComponent("/\(API.Paths.recipeOfTheDay)")

        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzExOTA4MDIyLCJleHAiOjE3MTQ1MDAwMjJ9.YjXYh8n-PmnWdwIEeeGaITcJtHmnTkpZEVvVYm9ETcE", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTask(with: request) { data, _, _ in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(Recipe.self, from: data)
                    print(response)
                    DispatchQueue.main.async {
                        self.recipe = response
                    }
                } catch {
                    print("C'est une erreur")
                    print("Error: \(error)")
                }
            }
        }.resume()
    }
}

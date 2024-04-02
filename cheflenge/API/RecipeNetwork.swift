//
//  RecipeOfTheDay.swift
//  cheflenge
//
//  Created by Benjamin MARQUES on 01/04/2024.
//

import Foundation
import SwiftUI

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

    func postRecipeOfTheDayPicture(imageData: Data, recipeName: String, recipeId: Int, completion: @escaping (Result<String, Error>) -> Void) {
        let url = API.BASE_URL.appendingPathComponent("/\(API.Paths.uploadPictureForRecipe)")
        var request = URLRequest(url: url)
        var imageFromData = UIImage(data: imageData)

        request.httpMethod = "POST" // create boundary
        request.setValue("Bearer \(API.JWT)", forHTTPHeaderField: "Authorization")

        let boundary = "Boundary-\(UUID().uuidString)"
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type") // call createDataBody method

        var body = Data()

        // Add image data
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"picture\"; filename=\"\(recipeName).jpg\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(imageData)
        body.append("\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"recipeId\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(recipeId)\r\n".data(using: .utf8)!)

        request.httpBody = body

        let task = URLSession.shared.uploadTask(with: request, from: body) { data, response, error in
            guard let data = data, let response = response as? HTTPURLResponse, error == nil else {
                completion(.failure(error!))
                return
            }

            guard response.statusCode == 200 else {
                completion(.failure(NSError(domain: "", code: response.statusCode, userInfo: nil)))
                return
            }

            do {
                let result = try JSONDecoder().decode(String.self, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(error))
            }
        }

        task.resume()
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
                    var response = try JSONDecoder().decode([Recipe].self, from: data)
                    
                    // Initialize favorite to false for each recipe
                    response = response.map { recipe in
                        var updatedRecipe = recipe
                        updatedRecipe.favorite = false
                        return updatedRecipe
                    }
                    
                    DispatchQueue.main.async {
                        self.recipes = response
                    }
                } catch {
                    print("Error: \(error)")
                }
            }
        }.resume()
    }
    
    func toggleFavorite(for recipe: Recipe) {
        if let index = recipes.firstIndex(where: { $0.id == recipe.id }) {
            recipes[index].favorite?.toggle()
            
            // Envoi de la mise à jour de l'état favori à Strapi
            let url = API.BASE_URL.appendingPathComponent(API.Paths.toggleFavorite)
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("Bearer \(API.JWT)", forHTTPHeaderField: "Authorization")
            
            let parameters: [String: Any] = [
                "recipeId": recipe.id,
                "isFavorite": recipes[index].favorite ?? false
            ]
            
            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
            } catch {
                print("Error: \(error)")
                return
            }
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("Error: \(error)")
                    return
                }
                
                // Gérer la réponse de Strapi si nécessaire
            }.resume()
        }
    }
}

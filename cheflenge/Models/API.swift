//
//  Constants.swift
//  cheflenge
//
//  Created by Benjamin MARQUES on 31/03/2024.
//

import Foundation

enum API {
    static let BASE_URL = URL(string: "https://cheflenge.benjamin-marques-balula.fr")!

    static let JWT = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MSwiaWF0IjoxNzExOTA4MDIyLCJleHAiOjE3MTQ1MDAwMjJ9.YjXYh8n-PmnWdwIEeeGaITcJtHmnTkpZEVvVYm9ETcE"
    enum Paths {
        static let recipeOfTheDay: String = "api/get/recipeOfTheDay"
        static let recipes: String = "api/get/recipes"
        static let toggleFavorite: String = "api/favorite-recipe/toggle"
        static let uploadPictureForRecipe: String = "api/user-picture-for-recipe/upload"
    }
}

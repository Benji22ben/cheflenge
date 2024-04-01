//
//  Constants.swift
//  cheflenge
//
//  Created by Benjamin MARQUES on 31/03/2024.
//

import Foundation

enum API {
    static let BASE_URL = URL(string: "https://cheflenge.benjamin-marques-balula.fr")!

    enum Paths {
        static let recipeOfTheDay: String = "api/get/recipeOfTheDay"
    }
}

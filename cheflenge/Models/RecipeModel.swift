//
//  RecipeNavigation.swift
//  cheflenge
//
//

import Foundation
import SwiftUI

struct Recipe: Identifiable, Decodable {
    struct RecipeOptions: Identifiable, Hashable, Decodable {
        let id: Int
        let name: String
        let photo: StrapiPictures?
        let createdAt: String
        let updatedAt: String
        let publishedAt: String
    }

    let id: Int
    let title: String
    let image: StrapiPictures?
    let preparationStage: [String]
    let isEvent: Bool?
    let endEvent: String?
    let ingredients: [RecipeOptions]
    let utensils: [RecipeOptions]
    let createdAt: String
    let updatedAt: String
    let publishedAt: String
    var favorite: Bool?
}

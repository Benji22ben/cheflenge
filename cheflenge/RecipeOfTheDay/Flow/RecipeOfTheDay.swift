//
//  RecipeOfTheDay.swift
//  cheflenge
//
//  Created by Benjamin MARQUES on 01/04/2024.
//

import Foundation
import SwiftUI

class RecipeOfTheDayFlow: ObservableObject {
    static let shared = RecipeOfTheDayFlow()

    @Published var path = NavigationPath()

    func navigateBackToRoot() {
        path.removeLast(path.count)
    }
}

//
//  SearchBar.swift
//  cheflenge
//
//  Created by Henri Phothinantha on 14/03/2024.
//

import SwiftUI

struct SearchBar: View {
    @Binding var text: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(Color.gray)
                .padding(.leading, 8)
            TextField("Rechercher", text: $text)
                .padding(15)
                .background(Color.clear)
                .cornerRadius(8)
                .padding(.trailing, 8)
        }
        .padding(.horizontal)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
        )
    }
}


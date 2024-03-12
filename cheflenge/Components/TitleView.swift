//
//  TitleView.swift
//  cheflenge
//
//  Created by Benjamin MARQUES on 12/03/2024.
//

import SwiftUI

struct TitleView: View {
    var text: String = "Title"

    var body: some View {
        Text(text).frame(maxWidth: .infinity, alignment: .leading).font(.largeTitle)
            .fontWeight(.bold)
    }
}

#Preview {
    TitleView()
}

//
//  SubTitleView.swift
//  cheflenge
//
//  Created by Benjamin MARQUES on 12/03/2024.
//

import SwiftUI

struct SubTitleView: View {
    var text: String = "Subtitle"

    var body: some View {
        Text(text).frame(maxWidth: .infinity, alignment: .leading).font(.title2)
    }
}

#Preview {
    SubTitleView()
}

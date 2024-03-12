//
//  PageWrapperView.swift
//  cheflenge
//
//  Created by Benjamin MARQUES on 12/03/2024.
//

import SwiftUI

struct PageWrapperView<Content: View>: View {
    var content: () -> Content

    init(@ViewBuilder content: @escaping () -> Content) {
        self.content = content
    }

    var body: some View {
        VStack(spacing: 28, content: content)
            .padding()
    }
}

#Preview {
    PageWrapperView {
        Text("Child component")
    }
}

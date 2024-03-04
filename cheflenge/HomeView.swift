//
//  HomeView.swift
//  cheflenge
//
//  Created by Benjamin MARQUES on 04/03/2024.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack (spacing: 20, content: {
                Text ("CHEF'LENGE").frame(maxWidth: .infinity, alignment: .leading).font(.largeTitle)
                    .fontWeight(.bold)
                VStack {
                    Text ("Aujourd'hui").frame(maxWidth: .infinity, alignment: .leading)
                    VStack {
                        NavigationLink(destination: RecipeView()) {
                            RoundedRectangle(cornerRadius: 30)
                                .fill(Color.purple)
                                    .aspectRatio(1.5, contentMode: .fit)
                                    .frame(width: .infinity)
                        }
                    }
                    
                }
            })
            .padding()
            Spacer()
        }
        
    }
}

#Preview {
    HomeView()
}

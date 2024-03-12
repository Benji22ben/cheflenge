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
            PageWrapperView {
                TitleView(text: "CHEF'LENGE")
                TodayRecipeView()
                TimeBlockView()
            }
            Spacer()
        }
    }
}

#Preview {
    HomeView()
}

struct TodayRecipeView: View {
    var body: some View {
        VStack {
            SubTitleView(text: "Aujourd'hui")
            VStack {
                NavigationLink(destination: RecipeView()) {
                    RoundedRectangle(cornerRadius: 30)
                        .fill(Color.accentColor)
                        .frame(width: .infinity, height: 200)
                }
            }
        }
    }
}

struct TimeBlockView: View {
    var body: some View {
        VStack {
            SubTitleView(text: "Prochain défi dans")
            ZStack {
                Color.black
                    .cornerRadius(30)
                    .frame(maxHeight: 116)
                HStack {
                    Image(systemName: "clock")
                        .resizable()
                        .foregroundColor(.white)
                        .scaledToFit()
                        .frame(maxWidth: 50)
                    Spacer()
                    Text("14:18:26").foregroundColor(.white).font(.largeTitle)
                }.padding(40)
            }
        }
    }
}

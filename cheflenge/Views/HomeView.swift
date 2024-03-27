//
//  HomeView.swift
//  cheflenge
//
//  Created by Benjamin MARQUES on 04/03/2024.
//

import SwiftUI

struct HomeView: View {
    @EnvironmentObject var recipeoftheday: RecipeOfTheDayFlow
    @State private var photoCollection: PhotoCollection?

    var body: some View {
        NavigationStack {
            PageWrapperView {
                TitleView(text: "CHEF'LENGE")
                TodayRecipeView()
                TimeBlockView()
            }
            Spacer()
        }
//        .navigationDestination(for: RecipeOfTheDayNavigation.self) { destination in
//            RecipeOfTheDayPath.setViewForDestination(destination, photoCollection)
//        }
    }
}

#Preview {
    HomeView()
}

struct TodayRecipeView: View {
    @StateObject var recipeOfTheDay = RecipeOfTheDayDataManager()
    @StateObject var recipeOfTheDayFlow = RecipeOfTheDayFlow()

    var body: some View {
        VStack {
            SubTitleView(text: "Aujourd'hui")
            NavigationStack(path: $recipeOfTheDayFlow.path) {
                VStack {
                    ZStack(alignment: .bottom) {
                        Image("recipeoftheday")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .clipped()
                            .frame(width: .infinity, height: 200)
                            .cornerRadius(30)

                        ZStack {
                            Color.accentColor
                                .cornerRadius(10)
                            HStack {
                                Text("Défi du jour").foregroundStyle(Color("SecondColor"))

                                Image(systemName: "arrow.right").foregroundColor(Color("SecondColor"))
                            }.padding(.horizontal, 30)
                        }.frame(width: 260, height: 50, alignment: .bottom)
                            .padding()
                    }
                    .frame(width: .infinity, height: 200)
                }
            }.environmentObject(recipeOfTheDayFlow)
        }
    }
}

struct TimeBlockView: View {
    var body: some View {
        VStack {
            SubTitleView(text: "Prochain défi dans")
            ZStack {
                Color("TertiaryColor").cornerRadius(30)
                    .frame(maxHeight: 116)
                HStack {
                    let currentDate = Date()
                    let calendar = Calendar.current
                    let hour = calendar.component(.hour, from: currentDate)
                    let minutes = calendar.component(.minute, from: currentDate)
                    let seconds = calendar.component(.second, from: currentDate)

                    Image(systemName: "clock")
                        .resizable()
                        .foregroundColor(Color("SecondColor"))
                        .scaledToFit()
                        .frame(maxWidth: 50)
                    Spacer()
                    Text("\(hour):\(minutes):\(seconds)").foregroundColor(Color("SecondColor")).font(.largeTitle)
                }.padding(40)
            }
        }
    }
}

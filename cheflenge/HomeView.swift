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
            }
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

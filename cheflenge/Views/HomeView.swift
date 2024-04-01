//
//  HomeView.swift
//  cheflenge
//
//  Created by Benjamin MARQUES on 04/03/2024.
//

import SwiftUI

struct HomeView: View {
    @StateObject var recipeOfTheDay = RecipeOfTheDayNetworkManager()

    var body: some View {
        NavigationStack {
            PageWrapperView {
                TitleView(text: "CHEF'LENGE")
                TodayRecipeView(imageOfRecipe: recipeOfTheDay.recipe.image?.url ?? "")
                TimeBlockView(dateFromAPI: recipeOfTheDay.recipe.endEvent ?? "2024-01-01T00:00:00.000Z")
            }
            Spacer()
        }
        .onAppear {
            recipeOfTheDay.fetchRecipeOfTheDay()
        }
        .environmentObject(recipeOfTheDay)
    }
}

#Preview {
    HomeView()
}

struct TodayRecipeView: View {
    var imageOfRecipe: String = ""

    var body: some View {
        VStack {
            SubTitleView(text: "Aujourd'hui")
            VStack {
                ZStack(alignment: .bottom) {
                    NavigationLink(destination: RecipeView()) {
                        AsyncImage(url: URL(string: "\(API.BASE_URL)\(imageOfRecipe)"), content: { image in
                            image.resizable()
                                .aspectRatio(contentMode: .fill)
                                .clipped()
                                .frame(height: 200)
                                .cornerRadius(30)
                        },
                        placeholder: { ProgressView() })
                    }

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
                .frame(height: 200)
            }
        }
    }
}

struct TimeBlockView: View {
    var dateFromAPI: String = ""
    let dateFormatter = DateFormatter()

    var remainTime: Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // Set the desired date format
        return dateFormatter.date(from: dateFromAPI)
    }

    var body: some View {
        VStack {
            SubTitleView(text: "Prochain défi dans")
            ZStack {
                Color("TertiaryColor").cornerRadius(30)
                    .frame(maxHeight: 116)
                HStack {
                    Image(systemName: "clock")
                        .resizable()
                        .foregroundColor(Color("SecondColor"))
                        .scaledToFit()
                        .frame(maxWidth: 50)
                    Spacer()
                    if let remainTime = remainTime {
                        let calendar = Calendar.current
                        let currentDate = Date()
                        let components = calendar.dateComponents([.hour, .minute, .second], from: currentDate, to: remainTime)

                        let hour = components.hour ?? 0
                        let minute = components.minute ?? 0
                        let second = components.second ?? 0

                        Text("\(hour):\(minute):\(second)").foregroundColor(Color("SecondColor")).font(.largeTitle)
                    } else {
                        Text("Invalid date format").foregroundColor(Color("SecondColor")).font(.largeTitle)
                    }
                }.padding(40)
            }
        }
    }
}

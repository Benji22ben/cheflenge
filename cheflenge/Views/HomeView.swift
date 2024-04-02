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
    
    @State var remainingSeconds: Int = 0
    @State var displaySeconds: String = "--"
    @State var displayMinutes: String = "--"
    @State var displayHours: String = "--"
    
    @State private var timer: Timer?
    
    var remainTime: Date? {
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ" // Set the desired date format
        return dateFormatter.date(from: dateFromAPI)
    }
    
    func manageTime(remainingTime: Date) -> Void {
        if let remainTime = remainTime {
            let calendar = Calendar.current
            let currentDate = Date()
            let components = calendar.dateComponents([.second], from: currentDate, to: remainTime)
            remainingSeconds = components.second ?? 0
            timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
                if remainingSeconds > 0 {
                    remainingSeconds -= 1
                    displayHours = String(remainingSeconds / 3600)
                    displayMinutes = String((remainingSeconds % 3600) / 60)
                    let formatSeconds: Int = (remainingSeconds % 3600) % 60
                    if (formatSeconds < 10) {
                        displaySeconds = "0" + String(formatSeconds)
                    } else {
                        displaySeconds = String((remainingSeconds % 3600) % 60)
                    }
                } else {
                    displayHours = "--"
                    displayMinutes = "--"
                    displaySeconds = "--"
                    
                    timer.invalidate()
                }
            }
        } else {
            displayHours = "-1"
        }
    }
    
    
    var body: some View {
        VStack {
            Text("Prochain défi dans")
                .font(.subheadline)
                .foregroundColor(Color("TertiaryColor"))
            ZStack {
                Color("TertiaryColor")
                    .cornerRadius(30)
                    .frame(maxHeight: 116)
                HStack {
                    Image(systemName: "clock")
                        .resizable()
                        .foregroundColor(Color("SecondColor"))
                        .scaledToFit()
                        .frame(maxWidth: 50)
                    Spacer()
                    if (displayHours == "-1"){
                        Text("Invalid date format").foregroundColor(Color("SecondColor")).font(.largeTitle)
                    } else {
                        Text("\(displayHours):\(displayMinutes):\(displaySeconds)")
                            .foregroundColor(Color("SecondColor"))
                            .font(.largeTitle)
                    }
                }
                .padding(40)
            }
        }.task(id: remainTime) {
            if let remainTime = remainTime {
                manageTime(remainingTime: remainTime)
            }
        }
        .onDisappear {
            timer?.invalidate()
        }
    }
}

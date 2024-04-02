/// Copyright (c) 2021 Razeware LLC
///
/// Permission is hereby granted, free of charge, to any person obtaining a copy
/// of this software and associated documentation files (the "Software"), to deal
/// in the Software without restriction, including without limitation the rights
/// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
/// copies of the Software, and to permit persons to whom the Software is
/// furnished to do so, subject to the following conditions:
///
/// The above copyright notice and this permission notice shall be included in
/// all copies or substantial portions of the Software.
///
/// Notwithstanding the foregoing, you may not use, copy, modify, merge, publish,
/// distribute, sublicense, create a derivative work, and/or sell copies of the
/// Software in any work that is designed, intended, or marketed for pedagogical or
/// instructional purposes related to programming, coding, application development,
/// or information technology.  Permission for such use, copying, modification,
/// merger, publication, distribution, sublicensing, creation of derivative works,
/// or sale is expressly withheld.
///
/// This project and source code may use libraries or frameworks that are
/// released under various Open-Source licenses. Use of those libraries and
/// frameworks are governed by their own individual licenses.
///
/// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
/// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
/// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
/// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
/// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
/// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
/// THE SOFTWARE.

import SwiftUI

struct CameraView: View {
    @StateObject private var model = ContentViewModel()
    @State private var showPicture = false
    @State var recipeOfTheDay: RecipeOfTheDayNetworkManager
    @State var recipe: Recipe

    var body: some View {
        ZStack {
            FrameView(image: model.frame, model: model)
                .edgesIgnoringSafeArea(.all)

            ErrorView(error: model.error)
        }.sheet(isPresented: $showPicture, content: {
            if let cgImage = model.capturedPhoto {
                ZStack {
                    Image(cgImage, scale: 1.0, orientation: .right, label: Text("Coucou"))
                        .resizable()
                    Spacer()
                    Button(action: {}, label: {
                        Text("Envoyer cette image")
                            .padding(.horizontal, 30)
                            .padding(.vertical, 20)
                            .background(Color.accentColor)
                            .foregroundColor(Color.white)
                            .cornerRadius(10)
                            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                    })
                }
            }
        })
        .onReceive(model.$capturedPhoto) { image in
            if image != nil {
                showPicture.toggle()
                guard let image = image else {
                    return
                }

                let uiImage = UIImage(cgImage: image)

                recipeOfTheDay.postRecipeOfTheDayPicture(imageData: uiImage.jpegData(compressionQuality: 0.8)!, recipeName: recipeOfTheDay.recipe.title, recipeId: recipeOfTheDay.recipe.id)
            }
        }
    }
}

struct CameraView_Previews: PreviewProvider {
    static var previews: some View {
        CameraView(recipeOfTheDay: RecipeOfTheDayNetworkManager(), recipe: RecipeOfTheDayNetworkManager().recipe)
    }
}

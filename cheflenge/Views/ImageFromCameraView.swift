import AVFoundation
import os.log
import SwiftUI
import UIKit

struct ImageFromCameraView: View {
    @State var cgImage: CGImage?

    var body: some View {
        VStack {
            ZStack {
                if let image = cgImage {
                    Image(cgImage!, scale: 1.0, orientation: .right, label: Text("Coucou"))
                        .resizable()
                } else {
                    Text("No image loaded")
                }
                Spacer()
//                Button(action: {}, label: {
//                    Text("Envoyer cette image")
//                        .padding(.horizontal, 30)
//                        .padding(.vertical, 20)
//                        .background(Color.accentColor)
//                        .foregroundColor(Color.white)
//                        .cornerRadius(10)
//                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
//                })
            }
        }
    }
}

#Preview {
    ImageFromCameraView()
}

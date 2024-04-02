import AVFoundation
import os.log
import SwiftUI
import UIKit

struct ImageFromCameraView: View {
    @State private var imageData: Data?

    var body: some View {
        VStack {
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
            } else {
                Text("No image captured")
            }
        }
    }
}

#Preview {
    ImageFromCameraView()
}

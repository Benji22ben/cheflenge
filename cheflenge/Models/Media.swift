//
//  Media.swift
//  cheflenge
//
//  Created by Benjamin MARQUES on 01/04/2024.
//

import Foundation
import SwiftUI

struct Media {
    let key: String
    let filename: String
    let data: Data
    let mimeType: String

    init?(withImage image: Data, forKey key: String) {
        self.key = key
        mimeType = "image/jpeg"
        filename = "imagefile.jpg"
        data = image
    }
}

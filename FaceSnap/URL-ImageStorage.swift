//
//  URL-ImageStorage.swift
//  FaceSnap
//
//  Created by Edwin Przeźwiecki Jr. on 12/02/2023.
//

//import Foundation
//import UIKit
//
//extension URL {
//    func loadImage(_ image: inout UIImage?, fromURL url: URL) {
//        if let data = try? Data(contentsOf: url), let loaded = UIImage(data: data) {
//            image = loaded
//        } else {
//            image = nil
//        }
//    }
//    
//    func saveImage(_ image: UIImage?) {
//        if let image = image {
//            if let data = image.jpegData(compressionQuality: 0.8) {
//                try? data.write(to: self)
//            }
//        } else {
//            try? FileManager.default.removeItem(at: self)
//        }
//    }
//}

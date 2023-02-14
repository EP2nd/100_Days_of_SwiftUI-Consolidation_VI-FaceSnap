//
//  UIImage-SaveAndLoad.swift
//  FaceSnap
//
//  Created by Edwin Przeźwiecki Jr. on 14/02/2023.
//

import UIKit

extension UIImage {
    static func loadImageFromDisk(imageName: String) -> UIImage? {
        let url = FileManager.documentsDirectory.appendingPathComponent(imageName)
        
        do {
            let imageData = try Data(contentsOf: url)
            return UIImage(data: imageData)
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }
}

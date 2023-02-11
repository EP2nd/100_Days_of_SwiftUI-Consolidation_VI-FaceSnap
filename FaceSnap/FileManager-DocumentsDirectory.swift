//
//  FileManager-DocumentsDirectory.swift
//  FaceSnap
//
//  Created by Edwin Przeźwiecki Jr. on 11/02/2023.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        self.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
    }
}

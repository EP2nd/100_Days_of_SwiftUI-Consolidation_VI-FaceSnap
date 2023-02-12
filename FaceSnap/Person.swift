//
//  User.swift
//  FaceSnap
//
//  Created by Edwin Przeźwiecki Jr. on 11/02/2023.
//

import Foundation

class SharedPeople: ObservableObject {
    @Published var personDetails = [Person]()
}

struct Person: Codable, Equatable, Identifiable, Comparable {
    var id = UUID()
    var photoID: String
    var name: String
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    
    static var example = Person(id: UUID(), photoID: "", name: "Harry Potter")
}

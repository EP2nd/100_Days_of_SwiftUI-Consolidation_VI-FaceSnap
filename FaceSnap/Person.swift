//
//  User.swift
//  FaceSnap
//
//  Created by Edwin Przeźwiecki Jr. on 11/02/2023.
//

import Foundation
import MapKit

class SharedPeople: ObservableObject {
    
    @Published var personDetails = [Person]().sorted() {
        didSet {
            if let encodedPeople = try? JSONEncoder().encode(personDetails) {
                UserDefaults.standard.set(encodedPeople, forKey: "people")
            }
        }
    }
    
    init() {
        if let savedPeople = UserDefaults.standard.data(forKey: "people") {
            if let decodedPeople = try? JSONDecoder().decode([Person].self, from: savedPeople) {
                personDetails = decodedPeople
                return
            }
        }
        
        personDetails = []
    }
}

struct Person: Codable, Equatable, Identifiable, Comparable {
    
    var id = UUID()
    var photoID: String
    var name: String
    
    var latitude: Double
    var longitude: Double
    
    var coordinate: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static func <(lhs: Person, rhs: Person) -> Bool {
        lhs.name < rhs.name
    }
    
    static var example = Person(id: UUID(), photoID: "", name: "Harry Potter", latitude: 51.501, longitude: -0.141)
}

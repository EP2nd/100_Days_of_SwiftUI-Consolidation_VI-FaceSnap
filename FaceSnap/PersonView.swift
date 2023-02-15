//
//  PersonView.swift
//  FaceSnap
//
//  Created by Edwin Przeźwiecki Jr. on 14/02/2023.
//

import MapKit
import SwiftUI

struct PersonView: View {
    
    let person: Person
    
    static var latitude = 0.0
    static var longitude = 0.0
    
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: latitude, longitude: longitude), span: MKCoordinateSpan(latitudeDelta: 30, longitudeDelta: 30))
    
    var body: some View {
            GeometryReader { geometry in
                ScrollView {
                    VStack {
                        ZStack {
                            Rectangle()
                                .frame(width: geometry.size.width, height: geometry.size.height * 0.7)
                            
                            VStack {
                                Spacer()
                                Spacer()
                                
                                if let loadedImage = UIImage.loadImageFromDisk(imageName: person.photoID) {
                                    Image(uiImage: loadedImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(maxWidth: geometry.size.width * 0.9, maxHeight: geometry.size.height * 0.5)
                                        .clipped()
                                } else {
                                    Text("No image")
                                }
                                
                                Spacer()
                                Spacer()
                                
                                Text(person.name)
                                    .font(.custom("Chalkduster", fixedSize: 32))
                                    .foregroundColor(.black)
                                
                                Spacer()
                                Spacer()
                            }
                        }
                        
                        Text("You might have met here:")
                            .foregroundColor(.white)
                            .padding(.vertical)
                        
                        Map(coordinateRegion: $mapRegion, annotationItems: [person]) { _ in
                            MapMarker(coordinate: person.coordinate)
                        }
                        .frame(width: 300, height: 300)
                    }
                }
            }
    }
    
    init(person: Person) {
        self.person = person
        PersonView.latitude = person.latitude
        PersonView.longitude = person.longitude
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(person: Person.example)
    }
}

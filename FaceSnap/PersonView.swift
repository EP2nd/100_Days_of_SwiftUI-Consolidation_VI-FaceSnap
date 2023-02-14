//
//  PersonView.swift
//  FaceSnap
//
//  Created by Edwin Przeźwiecki Jr. on 14/02/2023.
//

import SwiftUI

struct PersonView: View {
    
    let person: Person
    
    var body: some View {
            GeometryReader { geometry in
                ScrollView {
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
                }
            }
    }
}

struct PersonView_Previews: PreviewProvider {
    static var previews: some View {
        PersonView(person: Person.example)
    }
}

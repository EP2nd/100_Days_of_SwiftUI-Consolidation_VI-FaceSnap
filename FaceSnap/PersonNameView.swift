//
//  PersonNameView.swift
//  FaceSnap
//
//  Created by Edwin Przeźwiecki Jr. on 11/02/2023.
//

import SwiftUI

struct PersonNameView: View {
    
    @ObservedObject var users: SharedPeople
    
    @Binding var image: UIImage?
    @Binding var imageID: String?
    
    @State private var name = ""
    
    @Environment(\.dismiss) var dismiss
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedFaces")
    
    var body: some View {
        NavigationView {
            Form {
                Section("Photograph:") {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                    }
                }
                
                Section("Name:") {
                    TextField("", text: $name)
                }
            }
            .navigationTitle("New Person")
            .toolbar {
                Button("Save") {
                    if let imageID = imageID {
                        let person = Person(photoID: imageID, name: name)
                        print("Saved person: \(person)")
                        users.personDetails.append(person)
                        dismiss()
                    }       
                }
            }
        }
    }
}

struct PersonNameView_Previews: PreviewProvider {
    static var previews: some View {
        PersonNameView(users: SharedPeople(), image: .constant(UIImage(contentsOfFile: "")), imageID: .constant(""))
    }
}

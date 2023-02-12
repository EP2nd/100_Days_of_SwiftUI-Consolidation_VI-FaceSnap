//
//  PersonNameView.swift
//  FaceSnap
//
//  Created by Edwin Przeźwiecki Jr. on 11/02/2023.
//

import SwiftUI

struct PersonNameView: View {
    
    @ObservedObject var users: SharedPeople
    
    var imageID: String
    
    @State private var name = ""
    
    @Environment(\.dismiss) var dismiss
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedFaces")
    
    var body: some View {
        NavigationView {
            Form {
                Section("Photograph") {
                    Image(uiImage: UIImage(systemName: imageID)!)
                        .onAppear {
                            savePath.loadImage(UIImage(systemName: imageID))
                        }
                }
                
                Section("Name") {
                    TextField("", text: $name)
                }
            }
            .navigationTitle("New Person")
        }
        .toolbar {
            Button("Save") {
                let person = Person(photoID: imageID, name: name)
                users.personDetails.append(person)
                save()
                dismiss()
            }
        }
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(users.personDetails)
            try data.write(to: savePath, options: [.atomic, .completeFileProtection])
        } catch {
            print("Unable to save data.")
        }
    }
}

struct PersonNameView_Previews: PreviewProvider {
    static var previews: some View {
        PersonNameView(users: SharedPeople(), imageID: "")
    }
}

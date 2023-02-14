//
//  ContentView.swift
//  FaceSnap
//
//  Created by Edwin Przeźwiecki Jr. on 11/02/2023.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject private var users = SharedPeople()
    
    @State private var showingImagePicker = false
    @State private var askingForUsername = false
    
    @State private var inputImage: UIImage?
    @State private var imageID: String?
    
    let savePath = FileManager.documentsDirectory
    
    var body: some View {
        NavigationView {
            Form {
                List {
                    ForEach(users.personDetails) { person in
                        NavigationLink {
                            PersonView(person: person)
                        } label: {
                            HStack {
                                if let loadedImage = UIImage.loadImageFromDisk(imageName: person.photoID) {
                                    Image(uiImage: loadedImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 100)
                                        .clipped()
                                } else {
                                    Text("No image")
                                }
                                
                                Text(person.name)
                            }
                            
                        }
                    }
                    .onDelete(perform: removePerson)
                }
            }
            .navigationTitle("FaceSnap")
            .toolbar {
                Button {
                    showingImagePicker = true
                } label: {
                    Label("Add User", systemImage: "plus")
                }
            }
            .onChange(of: inputImage) { _ in
                if let jpegData = inputImage?.jpegData(compressionQuality: 0.8) {
                    let uuid = UUID().uuidString
                    imageID = uuid
                    
                    try? jpegData.write(to: savePath.appendingPathComponent(uuid), options: [.atomic, .completeFileProtection])
                    
                    askingForUsername = true
                }
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .sheet(isPresented: $askingForUsername) {
                PersonNameView(users: users, image: $inputImage, imageID: $imageID)
            }
        }
        .preferredColorScheme(.dark)
    }
    
    func removePerson(at offsets: IndexSet) {
        deletePerson(at: offsets, in: users.personDetails)
    }
    
    func deletePerson(at offsets: IndexSet, in personArray: [Person]) {
        var personToRemove = IndexSet()
        var imageName: String = ""
        
        for offset in offsets {
            let person = personArray[offset]
            imageName = person.photoID
            
            if let index = users.personDetails.firstIndex(of: person) {
                personToRemove.insert(index)
            }
        }
        
        users.personDetails.remove(atOffsets: personToRemove)
        
        do {
            try FileManager.default.removeItem(atPath: savePath.appendingPathComponent(imageName).path)
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

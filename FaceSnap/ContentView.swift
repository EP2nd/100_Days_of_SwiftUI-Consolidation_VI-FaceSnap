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
                List(users.personDetails.sorted()) { person in
                    HStack {
                        if let loadedImage = loadImageFromDisk(imageName: person.photoID) {
                            Image(uiImage: loadedImage)
                                .resizable()
                                .scaledToFit()
                        } else {
                            Text("No image")
                        }
                        
                        Text(person.name)
                    }
                }
                .padding()
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
    }
    
//    init() {
//        do {
//            let data = try Data(contentsOf: savePath)
//            users.personDetails = try JSONDecoder().decode([Person].self, from: data)
//        } catch {
//            users.personDetails = []
//        }
//    }
    
    func loadImageFromDisk(imageName: String) -> UIImage? {
        let imageURL = savePath.appendingPathComponent(imageName)
        print("imgUR: \(imageURL)")
        
        do {
            let imageData = try Data(contentsOf: imageURL)
            return UIImage(data: imageData)
        } catch {
            print("Error: \(error.localizedDescription)")
            return nil
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

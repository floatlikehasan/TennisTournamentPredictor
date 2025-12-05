// Final Project
// Name: Hasan Dababo
// Date: 12/03/2025
// Description: This project creates an interface where the user can input tennis players and rank them against each other to see which ones perform the best.

import SwiftUI
import PhotosUI

struct AddPlayerView: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: TournamentViewModel
    
    @State private var name: String = ""
    @State private var serve: Int = 50
    @State private var forehand: Int = 50
    @State private var backhand: Int = 50
    @State private var movement: Int = 50
    @State private var consistency: Int = 50
    @State private var mentalToughness: Int = 50
    @State private var recentForm: Int = 50
    
    @State private var selectedItem: PhotosPickerItem? = nil
    @State private var imageData: Data? = nil
    
    var body: some View {
        Form {
            Section(header: Text("Player Info")) {
                TextField("Name", text: $name)
                
                HStack {
                    if let data = imageData,
                       let uiImage = UIImage(data: data) {
                        Image(uiImage: uiImage)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .clipShape(Circle())
                    } else {
                        Image(systemName: "person.crop.circle")
                            .font(.system(size: 40))
                            .foregroundColor(.gray)
                    }
                    
                    PhotosPicker("Choose Photo", selection: $selectedItem, matching: .images)
                        .onChange(of: selectedItem) { oldValue, newValue in
                            if let item = newValue {
                                Task {
                                    if let data = try? await item.loadTransferable(type: Data.self) {
                                        imageData = data
                                    }
                                }
                            }
                        }
                }
            }
            
            Section(header: Text("Skill Ratings (0 - 100)")) {
                StatInputRow(title: "Serve", value: $serve)
                StatInputRow(title: "Forehand", value: $forehand)
                StatInputRow(title: "Backhand", value: $backhand)
                StatInputRow(title: "Movement", value: $movement)
                StatInputRow(title: "Consistency", value: $consistency)
                StatInputRow(title: "Mental Toughness", value: $mentalToughness)
                StatInputRow(title: "Recent Form", value: $recentForm)
            }
            
            Section {
                Button("Save Player") {
                    let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
                    
                    viewModel.addPlayer(
                        name: trimmedName,
                        serve: serve,
                        forehand: forehand,
                        backhand: backhand,
                        movement: movement,
                        consistency: consistency,
                        mentalToughness: mentalToughness,
                        recentForm: recentForm,
                        imageData: imageData
                    )
                    
                    dismiss()
                }
                .disabled(name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty)
            }
        }
        .navigationTitle("Add Player")
    }
}



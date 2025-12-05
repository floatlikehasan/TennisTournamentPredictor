// Final Project
// Name: Hasan Dababo
// Date: 12/03/2025
// Description: This project creates an interface where the user can input tennis players and rank them against each other to see which ones perform the best.

import SwiftUI
import SwiftData
import UIKit


struct ContentView: View {
    @StateObject private var viewModel = TournamentViewModel()
    @State private var showResults = false
    @State private var isPressed = false
    
    @Environment(\.modelContext) private var modelContext
    @Query(sort: \TournamentSet.createdAt, order: .forward) private var allSets: [TournamentSet]
    
    var body: some View {
        NavigationStack {
            VStack {
                if viewModel.players.isEmpty {
                    Text("No players yet. Tap the + button to add one.")
                        .padding()
                        .multilineTextAlignment(.center)
                } else {
                    List {
                        ForEach(viewModel.players) { player in
                            HStack {
                                if let data = player.imageData,
                                   let uiImage = UIImage(data: data) {
                                    Image(uiImage: uiImage)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 40, height: 40)
                                        .clipShape(Circle())
                                } else {
                                    Image(systemName: "person.crop.circle")
                                        .font(.system(size: 32))
                                        .foregroundColor(.gray)
                                }
                                
                                VStack(alignment: .leading) {
                                    Text(player.name)
                                        .font(.headline)
                                    
                                    let rating = TournamentEngine.calculateRating(for: player)
                                    Text("Approx rating: \(String(format: "%.1f", rating))")
                                        .font(.caption)
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                        .onDelete(perform: viewModel.deletePlayer)
                    }
                }
                
                Button(action: {
                    if viewModel.players.count >= 2 {
                        viewModel.runSimulation()
                        if !viewModel.results.isEmpty {
                            saveCurrentSetToSwiftData()
                            showResults = true
                        }
                    }
                }) {
                    Text("Run Simulation")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(viewModel.players.count >= 2 ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                        .scaleEffect(isPressed ? 0.92 : 1.0)   // animate press
                        .animation(.spring(response: 0.25, dampingFraction: 0.55), value: isPressed)
                }
                .disabled(viewModel.players.count < 2)
                .simultaneousGesture(
                    DragGesture(minimumDistance: 0)
                        .onChanged { _ in
                            withAnimation {
                                isPressed = true
                            }
                        }
                        .onEnded { _ in
                            withAnimation {
                                isPressed = false
                            }
                        }
                )
                .padding()
                
                NavigationLink(
                    destination: ResultsView(viewModel: viewModel),
                    isActive: $showResults
                ) {
                    EmptyView()
                }
            }
            .navigationTitle("Tennis Predictor")
            .toolbar {
                NavigationLink(destination: AddPlayerView(viewModel: viewModel)) {
                    Image(systemName: "plus")
                }
            }
        }
    }
    
    private func saveCurrentSetToSwiftData() {
        let nextIndex = allSets.count + 1
        let title = "Set \(nextIndex)"
        let winnerName = viewModel.results.first?.player.name ?? "Unknown"
        
        let lines: [String] = viewModel.results.enumerated().map { index, result in
            let ratingString = String(format: "%.1f", result.rating)
            let probabilityString = percentString(from: result.winProbability)
            return "\(index + 1). \(result.player.name) - rating \(ratingString), win chance \(probabilityString)"
        }
        
        let newSet = TournamentSet(
            title: title,
            winnerName: winnerName,
            lines: lines
        )
        
        modelContext.insert(newSet)
    }
    
    private func percentString(from value: Double) -> String {
        let percentage = value * 100
        return "\(Int(percentage.rounded()))%"
    }
}

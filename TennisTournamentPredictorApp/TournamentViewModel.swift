// Final Project
// Name: Hasan Dababo
// Date: 12/03/2025
// Description: This project creates an interface where the user can input tennis players and rank them against each other to see which ones perform the best.


import Foundation
import Combine
import SwiftUI

class TournamentViewModel: ObservableObject {
    @Published var players: [Player] = []
    @Published var results: [PlayerResult] = []
    
    func addPlayer(name: String,
                   serve: Int,
                   forehand: Int,
                   backhand: Int,
                   movement: Int,
                   consistency: Int,
                   mentalToughness: Int,
                   recentForm: Int,
                   imageData: Data? = nil) {
        
        let trimmedName = name.trimmingCharacters(in: .whitespacesAndNewlines)
        if trimmedName.isEmpty {
            return
        }
        
        let newPlayer = Player(
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
        
        players.append(newPlayer)
    }
    
    func deletePlayer(at offsets: IndexSet) {
        // manual remove so we don't need SwiftUI in here
        for index in offsets.sorted(by: >) {
            players.remove(at: index)
        }
    }
    
    func runSimulation() {
        results = TournamentEngine.simulateTournament(players: players)
    }
}

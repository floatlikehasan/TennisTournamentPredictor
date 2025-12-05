// Final Project
// Name: Hasan Dababo
// Date: 12/03/2025
// Description: This project creates an interface where the user can input tennis players and rank them against each other to see which ones perform the best.

import Foundation

// singular player represents
struct Player: Identifiable, Equatable, Hashable {
    let id = UUID()
    
    var name: String
    var serve: Int
    var forehand: Int
    var backhand: Int
    var movement: Int
    var consistency: Int
    var mentalToughness: Int
    var recentForm: Int
    var imageData: Data?      
}

struct PlayerResult: Identifiable {
    let id = UUID()
    let player: Player
    let rating: Double
    let winProbability: Double
}

// does the math here
struct TournamentEngine {
    
    // calculate a single overall rating for a player based on their stats, multiplys the amount inputted by player by constants weighted (ex. .18, .17, etc.)
    static func calculateRating(for player: Player) -> Double {
        let serveWeight = 0.18
        let forehandWeight = 0.17
        let backhandWeight = 0.15
        let movementWeight = 0.15
        let consistencyWeight = 0.15
        let mentalWeight = 0.10
        let recentFormWeight = 0.10
        
        let rating =
            Double(player.serve) * serveWeight +
            Double(player.forehand) * forehandWeight +
            Double(player.backhand) * backhandWeight +
            Double(player.movement) * movementWeight +
            Double(player.consistency) * consistencyWeight +
            Double(player.mentalToughness) * mentalWeight +
            Double(player.recentForm) * recentFormWeight
        
        return rating
    }
    
    // take all players and get rating, turn that into a ranking and win probabilities
    static func simulateTournament(players: [Player]) -> [PlayerResult] {
        if players.isEmpty {
            return []
        }
        
        let ratedPlayers: [PlayerResult] = players.map { player in
            let rating = calculateRating(for: player)
            return PlayerResult(player: player, rating: rating, winProbability: 0)
        }
        
        let totalRating = ratedPlayers.reduce(0.0) { partial, result in
            partial + result.rating
        }
        
        // avoid division by zero because it might break the system
        if totalRating == 0 {
            return ratedPlayers
        }
        
        var finalResults: [PlayerResult] = ratedPlayers.map { result in
            let probability = result.rating / totalRating
            return PlayerResult(player: result.player, rating: result.rating, winProbability: probability)
        }
        
        finalResults.sort { first, second in
            first.rating > second.rating
        }
        
        return finalResults
    }
}

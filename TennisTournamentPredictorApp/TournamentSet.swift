// Final Project
// Name: Hasan Dababo
// Date: 12/03/2025
// Description: This project creates an interface where the user can input tennis players and rank them against each other to see which ones perform the best.


import Foundation
import SwiftData

@Model
class TournamentSet {
    var createdAt: Date
    var title: String
    var winnerName: String
    var lines: [String]
    
    init(createdAt: Date = Date(), title: String, winnerName: String, lines: [String]) {
        self.createdAt = createdAt
        self.title = title
        self.winnerName = winnerName
        self.lines = lines
    }
}

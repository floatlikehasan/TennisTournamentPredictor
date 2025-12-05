// Final Project
// Name: Hasan Dababo
// Date: 12/03/2025
// Description: This project creates an interface where the user can input tennis players and rank them against each other to see which ones perform the best.

import SwiftUI
import SwiftData

struct SetDetailView: View {
    let set: TournamentSet
    
    var body: some View {
        List {
            Section(header: Text("Info")) {
                Text("Winner: \(set.winnerName)")
                Text(set.createdAt.formatted(date: .long, time: .shortened))
                    .foregroundColor(.gray)
                    .font(.caption)
            }
            
            Section(header: Text("Ranking")) {
                ForEach(set.lines, id: \.self) { line in
                    Text(line)
                }
            }
        }
        .navigationTitle(set.title)
    }
}

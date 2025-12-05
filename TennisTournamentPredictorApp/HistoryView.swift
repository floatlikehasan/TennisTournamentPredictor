// Final Project
// Name: Hasan Dababo
// Date: 12/03/2025
// Description: This project creates an interface where the user can input tennis players and rank them against each other to see which ones perform the best.


import SwiftUI
import SwiftData

struct HistoryView: View {
    @Query(sort: \TournamentSet.createdAt, order: .reverse) private var sets: [TournamentSet]
    
    var body: some View {
        NavigationStack {
            List {
                if sets.isEmpty {
                    Text("No saved sets yet.\nRun a simulation to create one.")
                        .multilineTextAlignment(.center)
                } else {
                    ForEach(sets) { set in
                        NavigationLink(destination: SetDetailView(set: set)) {
                            VStack(alignment: .leading) {
                                Text(set.title)
                                    .font(.headline)
                                
                                Text("Winner: \(set.winnerName)")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                Text(set.createdAt.formatted(date: .abbreviated, time: .shortened))
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                }
            }
            .navigationTitle("History")
        }
    }
}

import SwiftUI

struct ResultsView: View {
    @ObservedObject var viewModel: TournamentViewModel
    
    var body: some View {
        VStack(alignment: .leading) {
            if let winner = viewModel.results.first {
                Text("Predicted Winner")
                    .font(.title2)
                    .bold()
                
                Text("\(winner.player.name)")
                    .font(.title3)
                    .padding(.bottom, 2)
                
                Text("Win chance: \(percentString(from: winner.winProbability))")
                    .font(.subheadline)
                    .foregroundColor(.gray)
                    .padding(.bottom)
            } else {
                Text("No results yet. Go back and run the simulation.")
                    .padding()
            }
            
            if !viewModel.results.isEmpty {
                Text("Full Ranking")
                    .font(.headline)
                    .padding(.bottom, 4)
                
                List(viewModel.results) { result in
                    HStack {
                        VStack(alignment: .leading) {
                            Text(result.player.name)
                                .font(.body)
                            
                            Text("Rating: \(String(format: "%.1f", result.rating))")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        Spacer()
                        Text(percentString(from: result.winProbability))
                            .font(.subheadline)
                    }
                }
            }
        }
        .padding()
        .navigationTitle("Simulation Results")
    }
    
    // turn 0.245 into "24%" etc
    func percentString(from value: Double) -> String {
        let percentage = value * 100
        return "\(Int(percentage.rounded()))%"
    }
}

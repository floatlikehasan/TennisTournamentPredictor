// Final Project
// Name: Hasan Dababo
// Date: 12/03/2025
// Description: This project creates an interface where the user can input tennis players and rank them against each other to see which ones perform the best.


import SwiftUI
import SwiftData

@main
struct TennisTournamentPredictorApp: App {
    var body: some Scene {
        WindowGroup {
            RootView()
        }
        .modelContainer(for: [TournamentSet.self])
    }
}

struct RootView: View {
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    Label("Players", systemImage: "person.3")
                }
            
            HistoryView()
                .tabItem {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }
        }
    }
}


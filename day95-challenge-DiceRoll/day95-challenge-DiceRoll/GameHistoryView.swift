//
//  GameHistoryView.swift
//  day95-challenge-DiceRoll
//
//  Created by Rafael Badaró on 03/09/25.
//

import SwiftUI

struct GameHistoryView: View {
    var body: some View {
        List {
            ForEach(DataManager.shared.history) { game in
                VStack (alignment: .leading) {
                    Text("Game date: \(game.createdAt)")
                    VStack (alignment: .leading) {
                        Text("Dices:")
                        ForEach(game.dices) { gameDice in
                            Text("\(gameDice.numberOfSides)-sided -> \(gameDice.rolled ?? 0)")
                        }
                        Text("Total: \(game.totalRolled)")
                    }
                }
            }.onDelete(perform: deleteItems)
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        DataManager.shared.deleteGames(at: offsets)
    }
}

#Preview {
    GameHistoryView()
}

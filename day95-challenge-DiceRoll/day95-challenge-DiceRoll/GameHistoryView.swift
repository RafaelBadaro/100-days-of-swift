//
//  GameHistoryView.swift
//  day95-challenge-DiceRoll
//
//  Created by Rafael Badaró on 03/09/25.
//

import SwiftUI

struct GameHistoryView: View {
    let gameHistory: [GameHistory]
    var body: some View {
        List {
            ForEach(gameHistory) { game in
                VStack (alignment: .leading) {
                    Text("Game date: \(game.createdAt.formatted(.dateTime.day().month().year().hour().minute().second()))")
                    VStack (alignment: .leading) {
                        Text("Dices:")
                        ForEach(game.gameDices) { gameDice in
                            Text("\(gameDice.sides) -> \(gameDice.result ?? 0)")
                        }
                        Text("Total: \(game.total)")
                    }
                }
            }
            .onDelete(perform: deleteItems)
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        DataManager.shared.deleteGames(at: offsets)
    }
}

#Preview {
    GameHistoryView(gameHistory:
                        [
                            GameHistory(gameDices:
                                        [
                                            Dice(sides: .four, result: 4),
                                            Dice(sides: .six, result: 6)
                                        ],
                                     total: 4),
                            GameHistory(gameDices:
                                        [
                                            Dice(sides: .four, result: 4),
                                            Dice(sides: .six, result: 6)
                                        ],
                                     total: 4),
                        ]
    )
}

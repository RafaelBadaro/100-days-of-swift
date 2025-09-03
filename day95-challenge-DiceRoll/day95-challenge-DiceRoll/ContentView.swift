//
//  ContentView.swift
//  day95-challenge-DiceRoll
//
//  Created by Rafael Badaró on 31/08/25.
//

import SwiftUI

/*
 Your challenge this time can be easy or hard depending on how far you want to take it, but at its core the project is simple: you need to build an app that helps users roll dice then store the results they had.

 At the very least you should lets users roll dice, and also let them see results from previous rolls. However, if you want to push yourself further you can try one or more of the following:

 1- Let the user customize the dice that are rolled: how many of them, and what type: 4-sided, 6-sided, 8-sided, 10-sided, 12-sided, 20-sided, and even 100-sided.
 
 2- Show the total rolled on the dice.
 
 3- Store the results using JSON or SwiftData – anywhere they are persistent.
 
 4- Add haptic feedback when dice are rolled.
 
 5- For a real challenge, make the value rolled by the dice flick through various possible values before settling on the final figure.
 */

struct ContentView: View {
    @State private var isShowingGameCreationView: Bool = false
    @State private var isShowingHistoryView: Bool = false
    @State private var game: Game = Game()
    
    var body: some View {
        NavigationStack {
            ZStack {
                if !game.gameDices.isEmpty {
                    gameView
                } else {
                    emptyView
                }
            }
            .navigationTitle("Roll dice")
            .sheet(isPresented: $isShowingGameCreationView, onDismiss: createGame) {
                GameCreationView(game: $game)
            }
            .sheet(isPresented: $isShowingHistoryView) {
                GameHistoryView(gameHistory: DataManager.shared.games)
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("History") {
                        self.isShowingHistoryView = true
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Game config") {
                        self.isShowingGameCreationView = true
                    }
                }
            }
        }
    }
    
    func rollDices() {
        self.resetGame()
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        
        self.game.gameDices.forEach { gameDice in
            // Rola dado
            gameDice.rollDice()
            // Posso usar o ! porque sei que vai ter um result
            self.game.total += gameDice.result!
            generator.impactOccurred()
        }
        
        let gameHistory = GameHistory(gameDices: self.game.gameDices,
                                      total: self.game.total)
        DataManager.shared.insertGame(gameHistory)
    }
    
    func resetGame() {
        self.game.total = 0
        self.game.gameDices.forEach { gameDice in
            gameDice.result = nil
        }
    }
    
    func createGame() {
        self.game.total = 0
        self.game.gameDices = []
        self.game.createGameDices()
    }
}

private extension ContentView {
    private var gameView: some View {
        VStack {
            ForEach(game.gameDices) { gameDice in
                HStack {
                    Text("\(gameDice.sides.rawValue) sided dice")
                    
                    if let result = gameDice.result {
                        Text("- Result: \(result)")
                    }
                }
                .padding()
            }
            
            Text("Total rolled: \(game.total)")
                .padding()
            
            Button("Roll dice", action: rollDices)
                .buttonStyle(.borderedProminent)
        }
    }
    
    private var emptyView: some View {
        VStack {
            Text("No game created, please create one.")
            Button("Create game") {
                self.isShowingGameCreationView = true
            }
            .buttonStyle(.borderedProminent)
        }

    }
}

#Preview {
    ContentView()
}

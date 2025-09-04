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
    @State private var isShowingHistoryView: Bool = false
    @State private var gameManager = GameManager()
    
    var body: some View {
        NavigationStack {
            VStack {
                diceSidesView
                gameView
            }
            .navigationTitle("Dice roll")
            .sheet(isPresented: $isShowingHistoryView) {
                GameHistoryView()
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button("History") {
                        self.isShowingHistoryView = true
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Reset") {
                        self.resetGame()
                    }
                }
            }
            .onReceive(gameManager.timer) { time in
                if gameManager.isBtnDisabled {
                    gameManager.rollAndSaveGame()
                }
            }
        }
    }
    
    func resetGame() {
        self.gameManager.reset()
    }
}

private extension ContentView {
    private var diceSidesView : some View {
        HStack {
            ForEach(DiceSides.allCases, id: \.self) { sides in
                Button("\(sides.rawValue)") {
                    gameManager.addDice(sides)
                }
                .buttonStyle(.borderedProminent)
            }
        }
    }
    
    private var gameView: some View {
        ScrollView {
            if !gameManager.dices.isEmpty {
                diceView
                Button("Roll dices") {
                    gameManager.rollAndSaveGame()
                }
                .disabled(gameManager.isBtnDisabled)
                .buttonStyle(.borderedProminent)
            } else {
                emptyView
            }
        }
    }
    
    private var diceView: some View {
        VStack(alignment: .leading) {
            Text("Selected dices:")
            ForEach(gameManager.dices) { dice in
                HStack {
                    Text("\(dice.numberOfSides)-sided")
                    
                    if let result = dice.rolled {
                        Text("-> \(result)")
                    }
                }
            }
            
            if gameManager.totalRolled > 0 {
                Text("Result: \(gameManager.totalRolled)")
            }
        }
    }
    
    private var emptyView: some View {
        VStack {
            Text("No dices added, click the numbers to add them!")
        }
    }
}

#Preview {
    ContentView()
}

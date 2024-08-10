//
//  Game.swift
//  dice-game
//
//  Created by Rafael Badaró on 10/08/24.
//

import Foundation

class Game: ObservableObject {
    let defaultMessage = "Welcome to the dice game! Roll the dice and test your luck!"
    
    @Published var player1Score = 0
    @Published var player2Score = 0
    
    @Published var player1DiceResult: Int
    @Published var player2DiceResult: Int
    
    @Published var message: String
    
    init(player1Score: Int = 0, player2Score: Int = 0, player1DiceResult: Int = 0, player2DiceResult: Int  = 0) {
        self.player1Score = 0
        self.player2Score = 0
        self.player1DiceResult = 0
        self.player2DiceResult = 0
        self.message = defaultMessage
    }
    
    func playGame(){
        player1DiceResult = Int.random(in: 1...6)
        player2DiceResult = Int.random(in: 1...6)
        
        if (player1DiceResult > player2DiceResult) {
            player1Score += 1
            message = "Player 1 wins!"
        } else if (player2DiceResult > player1DiceResult) {
            player2Score += 1
            message = "Player 2 wins!"
        } else {
            message = "Its a draw! No one wins!"
        }
            
        //clearDiceResults()
    }
    
    func clearDiceResults() {
        player1DiceResult = 0
        player2DiceResult = 0
    }
    
    func clearMessage(){
       message = defaultMessage
    }
    
    func restartGame() {
        player1Score = 0
        player2Score = 0
        clearDiceResults()
        clearMessage()
    }
}

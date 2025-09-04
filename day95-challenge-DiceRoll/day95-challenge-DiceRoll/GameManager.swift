//
//  File.swift
//  day95-challenge-DiceRoll
//
//  Created by Rafael Badaró on 03/09/25.
//

import Foundation
import Observation
import SwiftUI

@Observable
class GameManager {
    var dices: [Dice] = []
    
    static let MAX_TIME = 5
    var timeRemaining: Int = GameManager.MAX_TIME
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    var isBtnDisabled = false
    
    var totalRolled: Int {
        !self.isBtnDisabled ? dices.compactMap { $0.rolled }.reduce(0, +) : 0
    }
    
    func addDice(_ sides: DiceSides) {
        dices.append(Dice(numberOfSides: sides))
    }
    
    func rollAndSaveGame() {
        self.isBtnDisabled = true
        let generator = UIImpactFeedbackGenerator(style: .heavy)
        // rola todos os dados
        dices = dices.map { dice in
            var copy = dice
            copy.roll()
            generator.impactOccurred()
            return copy
        }

        if self.timeRemaining == 0 {
            self.isBtnDisabled = false
            self.timeRemaining = GameManager.MAX_TIME
            // salva a rodada como um novo "Game"
            let game = Game(dices: dices)
            DataManager.shared.insertGame(game)
        }
        
        self.timeRemaining -= 1
    }
    
    func reset() {
        dices = []
    }
}

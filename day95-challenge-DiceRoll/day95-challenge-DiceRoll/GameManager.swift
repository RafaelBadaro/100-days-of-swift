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
    
    var totalRolled: Int {
        dices.compactMap { $0.rolled }.reduce(0, +)
    }
    
    func addDice(_ sides: DiceSides) {
        dices.append(Dice(numberOfSides: sides))
    }
    
    func rollAndSaveGame() {
        // rola todos os dados
        let generator = UIImpactFeedbackGenerator(style: .heavy)
                        
        dices = dices.map { dice in
            var copy = dice
            copy.roll()
            generator.impactOccurred()
            return copy
        }
        
        // salva a rodada como um novo "Game"
        let game = Game(dices: dices)
        DataManager.shared.insertGame(game)
    }
    
    func reset() {
        dices = []
    }
}

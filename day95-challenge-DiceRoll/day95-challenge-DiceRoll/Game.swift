//
//  Game.swift
//  day95-challenge-DiceRoll
//
//  Created by Rafael Badaró on 03/09/25.
//

import Foundation

struct Game {
    var sidesAndQuantity: [DiceSides: Int] = [:] // Qual é o dado e quantos dele tem
    var total: Int = 0
    
    var gameDices: [Dice] = []
    
    mutating func createGameDices() {
        self.sidesAndQuantity.forEach { sides, quantity in
            for _ in 0..<quantity {
                let dice = Dice(sides: sides)
                gameDices.append(dice)
            }
        }
    }
}

struct GameHistory: Identifiable, Codable {
    var id = UUID()
    var createdAt: Date = Date()
    var gameDices: [Dice]
    var total: Int = 0
  
    init(gameDices: [Dice], total: Int) {
        self.gameDices = gameDices
        self.total = total
    }
}

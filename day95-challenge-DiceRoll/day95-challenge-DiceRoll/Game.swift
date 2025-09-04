//
//  Game.swift
//  day95-challenge-DiceRoll
//
//  Created by Rafael Badaró on 03/09/25.
//

import Foundation

struct Game: Identifiable, Codable {
    var id = UUID()
    var createdAt: Date = Date()
    let dices: [Dice]
    var totalRolled: Int {
        dices.compactMap { $0.rolled }.reduce(0, +)
    }
}

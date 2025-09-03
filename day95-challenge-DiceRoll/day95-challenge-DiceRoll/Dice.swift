//
//  Dice.swift
//  day95-challenge-DiceRoll
//
//  Created by Rafael Badaró on 03/09/25.
//

import Foundation
import Observation

enum DiceSides: Int, CaseIterable, Codable {
    case four = 4
    case six = 6
    case eight = 8
    case ten = 10
    case twelve = 12
    case twenty = 20
    case hundred = 100
}

@Observable
class Dice: Identifiable, Codable {
    var id = UUID()
    let sides: DiceSides
    var result: Int? = nil
    
    init(sides: DiceSides, result: Int? = nil) {
        self.sides = sides
        self.result = result
    }
    
    func rollDice() {
        self.result = Int.random(in: 1...sides.rawValue)
    }
}

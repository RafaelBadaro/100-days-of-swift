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

struct Dice: Identifiable, Codable {
    var id = UUID()
    let numberOfSides: DiceSides
    var rolled: Int? = nil
        
    mutating func roll() {
        self.rolled = Int.random(in: 1...numberOfSides.rawValue)
    }
}

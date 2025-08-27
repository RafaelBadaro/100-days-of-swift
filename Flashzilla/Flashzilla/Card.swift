//
//  Card.swift
//  Flashzilla
//
//  Created by Rafael Badaró on 20/08/25.
//

import Foundation

struct Card: Identifiable, Codable {
    var id: UUID = UUID()
    var prompt: String
    var answer: String
    
    static let example = Card(prompt: "Who is the MC in One Piece?", answer: "Monkey D. Luffy")
}

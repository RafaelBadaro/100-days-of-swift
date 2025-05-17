//
//  User.swift
//  SwiftDataProject
//
//  Created by Rafael Badaró on 16/05/25.
//

import Foundation
import SwiftData

@Model
class User {
    var name: String
    var city: String
    var joinDate: Date
    // O deleteRule: .cascade faz com que qualquer outra Relationship seja deletada
    // No nosso caso, quando um user for deletado, os jobs tambem são deletados do banco
    // Porem, se job tive algo como "location" que fosse outro @Model, esse "location" seria deletado tambem, e assim vai...
    @Relationship(deleteRule: .cascade) var jobs = [Job]()
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joinDate = joinDate
    }
}

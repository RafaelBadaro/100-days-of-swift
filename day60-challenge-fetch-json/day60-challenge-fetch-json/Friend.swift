//
//  Friend.swift
//  day60-challenge-fetch-json
//
//  Created by Rafael Badaró on 25/05/25.
//

import Foundation

struct Friend: Identifiable, Codable, Hashable {
    var id: String
    var name: String
}

//
//  Book.swift
//  Bookworm
//
//  Created by Rafael Badaró on 05/05/25.
//

import Foundation
import SwiftData

@Model
class Book {
    var title: String
    var author: String
    var genre: String
    var review: String
    var rating: Int
    var dateAdded: Date = Date.now
    
    init(title: String,
         author: String,
         genre: String,
         review: String,
         rating: Int) {
        self.title = title
        self.author = author
        self.genre = genre
        self.review = review
        self.rating = rating
    }
}

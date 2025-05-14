//
//  AddBookView.swift
//  Bookworm
//
//  Created by Rafael Badaró on 05/05/25.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.dismiss) var dismiss
    @Environment(\.modelContext) var modelContext
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var rating = 3
    
    private var isFormValid: Bool {
        return self.propertiesNotEmpty() && self.propertiesNotWhiteSpaces()
    }
    
    let genres = ["Fantasy", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller"]
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of a book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    RatingView(rating: $rating)
                }
                
                Section {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        
                        modelContext.insert(newBook)
                        dismiss()
                    }
                    .disabled(!isFormValid)
                }
            }
            .navigationTitle("Add Book")
        }
    }
    
    private func propertiesNotEmpty() -> Bool {
        return !title.isEmpty && !author.isEmpty && !review.isEmpty
    }
    
    private func propertiesNotWhiteSpaces() -> Bool {
        return !title.trimmingCharacters(in: .whitespaces).isEmpty &&
        !author.trimmingCharacters(in: .whitespaces).isEmpty &&
        !review.trimmingCharacters(in: .whitespaces).isEmpty
    }
}

#Preview {
    AddBookView()
}
